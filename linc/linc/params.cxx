#include <algorithm>
#include <cctype>
#include <cstdlib>
#include <fstream>
#include <locale>
#include <sstream>
#include <string>

#include <linc/params.hxx>

// remove all ' ', '\n', '\r', '\f', '\t', '\v'
// trim from start (in place)
static inline void lTrimWhitespace(std::string &s) {
  s.erase(s.begin(), std::find_if(s.begin(), s.end(), [](unsigned char ch) {
            return not std::isspace(ch);
          }));
}

// remove all non-nonber
// trim from start and end (in place)
static inline void lrTrimNonNumber(std::string &s) {
  auto isNumber = [](unsigned char ch) {
    return std::isdigit(ch) or ch == '-';
  };
  s.erase(s.begin(), std::find_if(s.begin(), s.end(), isNumber));
  s.erase(std::find_if(s.rbegin(), s.rend(), isNumber).base(), s.end());
}

Params::Params(std::string const fileName) {
  std::ifstream fileStream{fileName};
  if (fileStream.fail()) {
    m_isGood = false;
    return;
  }
  for (std::string line{""}; std::getline(fileStream, line);) {
    // Skip whitespace
    lTrimWhitespace(line);
    // Comments start with #
    if (line.size() == 0 or line[0] == '#') {
      continue;
    }

    if (not save(tokenize(line))) {
      m_isGood = false;
      return;
    }
  }
  m_isGood = true;
}

size_t pivotNameToColumn(std::string const &name) {
  std::string const lastTwo = name.substr(name.size() - 2);
  if (lastTwo == "A1") {
    return 0;
  }
  if (lastTwo == "A2") {
    return 1;
  }
  if (lastTwo == "B1") {
    return 2;
  }
  if (lastTwo == "B2") {
    return 3;
  }
  if (lastTwo == "C1") {
    return 4;
  }
  if (lastTwo == "C2") {
    return 5;
  }
  return 0;
}

bool Params::save(PivotTokens const &tokens) {
  auto const col = pivotNameToColumn(tokens.name);
  if (tokens.isEffector()) {
    m_effectorPivots(0, col) = std::stof(tokens.x);
    m_effectorPivots(1, col) = std::stof(tokens.y);
    m_effectorPivots(2, col) = std::stof(tokens.z);
    return true;
  }

  if (tokens.isAnchor()) {
    m_anchorsPivots(0, col) = std::stof(tokens.x);
    m_anchorsPivots(1, col) = std::stof(tokens.y);
    m_anchorsPivots(2, col) = std::stof(tokens.z);
    return true;
  }
  return false;
}

Params::PivotTokens tokenize(std::string const &line) {
  Params::PivotTokens tokens{};
  std::stringstream ss(line);
  std::getline(ss, tokens.name, ':');
  std::getline(ss, tokens.x, ',');
  std::getline(ss, tokens.y, ',');
  std::getline(ss, tokens.z, ',');

  lrTrimNonNumber(tokens.x);
  lrTrimNonNumber(tokens.y);
  lrTrimNonNumber(tokens.z);

  return tokens;
}
