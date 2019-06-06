#!/usr/bin/env bash

# Requires cmake-format
# Install with:
#   pip install cmake-format

find . -name CMakeLists.txt -exec cmake-format --config-file .cmake-format.json --in-place {} \;

# Requires clang-format
find . -regex ".*\.\(h\|cpp\)" -not -path "./build/*" -not -path "./extern/*" -exec clang-format -i {} +

# Requires shfmt
# Install with:
#   sudo snap install shfmt
shfmt -w ./*.sh
