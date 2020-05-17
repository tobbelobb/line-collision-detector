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

  bool operator==(PivotTokens const &) const = default;
};

inline std::ostream &operator<<(std::ostream &os, PivotTokens const &tokens) {
  os << "name: \"" << tokens.name << "\" x: \"" << tokens.x << "\" y: \""
     << tokens.y << "\" z: \"" << tokens.z << '"';
  return os;
}

class Pivots {
public:
  static auto constexpr cols = 6;
  Eigen::Matrix<float, 3, cols> effector = Eigen::MatrixXf::Zero(3, cols);
  Eigen::Matrix<float, 3, cols> anchors = Eigen::MatrixXf::Zero(3, cols);
  enum ColumnIndex {
    A1 = 0,
    A2 = 1,
    B1 = 2,
    B2 = 3,
    C1 = 4,
    C2 = 5,
    INVALID = 6
  };

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
