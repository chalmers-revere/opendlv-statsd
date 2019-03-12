/*
 * Copyright (C) 2019  Christian Berger
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "cluon-complete.hpp"
#include "opendlv-standard-message-set.hpp"

#include <cstdint>
#include <iostream>
#include <memory>
#include <mutex>

int32_t main(int32_t argc, char **argv) {
    int32_t retCode{1};
    auto commandlineArguments = cluon::getCommandlineArguments(argc, argv);
    if ( (0 == commandlineArguments.count("cid") || 0 == commandlineArguments.count("field")) ) {
        std::cerr << argv[0] << " joins a running OD4 session to relay selected messages or message fields at a given samplerate to statsd." << std::endl;
        std::cerr << "Usage:   " << argv[0] << " --cid=<OD4 session> --field=<field name>:<sample rate> [--verbose]" << std::endl;
        std::cerr << "         --cid:    CID of the OD4Session to receive messages" << std::endl;
        std::cerr << "         --field:    name of the field to sample" << std::endl;
        std::cerr << "Example: " << argv[0] << " --cid=111 --field=Wgs84:5 --verbose" << std::endl;
    }
    else {
        const bool VERBOSE{commandlineArguments.count("verbose") != 0};
        
        const int UDP_PACKET_SIZE = 1462;
        const int MAX_PACKET_SIZE = UDP_PACKET_SIZE;
        
        //extract the sample rate from command parameter
        std::string field_arg = commandlineArguments["field"];
        std::string field = field_arg.substr(0,field_arg.find(":"));
        std::string sample_rate = field_arg.substr(field_arg.find(":")+1,field_arg.size());
        
        sample_rate = std::to_string(1/std::stod(sample_rate));


        // Interface to a running OpenDaVINCI session; here, you can receive messages.
        cluon::OD4Session od4{static_cast<uint16_t>(std::stoi(commandlineArguments["cid"]))};

        std::mutex dataMutex;               

        // TODO: In the following, there is an example to receive WGS84 GPS
        //       positions in a data triggered way. The type or fields of
        //       interest needs to be specified by the user as command line
        //       parameters and subsequently, the corresponding C++ lambdas
        //       would have to be created and registered.

        // Handler to receive a GPS message (realized as C++ lambda).
        
        std::vector<double> lat_queue,lon_queue; //vector is used as a queue
        
        auto onGPS = [&dataMutex,&lat_queue,&lon_queue,VERBOSE](cluon::data::Envelope &&env){
            // Now, we unpack the cluon::data::Envelope to get the desired WGS84Reading.
            opendlv::proxy::GeodeticWgs84Reading gps = cluon::extractMessage<opendlv::proxy::GeodeticWgs84Reading>(std::move(env));

            {
                //retrieve latitude and longitude from the GeodeticWgs84Reading
                double latitude=gps.latitude();
                double longitude=gps.longitude();   
                
                if(VERBOSE) 
                    std::cerr << "Got " << latitude << ", " << longitude << " as Envelopes" <<std::endl;
                
                std::lock_guard<std::mutex> lck(dataMutex);
                
                //push the data into queues
                lat_queue.insert(lat_queue.end(),latitude);
                lon_queue.insert(lon_queue.end(),longitude);

                // TODO: Temporarily store the desired field to be passed on to statsd in the time-trigger below.
            }
        };
        
        
        // Register our lambda for the message identifier for opendlv::proxy::GeodeticWgs84Reading.
        od4.dataTrigger(opendlv::proxy::GeodeticWgs84Reading::ID(), onGPS);
        
        // Time-triggered sender; TODO: reflect the desired sample rate via commandline.
        float FREQUENCY{std::stof(sample_rate+"f")};
        od4.timeTrigger(FREQUENCY, [&od4, &dataMutex, &lat_queue, &lon_queue ,VERBOSE](){
            {
                std::lock_guard<std::mutex> lck(dataMutex);
                
                std::stringstream ss;
                std::string packet;
                
                //the following loop will optimize the packet size to 1462 (or other specified)
                do{
                    double lat=0,lon=0;

                    //store first items in queues 
                    if(!lat_queue.empty()){
                        lat = lat_queue.back();
                    }


                    if(!lon_queue.empty()){
                        lon = lon_queue.back();
                    }
                    
                    //pack the stored items in statsd format
                    ss<<packet<<"la:"<<lat<<"|c"<<"\n"<<"lo:"<<lon<<"|c";
                    
                    if(ss.str().size()<=MAX_PACKET_SIZE){
                        if(!lat_queue.empty())
                            lat_queue.pop_back();
                        if(!lon_queue.empty())
                            lon_queue.pop_back();
                        
                        ss<<"\n";
                        packet = ss.str();
                        ss.str("");
                    }
                                     
                }while((packet.size() + ss.str().size())<=MAX_PACKET_SIZE-1);
                
                
                
                //create udp sender to statsd
                cluon::UDPSender s("127.0.0.1", 8125);
                
                //send the data through the udpsender
                std::pair<ssize_t, int32_t> retVal = s.send(packet+"");
                
                if(VERBOSE){
                    std::cout << "Test packet:" << std::endl << packet << std::endl << "Of size: " << packet.size();
                    std::cout << "Send " << retVal.first << " bytes, error code = " << retVal.second << std::endl;
                }
            }
            return od4.isRunning();
        });
        

        retCode = 0;
    }
    return retCode;
}

