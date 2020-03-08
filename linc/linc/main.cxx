#include <iostream>
#include <linc/linc.hxx>
#include <linc/triangle-mesh.hxx>

int main(int argc, char *argv[]) {

  if (argc < 2) {
    std::cerr << "Usage:\n" << argv[0] << " <filename>\n";
    return 1;
  }

  TriangleMesh mesh;
  if (not mesh.readStlFile(argv[1])) {
    std::cerr << "Failed to open file\n";
    return 1;
  }

  std::cout << "Hello, World!\n";
  return 0;
}
