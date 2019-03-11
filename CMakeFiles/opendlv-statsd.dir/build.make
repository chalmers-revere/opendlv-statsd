# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/shab/Desktop/Research/Trial/opendlv-statsd-master

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/shab/Desktop/Research/Trial/opendlv-statsd-master

# Include any dependencies generated for this target.
include CMakeFiles/opendlv-statsd.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/opendlv-statsd.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/opendlv-statsd.dir/flags.make

opendlv-standard-message-set.hpp: src/opendlv-standard-message-set-v0.9.6.odvd
opendlv-standard-message-set.hpp: cluon-msc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/shab/Desktop/Research/Trial/opendlv-statsd-master/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating opendlv-standard-message-set.hpp"
	/home/shab/Desktop/Research/Trial/opendlv-statsd-master/cluon-msc --cpp --out=/home/shab/Desktop/Research/Trial/opendlv-statsd-master/opendlv-standard-message-set.hpp /home/shab/Desktop/Research/Trial/opendlv-statsd-master/src/opendlv-standard-message-set-v0.9.6.odvd

cluon-msc: src/cluon-complete-v0.0.120.hpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/shab/Desktop/Research/Trial/opendlv-statsd-master/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating cluon-msc"
	/usr/bin/cmake -E create_symlink /home/shab/Desktop/Research/Trial/opendlv-statsd-master/src/cluon-complete-v0.0.120.hpp /home/shab/Desktop/Research/Trial/opendlv-statsd-master/cluon-complete.hpp
	/usr/bin/cmake -E create_symlink /home/shab/Desktop/Research/Trial/opendlv-statsd-master/cluon-complete.hpp /home/shab/Desktop/Research/Trial/opendlv-statsd-master/cluon-complete.cpp
	/usr/bin/g++ -o /home/shab/Desktop/Research/Trial/opendlv-statsd-master/cluon-msc /home/shab/Desktop/Research/Trial/opendlv-statsd-master/cluon-complete.cpp -std=c++14 -pthread -D HAVE_CLUON_MSC

CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.o: CMakeFiles/opendlv-statsd.dir/flags.make
CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.o: src/opendlv-statsd.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/shab/Desktop/Research/Trial/opendlv-statsd-master/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.o"
	/usr/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.o -c /home/shab/Desktop/Research/Trial/opendlv-statsd-master/src/opendlv-statsd.cpp

CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.i"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/shab/Desktop/Research/Trial/opendlv-statsd-master/src/opendlv-statsd.cpp > CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.i

CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.s"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/shab/Desktop/Research/Trial/opendlv-statsd-master/src/opendlv-statsd.cpp -o CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.s

CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.o.requires:

.PHONY : CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.o.requires

CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.o.provides: CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.o.requires
	$(MAKE) -f CMakeFiles/opendlv-statsd.dir/build.make CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.o.provides.build
.PHONY : CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.o.provides

CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.o.provides.build: CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.o


# Object files for target opendlv-statsd
opendlv__statsd_OBJECTS = \
"CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.o"

# External object files for target opendlv-statsd
opendlv__statsd_EXTERNAL_OBJECTS =

opendlv-statsd: CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.o
opendlv-statsd: CMakeFiles/opendlv-statsd.dir/build.make
opendlv-statsd: /usr/lib/x86_64-linux-gnu/librt.a
opendlv-statsd: CMakeFiles/opendlv-statsd.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/shab/Desktop/Research/Trial/opendlv-statsd-master/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX executable opendlv-statsd"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/opendlv-statsd.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/opendlv-statsd.dir/build: opendlv-statsd

.PHONY : CMakeFiles/opendlv-statsd.dir/build

CMakeFiles/opendlv-statsd.dir/requires: CMakeFiles/opendlv-statsd.dir/src/opendlv-statsd.cpp.o.requires

.PHONY : CMakeFiles/opendlv-statsd.dir/requires

CMakeFiles/opendlv-statsd.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/opendlv-statsd.dir/cmake_clean.cmake
.PHONY : CMakeFiles/opendlv-statsd.dir/clean

CMakeFiles/opendlv-statsd.dir/depend: opendlv-standard-message-set.hpp
CMakeFiles/opendlv-statsd.dir/depend: cluon-msc
	cd /home/shab/Desktop/Research/Trial/opendlv-statsd-master && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/shab/Desktop/Research/Trial/opendlv-statsd-master /home/shab/Desktop/Research/Trial/opendlv-statsd-master /home/shab/Desktop/Research/Trial/opendlv-statsd-master /home/shab/Desktop/Research/Trial/opendlv-statsd-master /home/shab/Desktop/Research/Trial/opendlv-statsd-master/CMakeFiles/opendlv-statsd.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/opendlv-statsd.dir/depend

