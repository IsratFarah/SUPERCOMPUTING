# Assignment 6: Flye Genome Assembly Pipeline

## Overview

This assignment builds a reproducible genome assembly pipeline using Flye v2.9.6.  
The pipeline runs the same assembly using three methods:

- Conda environment  
- HPC module  
- Local manual installation

The goal is to compare results and ensure reproducibility.

---

## Task 1: Directory Setup

Commands used:

cd \~/SUPERCOMPUTING/assignments

mkdir assignment\_06

cd assignment\_06

mkdir data scripts assemblies

mkdir assemblies/assembly\_conda assemblies/assembly\_local assemblies/assembly\_module

touch README.md pipeline.sh flye-env.yml

touch scripts/01\_download\_data.sh

touch scripts/02\_flye\_2.9.6\_conda\_install.sh

touch scripts/02\_flye\_2.9.6\_manual\_build.sh

touch scripts/03\_run\_flye\_conda.sh

touch scripts/03\_run\_flye\_module.sh

touch scripts/03\_run\_flye\_local.sh

## Task 2: Download Raw ONT Data

scripts/01\_download\_data.sh

\#\!/bin/bash

set \-euo pipefail

\# make data directory, then go inside of it

mkdir \-p ./data

cd ./data

\# Download genomic dataset

if \[ \! \-f SRR33939694.fastq.gz \]; then  
    wget https://zenodo.org/records/15730819/files/SRR33939694.fastq.gz?download=1  
    mv SRR33939694.fastq.gz?download=1 SRR33939694.fastq.gz  
fi 

## Task 3: Get Flye v2.9.6 (local build)

scripts/02\_flye\_2.9.6\_manual\_build.sh

\#\!/bin/bash

set \-euo pipefail

\# Get in to programs directory

cd \~/programs

rm \-rf Flye

git clone https://github.com/fenderglass/Flye  
cd Flye  
make

## Task 4: Get Flye v2.9.6 (conda build)

scripts/02\_flye\_2.9.6\_conda\_install.sh  
\#\!/bin/bash

set \-euo pipefail

module load miniforge3  
source "$(conda info \--base)/etc/profile.d/conda.sh"

\# create the environment from the correct channels  
mamba create \-y \-n flye-env \-c conda-forge \-c bioconda flye=2.9.6

conda activate flye-env

flye \-v

conda env export \--no-builds \> flye-env.yml

conda deactivate

## Task 5: Decipher How to Use Flye 

flye \--nano-hq ./data/SRR33939694.fastq.gz \--out-dir OUTPUT\_DIR \--threads 6 \--meta

## Task 6: Run Flye 3 Ways

6A:  scripts/03\_run\_flye\_conda.sh

\#\!/bin/bash

set \-euo pipefail

module load miniforge3  
source "$(conda info \--base)/etc/profile.d/conda.sh"  
conda activate flye-env

OUTDIR=./assemblies/assembly\_conda  
READS=./data/SRR33939694.fastq.gz

mkdir \-p "$OUTDIR"

flye \--nano-hq "$READS" \--out-dir "$OUTDIR" \--threads 6 \--meta

mv "$OUTDIR/assembly.fasta" ./assembly\_tmp.fasta  
mv "$OUTDIR/flye.log" ./flye\_tmp.log

rm \-rf "$OUTDIR"/\*

mv ./assembly\_tmp.fasta "$OUTDIR/conda\_assembly.fasta"  
mv ./flye\_tmp.log "$OUTDIR/conda\_flye.log"

conda deactivate

ls \-lh "$OUTDIR"

6B: scripts/03\_run\_flye\_module.sh

  GNU nano 5.6.1                                                                                 scripts/03\_run\_flye\_module.sh  
\#\!/bin/bash

set \-euo pipefail

OUTDIR=./assemblies/assembly\_module  
READS=./data/SRR33939694.fastq.gz

mkdir \-p "$OUTDIR"

module load Flye/gcc-11.4.1/2.9.6

