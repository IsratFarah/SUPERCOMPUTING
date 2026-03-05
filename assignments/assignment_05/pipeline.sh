#!/bin/bash
set -euo pipefail

# Step 1: download/extract data into ./data/raw
./scripts/01_download_data.sh

# Step 2: run fastp on every forward read file (R1)
for FWD_IN in ./data/raw/*_R1_*.fastq.gz
do
    ./scripts/02_run_fastp.sh $FWD_IN
done
