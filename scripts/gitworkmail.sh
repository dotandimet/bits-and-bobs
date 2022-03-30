#!/usr/bin/env bash

pushd ~/CytoCode

for d in *
do
  pushd $d
  pwd
  git config user.email dotan.dimet@cytoreason.com
  git config -l
  popd
done
