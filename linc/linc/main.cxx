#include <iostream>
#include <linc/linc.hxx>
#include <linc/params.hxx>
#include <linc/triangle-mesh.hxx>

int main(int argc, char *argv[]) {

  if (argc < 3) {
    std::cerr << "Usage:\n" << argv[0] << " <3d-model> <params>\n";
    return 1;
  }

  TriangleMesh mesh{std::string{argv[1]}};
  if (not mesh.isGood()) {
    std::cerr << "Failed to load " << argv[1] << '\n';
    return 1;
  }

  if (not validateParamsFile(argv[2])) {
    std::cerr << "Validation of " << argv[2] << " failed\n";
    return 1;
  }
  Pivots pivots{std::string{argv[2]}};

  std::cout << "No collision detected\n";
  return 0;
}
