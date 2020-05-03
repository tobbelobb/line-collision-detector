#pragma once
#include <linc/params.hxx>
#include <linc/triangle-mesh.hxx>

[[nodiscard]] bool willCollide(TriangleMesh const &, Pivots const &, float);
