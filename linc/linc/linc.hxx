#pragma once
#include <linc/pivot-points.hxx>

[[nodiscard]] bool isCollision(PivotPoints const &pivotPoints,
                               ClosedFlatPath const &path);
