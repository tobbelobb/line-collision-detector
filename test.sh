mkdir -p build
cd build
CC=gcc-9 CXX=g++-9 cmake ..
make -j 4 test_line_collision_detector test_xyz &&
test/test_xyz &&
test/test_line_collision_detector

#g++-9 -std=c++2a src/line_collision_detector.cpp -Iinclude -o line_collision_detector
