#!/usr/bin/env bash

mkdir -p build
cd build
CC=gcc CXX=g++ cmake ..
make -j 4 line_collision_detector

#g++-9 -std=c++2a src/line_collision_detector.cpp -Iinclude -o line_collision_detector
