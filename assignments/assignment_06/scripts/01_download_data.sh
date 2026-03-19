#!/bin/bash

set -euo pipefail

# make data directory, then go inside of it

mkdir -p ./data

cd ./data

# Download genomic dataset

if [ ! -f SRR33939694.fastq.gz ]; then
    wget https://zenodo.org/records/15730819/files/SRR33939694.fastq.gz?download=1
    mv SRR33939694.fastq.gz?download=1 SRR33939694.fastq.gz
fi
