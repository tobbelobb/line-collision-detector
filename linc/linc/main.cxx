#include <iostream>

#include <gsl/span_ext>

#include <linc/linc.hxx>
#include <linc/params.hxx>
#include <linc/triangle-mesh.hxx>

int main(int argc, char *argv[]) {

  if (not(argc == 3 or argc == 4)) {
    std::cerr << "Usage:\n"
              << *argv << " <3d-model> <params> [layer-height (mm)]\n";
    return 1;
  }

  gsl::span<char *> const args(argv, argc);
  auto const modelFileName = gsl::at(args, 1);
  auto const paramsFileName = gsl::at(args, 2);

  TriangleMesh mesh{modelFileName};
  if (not mesh.isGood()) {
    std::cerr << "Failed to load " << modelFileName << '\n';
    return 1;
  }

  if (not validateParamsFile(paramsFileName)) {
    std::cerr << "Validation of " << paramsFileName << " failed\n";
    return 1;
  }
  Pivots pivots{std::string{paramsFileName}};

  // TODO: millimeter type
  float layerHeight = 1.0;
  if (argc > 3) {
    layerHeight = std::stof(gsl::at(args, 3));
  }

  if (willCollide(mesh, pivots, layerHeight)) {
    std::cout << "Collision detected\n";
  } else {
    std::cout << "No collision detected\n";
  }

  return 0;
}
