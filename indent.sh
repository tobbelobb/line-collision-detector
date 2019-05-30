#!/usr/bin/env bash

# Requires cmake-format
# Install with:
#   pip install cmake-format

find . -name CMakeLists.txt -exec cmake-format --config-file .cmake-format.json --in-place {} \;
