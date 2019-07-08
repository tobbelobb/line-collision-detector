#!/usr/bin/env bash

find . -regex ".*\.\(hxx\|cxx\)" -not -path "./build/*" -not -path "./extern/*" -not -path "./bdep-configs/*" -exec clang-format -i {} +

# Requires shfmt
# Install with:
#   sudo snap install shfmt
shfmt -w ./*.sh
