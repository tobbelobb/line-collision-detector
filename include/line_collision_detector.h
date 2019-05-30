#pragma once
#include <pivot_points.h>
#include <closed_flat_path.h>

class LineCollisionDetector
{
  public:
    [[nodiscard]] bool isCollision(PivotPoints const& pivotPoints, ClosedFlatPath const& path);
};
