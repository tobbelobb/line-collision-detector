#pragma once
#include <line-collision-detector/closed-flat-path.hxx>
#include <line-collision-detector/pivot-points.hxx>

class LineCollisionDetector {
public:
  [[nodiscard]] bool isCollision(PivotPoints const &pivotPoints,
                                 ClosedFlatPath const &path);
};
