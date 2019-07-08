#!/usr/bin/env bash

# This script is executable from within the docker image

find . -regex ".*\.\(hxx\|cxx\)" -not -path "./build/*" -not -path "./extern/*" -not -path "./bdep-configs/*" -exec clang-format -i {} +

shfmt -w ./*.sh
