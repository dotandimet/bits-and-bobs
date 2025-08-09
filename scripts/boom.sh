#!/usr/bin/env bash

set -e

for f in 0 1 2 3;
do
  : $(( f++ ))
  printf " { exit: %d / value: %d }\n" $? $f;
done
echo " Done" 
