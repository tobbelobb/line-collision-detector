#!/usr/bin/env bash

# Find only test files (absolute paths)
TESTS="/line-collision-detector/linc/linc/.*test\.c.*"

# Find all .c++ files except test files (absolute paths)
APPLICATION_CODE="/line-collision-detector/linc/linc/([a-z]|-|_|[A-Z]|[0-9])+\.c"

# If there's an argument, use it and assume it is application code
if [ $1 ]; then
  # Convert a relative path to an absolute path
  APPLICATION_CODE=`find /line-collision-detector/linc/ -name "*$1*"`
	# Cut away trailing ++ because run-clang-tidy will interpret them as a regex
	APPLICATION_CODE=${APPLICATION_CODE%++}
  echo $APPLICATION_CODE
fi

CHECKS="-*,cppcoreguidelines-*,modernize-*,bugprone-*,clang-analyzer-*,misc-*,performance-*,readability-*"

# This script is executable from within the docker image
/line-collision-detector/make-compilation-database.sh
cd /line-collision-detector/linc

echo "Check application code"
run-clang-tidy-10 -p=.. -checks=$CHECKS -fix -quiet $APPLICATION_CODE 2>/dev/null

if [ -z "$1" ]; then
  # Allow magic numbers in test code
  CHECKS="$CHECKS,-readability-magic-numbers,-cppcoreguidelines-avoid-magic-numbers"
  echo "
  Check test code"
  run-clang-tidy-10 -p=.. -checks=$CHECKS -fix -quiet $TESTS 2>/dev/null
fi
