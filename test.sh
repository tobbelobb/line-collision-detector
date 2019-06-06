mkdir -p build
cd build
CC=gcc CXX=g++ cmake ..
make -j 4 test_line_collision_detector test_xyz test_pivot_points &&
	test/test_xyz &&
	test/test_line_collision_detector &&
	test/test_pivot_points

#g++-9 -std=c++2a src/line_collision_detector.cpp -Iinclude -o line_collision_detector
