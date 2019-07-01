#pragma once

#include <array>

class Xyz {
private:
  double m_x;
  double m_y;
  double m_z;

public:
  Xyz(double x, double y, double z) : m_x(x), m_y(y), m_z(z) {}
  Xyz() : m_x(0.0), m_y(0.0), m_z(0.0) {}
  double x() { return m_x; }
  double y() { return m_y; }
  double z() { return m_z; }
};
