#!/bin/bash

set -euo pipefail

# Get in to programs directory

cd ~/programs

rm -rf Flye

git clone https://github.com/fenderglass/Flye
cd Flye
make

