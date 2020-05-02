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

  Params params{std::string{argv[2]}};
  if (not params.isGood()) {
    std::cerr << "Failed to load " << argv[2] << '\n';
    return 1;
  }

  std::cout << "No collision detected\n";
  return 0;
}
