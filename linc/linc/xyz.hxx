#pragma once

struct Xyz {
  double x;
  double y;
  double z;

  Xyz(double x_in, double y_in, double z_in) : x(x_in), y(y_in), z(z_in) {}
  Xyz() : x(0.0), y(0.0), z(0.0) {}
};
