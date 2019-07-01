#pragma once
#include <line-collision-detector/closed_flat_path.hxx>
#include <line-collision-detector/pivot_points.hxx>

class LineCollisionDetector {
public:
  [[nodiscard]] bool isCollision(PivotPoints const &pivotPoints,
                                 ClosedFlatPath const &path);
};
