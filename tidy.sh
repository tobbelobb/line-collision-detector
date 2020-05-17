#!/usr/bin/env bash

# This script is executable from within the docker image
cd /line-collision-detector/linc
./make_compilation_database.sh
run-clang-tidy-10 -p=.. -checks="-*,cppcoreguidelines-*,modernize-*,bugprone-*,clang-analyzer-*,misc-*,performance-*,readability-*,cert-*,hicpp-*" -fix /line-collision-detector/linc/linc/*.cxx 2>/dev/null
