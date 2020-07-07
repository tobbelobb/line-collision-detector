#!/usr/bin/env bash

# You might have to do
# ulimit -c unlimited
# and maybe
# echo '/tmp/core.%h.%e.%t' > /proc/sys/kernel/core_pattern
# in the shell before you execute the command that generates the binary
# for the core dump to appear
# It should appear in your current directory
# open it with gdb <executable> <corefile>

docker run --rm --privileged --ulimit core=-1 --security-opt seccomp=unconfined -v "$PWD":/line-collision-detector -w /line-collision-detector -u user -it lincdev
# bdep init --config-create ../bdep-configs/gcc cc config.cxx=g++
