#!/usr/bin/env bash

FILES="/line-collision-detector/linc/linc"
if [ $1 ]; then
	# Cut away trailing ++ because run-clang-tidy will interpret them as a regex
	FILES=${1%++}
fi

# This script is executable from within the docker image
./make_compilation_database.sh
cd /line-collision-detector/linc
run-clang-tidy-10 -p=.. -checks="-*,cppcoreguidelines-*,modernize-*,bugprone-*,clang-analyzer-*,misc-*,performance-*,readability-*,cert-*" -fix $FILES 2>/dev/null
