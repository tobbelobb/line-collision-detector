#pragma once

#include <linc/xyz.hxx>

#include <array>

class PivotPoints {
  PivotPoints(Xyz eA1, Xyz eA2, Xyz eB1, Xyz eB2, Xyz eC1, Xyz eC2, Xyz aA1,
              Xyz aA2, Xyz aB1, Xyz aB2, Xyz aC1, Xyz aC2)
      : effectorPivots{eA1, eA2, eB1, eB2, eC1, eC2}, anchorPivots{eA1, eA2,
                                                                   eB1, eB2,
                                                                   eC1, eC2} {}

  std::array<Xyz, 6> effectorPivots;
  std::array<Xyz, 6> anchorPivots;
};
