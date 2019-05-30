mkdir build
cd build
CC=gcc-9 CXX=g++-9 cmake ..
cmake --build

#g++-9 -std=c++2a src/line_collision_detector.cpp -Iinclude -o line_collision_detector
