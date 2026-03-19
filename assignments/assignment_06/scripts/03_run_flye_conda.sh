#!/bin/bash

set -euo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate flye-env

OUTDIR=./assemblies/assembly_conda
READS=./data/SRR33939694.fastq.gz

mkdir -p "$OUTDIR"

flye --nano-hq "$READS" --out-dir "$OUTDIR" --threads 6 --meta

mv "$OUTDIR/assembly.fasta" ./assembly_tmp.fasta
mv "$OUTDIR/flye.log" ./flye_tmp.log

rm -rf "$OUTDIR"/*

mv ./assembly_tmp.fasta "$OUTDIR/conda_assembly.fasta"
mv ./flye_tmp.log "$OUTDIR/conda_flye.log"

conda deactivate

ls -lh "$OUTDIR"
