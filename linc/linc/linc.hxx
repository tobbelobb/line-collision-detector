#pragma once
#include <linc/pivot-points.hxx>
#include <linc/triangle-mesh.hxx>

[[nodiscard]] bool isCollision(PivotPoints const &, TriangleMesh const &);
