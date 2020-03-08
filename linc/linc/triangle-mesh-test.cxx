#include <gtest/gtest.h>
#include <linc/triangle-mesh.hxx>

TEST(TriangleMeshTest, Constuctor) { TriangleMesh t{}; }

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
