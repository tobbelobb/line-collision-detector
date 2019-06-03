cmake_minimum_required(VERSION 3.13)
include("./cmake/functions.cmake")

set(CMAKE_CXX_STANDARD
    20)

add_executable(line_collision_detector
               src/line_collision_detector.cpp
               src/main.cpp)

target_include_directories(line_collision_detector
                           PRIVATE include/)

add_subdirectory(test)
add_subdirectory(extern)
