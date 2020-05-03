#pragma once

#include <Eigen/Dense>

/* Each line of params file will be split into
 * tokens by tokenize().
 * PivotTokens can be consumed
 * by Pivot class. */
struct PivotTokens;
PivotTokens tokenize(std::string const &line);

struct PivotTokens {
  std::string name{};
  std::string x{};
  std::string y{};
  std::string z{};

  bool isEffector() const { return name.substr(0, 8) == "effector"; }
  bool isAnchor() const { return name.substr(0, 6) == "anchor"; }

  bool hasEmptyMember() const {
    return name.empty() or x.empty() or y.empty() or z.empty();
  }

  bool operator==(PivotTokens const &other) const {
    return name == other.name and x == other.x and y == other.y and
           z == other.z;
  }
};

inline std::ostream &operator<<(std::ostream &os, PivotTokens const &tokens) {
  os << "name: \"" << tokens.name << "\" x: \"" << tokens.x << "\" y: \""
     << tokens.y << "\" z: \"" << tokens.z << '"';
  return os;
}

class Pivots {
public:
  Eigen::Matrix<float, 3, 6> effector = Eigen::MatrixXf::Zero(3, 6);
  Eigen::Matrix<float, 3, 6> anchors = Eigen::MatrixXf::Zero(3, 6);

  Pivots(std::string const &fileName);

private:
  void save(PivotTokens const &);
};

inline std::ostream &operator<<(std::ostream &os, Pivots const &pivots) {
  os << "effector:\n" << pivots.effector << '\n';
  os << "anchors:\n" << pivots.anchors << '\n';
  return os;
}

bool validateParamsFile(std::string const &fileName);
