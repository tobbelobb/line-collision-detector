#!/usr/bin/env bash

#mkdir -p build
#cd build
#CC=gcc CXX=g++ cmake ..
#make -j 4 line_collision_detector
#g++-9 -std=c++2a src/line_collision_detector.cpp -Iinclude -o line_collision_detector

docker run --rm -v "$PWD":/line-collision-detector -w /line-collision-detector -u user -it lincdev
# bdep init --config-create ../bdep-configs/gcc cc config.cxx=g++
