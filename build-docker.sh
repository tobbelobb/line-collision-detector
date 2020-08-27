#!/usr/bin/env bash

docker pull gcc
docker build -t registry.gitlab.com/hangprinter/line-collision-detector:latest .
