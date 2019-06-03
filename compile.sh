#!/usr/bin/env bash

mkdir -p build
cd build
CC=gcc CXX=g++ cmake ..
cmake --build .

#g++-9 -std=c++2a src/line_collision_detector.cpp -Iinclude -o line_collision_detector
