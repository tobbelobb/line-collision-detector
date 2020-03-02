#include <linc/linc.hxx>

#if 0
#include <gtest/gtest.h>

TEST(LineCollisionDetectorTest, isCollision) {
  LineCollisionDetector lineCollisionDetector{};
  PivotPoints pivotPoints{};
  TriangleMesh mesh{};

  EXPECT_TRUE(lineCollisionDetector.isCollision(pivotPoints, mesh));
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
#endif
