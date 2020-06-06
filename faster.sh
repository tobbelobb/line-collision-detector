#!/usr/bin/env bash

# This script does things that might make the build
# non-portable, but much faster to compile during development

# Build the static version of spdlog
cd /line-collision-detector/linc/extern/spdlog-1.6.0/
mkdir build && cd build && cmake .. && make -j

# Tell build2 to use it
cd /line-collision-detector/linc/linc/
sed --in-place "s/lib{spdlog_slow}/lib{spdlog}/" buildfile
