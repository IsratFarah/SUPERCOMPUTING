#!/bin/bash

set -euo pipefail

OUTDIR=./assemblies/assembly_local
READS=./data/SRR33939694.fastq.gz

mkdir -p "$OUTDIR"

python ~/programs/Flye/bin/flye --nano-hq "$READS" --out-dir "$OUTDIR" --threads 6 --meta

mv "$OUTDIR/assembly.fasta" ./assembly_tmp.fasta
mv "$OUTDIR/flye.log" ./flye_tmp.log

rm -rf "$OUTDIR"/*

mv ./assembly_tmp.fasta "$OUTDIR/local_assembly.fasta"
mv ./flye_tmp.log "$OUTDIR/local_flye.log"


ls -lh "$OUTDIR"
