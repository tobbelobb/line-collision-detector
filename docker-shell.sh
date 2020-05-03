#!/usr/bin/env bash

docker run --rm -v "$PWD":/line-collision-detector -w /line-collision-detector -u user -it lincdev
# bdep init --config-create ../bdep-configs/gcc cc config.cxx=g++
