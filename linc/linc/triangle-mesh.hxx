#pragma once

#include <linc/stl.hxx>
#include <string>

struct TriangleMesh {
  stl_file m_stl;

  TriangleMesh() = delete; // You can not initialize based on nothing

  TriangleMesh(std::string const fileName) { m_stl = stl_open(fileName); }

  bool writeBinaryStl(std::string fileName) const;
  bool isInitialized() const { return m_stl.m_initialized; }
};
