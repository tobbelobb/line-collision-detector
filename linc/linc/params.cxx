#include <algorithm>
#include <cctype>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <locale>
#include <set>
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

// remove all non-number
// trim from start and end (in place)
static inline void lrTrimNonNumber(std::string &s) {
  auto isNumber = [](unsigned char ch) {
    return std::isdigit(ch) or ch == '-' or ch == '.';
  };
  s.erase(s.begin(), std::find_if(s.begin(), s.end(), isNumber));
  s.erase(std::find_if(s.rbegin(), s.rend(), isNumber).base(), s.end());
}

static inline float toFloat(std::string const &s) {
  size_t charCount = 0;
  float res = std::stof(s, &charCount);
  if (s.size() != charCount) {
    throw std::invalid_argument("Could not parse all characters");
  }
  return res;
}

PivotTokens tokenize(std::string const &line) {
  PivotTokens tokens{};
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

static size_t pivotNameToColumn(std::string const &name) {
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
  return 6;
}

static bool valid(PivotTokens const &tokens) {
  if (tokens.hasEmptyMember()) {
    return false;
  }
  if (not tokens.isEffector() and not tokens.isAnchor()) {
    std::cerr
        << "Invalid pivot name does not start with 'effector' or 'anchor': "
        << tokens.name << '\n';
    return false;
  }
  if (pivotNameToColumn(tokens.name) > 5) {
    std::cerr << "Invalid pivot name does not end with 'A1', 'A2', 'B1', 'B2', "
                 "'C1', or 'C2': "
              << tokens.name << '\n';
    return false;
  }
  for (auto const &token : {tokens.x, tokens.y, tokens.z}) {
    try {
      float const tmp = toFloat(token);
    } catch (std::exception const &e) {
      std::cerr << "Could not convert to float: " << token << '\n';
      std::cerr << e.what() << '\n';
      return false;
    }
  }
  return true;
}

Pivots::Pivots(std::string const &fileName) {
  std::ifstream fileStream{fileName};
  // whole file validation

  // line by line validation
  for (std::string line{""}; std::getline(fileStream, line);) {
    lTrimWhitespace(line);
    if (line.empty() or line[0] == '#') {
      continue;
    }
    save(tokenize(line));
  }
}

void Pivots::save(PivotTokens const &tokens) {
  auto const col = pivotNameToColumn(tokens.name);
  if (tokens.isEffector()) {
    effector(0, col) = toFloat(tokens.x);
    effector(1, col) = toFloat(tokens.y);
    effector(2, col) = toFloat(tokens.z);
  }
  if (tokens.isAnchor()) {
    anchors(0, col) = toFloat(tokens.x);
    anchors(1, col) = toFloat(tokens.y);
    anchors(2, col) = toFloat(tokens.z);
  }
}

static bool validateFileAsAWhole(std::string const &fileName) {
  std::ifstream fileStream{fileName};
  if (fileStream.fail()) {
    std::cerr << "Failed to open " << fileName << '\n';
    return false;
  }
  std::set<std::string> const neededPivotNames = {
      "effector-pivot-A1", "effector-pivot-A2", "effector-pivot-B1",
      "effector-pivot-B2", "effector-pivot-C1", "effector-pivot-C2",
      "anchor-pivot-A1",   "anchor-pivot-A2",   "anchor-pivot-B1",
      "anchor-pivot-B2",   "anchor-pivot-C1",   "anchor-pivot-C2",
  };
  auto const lengthOfLongestNeededPivotName =
      (*std::max_element(neededPivotNames.begin(), neededPivotNames.end(),
                         [](std::string const s, std::string const s2) {
                           return s.size() < s2.size();
                         }))
          .size();
  auto remainingPivotNames = neededPivotNames;
  for (std::string line{""}; std::getline(fileStream, line);) {
    lTrimWhitespace(line);
    if (line.empty() or line[0] == '#') {
      continue;
    }
    for (auto const &neededName : neededPivotNames) {
      if (line.substr(0, lengthOfLongestNeededPivotName).find(neededName) !=
          std::string::npos) {
        if (remainingPivotNames.find(neededName) == remainingPivotNames.end()) {
          std::cerr << "Found " << neededName << " twice in " << fileName
                    << '\n';
          return false;
        }
        remainingPivotNames.erase(neededName);
      }
    }
  }
  if (not remainingPivotNames.empty()) {
    for (auto const &pivotName : remainingPivotNames) {
      std::cerr << "Did not find " << pivotName << " in " << fileName << '\n';
    }
    return false;
  }
  return true;
}

// Look at each non-empty non-comment line and see
// if we have valid tokens there
static bool validateLineByLine(std::string const &fileName) {
  std::ifstream fileStream{fileName};
  for (std::string line{""}; std::getline(fileStream, line);) {
    if (line.empty() or line[0] == '#') {
      continue;
    }

    PivotTokens const tokens{tokenize(line)};
    if (not valid(tokens)) {
      std::cerr << "Invalid line:\n" << line << '\n';
      return false;
    }
  }
  return true;
}

bool validateParamsFile(std::string const &fileName) {
  bool valid = true;
  if (not validateFileAsAWhole(fileName)) {
    valid = false;
  }
  if (not validateLineByLine(fileName)) {
    valid = false;
  }
  return valid;
}
