#!/usr/bin/env bash

docker build -t myimage:latest .
docker run -it myimage
