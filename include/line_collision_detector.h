#pragma once

class LineCollisionDetector
{
  public:
    [[nodiscard]] bool isCollision(PivotPoints const& pivotPoints, ClosedFlatPath const& path);
};
