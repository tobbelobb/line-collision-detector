#pragma once

#include <linc/stl.hxx>
#include <string>

class TriangleMesh {
public:
  stl_file m_stl;
  bool readStlFile(std::string fileName);
};
