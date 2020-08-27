#!/usr/bin/env bash

docker run --rm -v "$PWD":/line-collision-detector -w /line-collision-detector -u user -it registry.gitlab.com/hangprinter/line-collision-detector
# bdep init --config-create ../bdep-configs/gcc cc config.cxx=g++
