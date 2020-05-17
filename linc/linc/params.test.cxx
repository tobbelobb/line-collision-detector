#include <iostream>

#include <gsl/span_ext>

#include <linc/params.hxx>

int tokenizeWellFormedString() {
  std::string const inString{"effector-pivot-A1: ( 220,  -140.0, 130.0 ) "};
  PivotTokens const got = tokenize(inString);

  PivotTokens const expected{"effector-pivot-A1", "220", "-140.0", "130.0"};
  if (not(got == expected)) {
    std::cout << "Expected: " << expected << '\n';
    std::cout << "Got:      " << got << '\n';
    return 1;
  }
  return 0;
}

int tokenizeTooManyTokens() {
  std::string const inString{"effector-pivot-A1: 220, -140.0, 130.0, 123.4"};
  PivotTokens const got = tokenize(inString);
  PivotTokens const expected{"effector-pivot-A1", "220", "-140.0", "130.0"};
  if (not(got == expected)) {
    std::cout << "Expected: " << expected << '\n';
    std::cout << "Got:      " << got << '\n';
    return 1;
  }
  return 0;
}

int main(int argc, char **argv) {
  // Give testscript some output to assert on
  if (argc > 1) {
    gsl::span<char *> const args(argv, argc);
    auto const paramsFileName = gsl::at(args, 1);
    Pivots pivots{paramsFileName};
    std::cout << pivots << '\n';
  }

  int result = 0;
  result += tokenizeWellFormedString();
  result += tokenizeTooManyTokens();

  return result;
}
