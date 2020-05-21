#!/usr/bin/env bash

# This script is executable from within the docker image

find . -regex ".*\.\(h\+\+\|c\+\+\)" -not -path "./build/*" -not -path "./linc/extern/*" -not -path "./linc-gcc/*" -not -path "./linc-clang/*" -exec clang-format-10 -i {} +

shfmt -w ./*.sh
