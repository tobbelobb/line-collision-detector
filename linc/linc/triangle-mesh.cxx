#include <linc/triangle-mesh.hxx>

bool TriangleMesh::readStlFile(std::string fileName) {
  return stl_open(&m_stl, fileName.c_str());
}
