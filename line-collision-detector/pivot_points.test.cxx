#include <gtest/gtest.h>
#include <pivot_points.h>

TEST(PivotPointsTest, name) { EXPECT_EQ(1, 1); }

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
