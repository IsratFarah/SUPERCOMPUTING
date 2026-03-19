#!/bin/bash

set -euo pipefail

OUTDIR=./assemblies/assembly_module
READS=./data/SRR33939694.fastq.gz

mkdir -p "$OUTDIR"

module load Flye/gcc-11.4.1/2.9.6

flye --nano-hq "$READS" --out-dir "$OUTDIR" --threads 6 --meta

mv "$OUTDIR/assembly.fasta" ./assembly_tmp.fasta
mv "$OUTDIR/flye.log" ./flye_tmp.log

rm -rf "$OUTDIR"/*

mv ./assembly_tmp.fasta "$OUTDIR/module_assembly.fasta"
mv ./flye_tmp.log "$OUTDIR/module_flye.log"

ls -lh "$OUTDIR"
