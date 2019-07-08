#include <line-collision-detector/line-collision-detector.hxx>

#if 0
#include <gtest/gtest.h>

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
#endif
