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
    if ( (0 == commandlineArguments.count("cid")) ) {
        std::cerr << argv[0] << " joins a running OD4 session to relay selected messages or message fields at a given samplerate to statsd." << std::endl;
        std::cerr << "Usage:   " << argv[0] << " --cid=<OD4 session> [--verbose]" << std::endl;
        std::cerr << "         --cid:    CID of the OD4Session to receive messages" << std::endl;
        std::cerr << "Example: " << argv[0] << " --cid=111 --verbose" << std::endl;
    }
    else {
        const bool VERBOSE{commandlineArguments.count("verbose") != 0};

        // Interface to a running OpenDaVINCI session; here, you can receive messages.
        cluon::OD4Session od4{static_cast<uint16_t>(std::stoi(commandlineArguments["cid"]))};

        std::mutex dataMutex;

        // TODO: In the following, there is an example to receive WGS84 GPS
        //       positions in a data triggered way. The type or fields of
        //       interest needs to be specified by the user as command line
        //       parameters and subsequently, the corresponding C++ lambdas
        //       would have to be created and registered.

        // Handler to receive a GPS message (realized as C++ lambda).
        auto onGPS = [&dataMutex](cluon::data::Envelope &&env){
            // Now, we unpack the cluon::data::Envelope to get the desired WGS84Reading.
            opendlv::proxy::GeodeticWgs84Reading gps = cluon::extractMessage<opendlv::proxy::GeodeticWgs84Reading>(std::move(env));

            {
                // TODO: Temporarily store the desired field to be passed on to statsd in the time-trigger below.
            }
        };

        // Register our lambda for the message identifier for opendlv::proxy::GeodeticWgs84Reading.
        od4.dataTrigger(opendlv::proxy::GeodeticWgs84Reading::ID(), onGPS);

        // Time-triggered sender; TODO: reflect the desired sample rate via commandline.
        const float ONE_HZ{1.0f};
        od4.timeTrigger(ONE_HZ, [&od4, &dataMutex](){
            {
                std::lock_guard<std::mutex> lck(dataMutex);
                // TODO: something with the WGS84 reading, i.e. forward to statsd.
            }
            return od4.isRunning();
        });

        retCode = 0;
    }
    return retCode;
}