flye \--nano-hq "$READS" \--out-dir "$OUTDIR" \--threads 6 \--meta

mv "$OUTDIR/assembly.fasta" ./assembly\_tmp.fasta  
mv "$OUTDIR/flye.log" ./flye\_tmp.log

rm \-rf "$OUTDIR"/\*

mv ./assembly\_tmp.fasta "$OUTDIR/module\_assembly.fasta"  
mv ./flye\_tmp.log "$OUTDIR/module\_flye.log"

ls \-lh "$OUTDIR"

6C: scripts/03\_run\_flye\_local.sh

\#\!/bin/bash

set \-euo pipefail

OUTDIR=./assemblies/assembly\_local  
READS=./data/SRR33939694.fastq.gz

mkdir \-p "$OUTDIR"

python \~/programs/Flye/bin/flye \--nano-hq "$READS" \--out-dir "$OUTDIR" \--threads 6 \--meta

mv "$OUTDIR/assembly.fasta" ./assembly\_tmp.fasta  
mv "$OUTDIR/flye.log" ./flye\_tmp.log

rm \-rf "$OUTDIR"/\*

mv ./assembly\_tmp.fasta "$OUTDIR/local\_assembly.fasta"  
mv ./flye\_tmp.log "$OUTDIR/local\_flye.log"

ls \-lh "$OUTDIR"

## Task 7: Compare the results in the log files

tail \-n 10 assemblies/assembly\_conda/conda\_flye.log  
tail \-n 10 assemblies/assembly\_module/module\_flye.log  
tail \-n 10 assemblies/assembly\_local/local\_flye.log

## Task 8: Build a \`pipeline.sh\` script

\#\!/bin/bash

set \-euo

bash scripts/01\_download\_data.sh  
bash scripts/02\_flye\_2.9.6\_manual\_build.sh  
bash scripts/02\_flye\_2.9.6\_conda\_install.sh

bash scripts/03\_run\_flye\_conda.sh  
bash scripts/03\_run\_flye\_module.sh  
bash scripts/03\_run\_flye\_local.sh

tail \-n 10 assemblies/assembly\_conda/conda\_flye.log  
tail \-n 10 assemblies/assembly\_module/module\_flye.log  
tail \-n 10 assemblies/assembly\_local/local\_flye.log

## Task 9: Delete Everything Except Scripts

rm \-rf assemblies/\*  
rm \-f data/\*  
bash pipeline.sh

## Reflection: 

I learned how to create a reproducible workflow on an HPC platform from this project. One of the big issues I encountered was downloading the data. The ending of the filename included ?download=1, so when my process tried to find and clean up the files, it caused issues. I had to troubleshoot this and came up with an if statement to check if the correctly named file existed first and then rename the file. I learned that small discrepancies in naming files may result in a total breakdown of the pipeline.

I was also exposed to the use of the negation operator "\!" in Bash as a way of evaluating conditions. Although I was more comfortable using an if statement to solve my problem, I became aware of how shell scripting provides negation for data filtering or for evaluating conditions.

I had similar problems with making the pipeline completely reproducible. For instance, in the case of attempting to rerun the pipeline, I came across an issue with the git clone operation because the Flye directory had already been created. In order to resolve this issue, I had to consider the behavior of programs with repeated executions and the ways I could increase the robustness of the program through the usage of existing directory checks or removals prior to reconstitutions of the directory.

Working with the modules of the HPC system was another challenge. In the beginning, I encountered difficulties locating the Flye module because the Flye module was present in the module system. I ended up using module avail to identify the exact name of the relevant module. This made me understand the module system better and that the names of the software in the module system are not always straightforward. Sometimes the names of the software in the module system are obscured by naming conventions that include version numbers.

In conclusion, this assignment taught me how to wire together multiple scripts into one pipeline, manage multiple environments (conda, modules, local installs), and automate processes so that everything runs without any further manual input. I also learned a lot about debugging, and I developed a greater degree of comfort with using the bash command line, organizing files, and working in an HPC system.
