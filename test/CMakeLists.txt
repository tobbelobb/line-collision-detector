add_test(test_line_collision_detector
         SRC
         test_line_collision_detector.cpp
         ../src/line_collision_detector.cpp
         INCLUDE
         ../include)

add_test(test_xyz
         SRC
         test_xyz.cpp
         INCLUDE
         ../include)

add_test(test_pivot_points
         SRC
         test_pivot_points.cpp
         INCLUDE
         ../include)
