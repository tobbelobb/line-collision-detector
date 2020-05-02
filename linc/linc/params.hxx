#pragma once

#include <Eigen/Dense>

struct Params {
  struct PivotTokens {
    std::string name{};
    std::string x{};
    std::string y{};
    std::string z{};

    bool operator==(PivotTokens const &other) const {
      return name == other.name and x == other.x and y == other.y and
             z == other.z;
    }

    bool isEffector() const { return name.substr(0, 8) == "effector"; }
    bool isAnchor() const { return name.substr(0, 6) == "anchor"; }
  };

  bool m_isGood = false;
  bool save(PivotTokens const &);

  Params(std::string fileName);

  Eigen::Matrix<float, 3, 6> m_effectorPivots = Eigen::MatrixXf::Zero(3, 6);
  Eigen::Matrix<float, 3, 6> m_anchorsPivots = Eigen::MatrixXf::Zero(3, 6);

  bool isGood() const { return m_isGood; }
};

Params::PivotTokens tokenize(std::string const &line);

inline std::ostream &operator<<(std::ostream &os,
                                Params::PivotTokens const &tokens) {
  os << "name: \"" << tokens.name << "\" x: \"" << tokens.x << "\" y: \""
     << tokens.y << "\" z: \"" << tokens.z << '"';
  return os;
}

inline std::ostream &operator<<(std::ostream &os, Params const &params) {
  os << "m_isGood: " << params.m_isGood << '\n';
  os << "m_effectorPivots:\n" << params.m_effectorPivots << '\n';
  os << "m_anchorsPivots:\n" << params.m_anchorsPivots << '\n';
  return os;
}
