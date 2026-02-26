#!/bin/bash
set -ueo pipefail

FA="$1"

TOTAL_SEQS=$(grep -c '^>' "$FA")

echo "FASTA file: $FA"
echo "Total number of sequences: $TOTAL_SEQS"

TOTAL_NT=0

while read name len
do
    echo "$name $len"
    TOTAL_NT=$((TOTAL_NT + len))
done < <(seqtk comp "$FA" | tail -n +2 | cut -f1,2)

echo "Total number of nucleotides: $TOTAL_NT"
