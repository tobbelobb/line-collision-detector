cmake_minimum_required(VERSION 3.13)

add_executable(line_collision_detector
               src/line_collision_detector)

target_include_directories(line_collision_detector
                           include/)

add_subdirectory(test)
