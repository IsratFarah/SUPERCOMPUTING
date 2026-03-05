# Assignment 05 – FASTQ Processing Pipeline

## Overview
This project builds a small Bash pipeline that downloads FASTQ sequencing data and performs quality control using the tool **fastp**. 
The pipeline is designed to automatically process all paired-end sequencing samples in the dataset.

## Directory Structure
assignment_05/
cd ~/SUPERCOMPUTING/assignments
cd assignment_05

mkdir -p scripts log data/raw data/trimmed
touch pipeline.sh
touch README.md
touch scripts/01_download_data.sh
touch scripts/02_run_fastp.sh

chmod +x pipeline.sh
chmod +x scripts/01_download_data.sh
chmod +x scripts/02_run_fastp.sh

pipeline.sh – main pipeline script  
scripts/01_download_data.sh – downloads and extracts FASTQ files  
scripts/02_run_fastp.sh – runs fastp on a single sample  
data/raw – raw FASTQ files 
data/trimmed – trimmed FASTQ output files  
log – fastp report files

## fastp Installation
fastp was installed by downloading the precompiled binary into the `~/programs` directory.

Steps:

1. Download fastp binary
cd ~/programs
wget http://opengene.org/fastp/fastp
2. Make it executable using `chmod +x fastp`
3. Add `~/programs` to `$PATH`
export PATH=$HOME/programs:$PATH
4. Confirm installation using: fatsp --version


Version used: **fastp v1.1.0**

## How to Run the Pipeline

From the `assignment_05` directory run:

Download FASTQ data

./scripts/01_download_data.sh

Make sure everything is correct: 

ls data/raw
ls data/raw/*_R1_*.fastq.gz | head -n 1

Test on one sample:

./scripts/02_run_fastp.sh data/raw/6083_001_S1_R1_001.subset.fastq.gz

Mak sure everything is correct:

ls data/trimmed
ls log

Remove output files:

rm data/raw/*.fastq.gz
rm data/trimmed/*.fastq.gz
rm log/*.html

Run pipeline:
./pipeline.sh

## Scripts 

01_download_data.sh = 

#!/bin/bash
set -euo pipefail

TARBALL_URL="https://gzahn.github.io/data/fastq_examples.tar"

wget $TARBALL_URL
tar -xvf *.tar
mv *.fastq.gz ./data/raw/
rm *.tar

02_run_fastp.sh = 

#!/bin/bash
set -euo pipefail

FWD_IN=$1
REV_IN=${FWD_IN/_R1_/_R2_}

FWD_OUT=${FWD_IN/.fastq.gz/.trimmed.fastq.gz}
REV_OUT=${REV_IN/.fastq.gz/.trimmed.fastq.gz}

FWD_OUT=${FWD_OUT/raw/trimmed}
REV_OUT=${REV_OUT/raw/trimmed}

BASE=$(basename $FWD_IN .fastq.gz)
HTML_OUT=./log/${BASE}.html

fastp \
--in1 $FWD_IN \
--in2 $REV_IN \
--out1 $FWD_OUT \
--out2 $REV_OUT \
--json /dev/null \
--html $HTML_OUT \
--trim_front1 8 \
--trim_front2 8 \
--trim_tail1 20 \
--trim_tail2 20 \
--n_base_limit 0 \
--length_required 100 \
--average_qual 20


pipeline.sh = 

#!/bin/bash
set -euo pipefail

./scripts/01_download_data.sh

for FWD_IN in ./data/raw/*_R1_*.fastq.gz
do
    ./scripts/02_run_fastp.sh $FWD_IN
done
