#include <iostream>
#include <linc/linc.hxx>
#include <linc/triangle-mesh.hxx>

int main() {

  TriangleMesh mesh;
  if (not mesh.ReadStlFile(path)) {
    std::cerr << "Failed to open file" << '\n';
    return 1;
  }

  std::cout << "Hello, World!" << '\n';
  return 0;
}
