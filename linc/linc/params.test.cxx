#include <iostream>

#include <linc/params.hxx>

int main(int argc, char **argv) {
  std::string const inString{"effector-pivot-A1: ( 220,  -140.0, 130.0 ) "};
  Params::PivotTokens const got = tokenize(inString);

  Params::PivotTokens const expected{"effector-pivot-A1", "220", "-140.0",
                                     "130.0"};
  if (not(got == expected)) {
    std::cout << "Expected: " << expected << '\n';
    std::cout << "Got:      " << got << '\n';
    return 1;
  }

  if (argc > 1) {
    Params params{argv[1]};
    std::cout << params << '\n';
  }

  return 0;
}
