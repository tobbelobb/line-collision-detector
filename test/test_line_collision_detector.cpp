#include <gtest/gtest.h>
#include <line_collision_detector.h>

TEST(LineCollisionDetectorTest, isCollision) {
  LineCollisionDetector lineCollisionDetector{};
  PivotPoints pivotPoints{};
  ClosedFlatPath path{};

  EXPECT_TRUE(lineCollisionDetector.isCollision(pivotPoints, path));
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
