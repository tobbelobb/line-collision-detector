#include <iostream>
#include <linc/linc.hxx>
#include <linc/triangle-mesh.hxx>

int main(int argc, char *argv[]) {

  if (argc < 3) {
    std::cerr << "Usage:\n" << argv[0] << " <3d-model> <params>\n";
    return 1;
  }

  TriangleMesh mesh{std::string{argv[1]}};
  if (not mesh.isInitialized()) {
    std::cerr << "Failed to load " << argv[1] << '\n';
    return 1;
  }

  std::cout << "Hello, World!\n";
  return 0;
}
