#if 0
#include <gtest/gtest.h>
#include <xyz.h>

TEST(XyzTest, ConstuctorAndAccessorsWork) {
  Xyz xyz{1.0, 2.0, 3.0};
  EXPECT_EQ(xyz.x(), 1.0);
  EXPECT_EQ(xyz.y(), 2.0);
  EXPECT_EQ(xyz.z(), 3.0);
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
#endif
