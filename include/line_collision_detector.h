#pragma once
#include <closed_flat_path.h>
#include <pivot_points.h>

class LineCollisionDetector {
public:
  [[nodiscard]] bool isCollision(PivotPoints const &pivotPoints,
                                 ClosedFlatPath const &path);
};
