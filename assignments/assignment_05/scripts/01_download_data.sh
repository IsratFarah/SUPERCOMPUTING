#!/bin/bash
set -euo pipefail

TARBALL_URL="https://gzahn.github.io/data/fastq_examples.tar"

wget $TARBALL_URL

tar -xvf *.tar

mv *.fastq.gz ./data/raw/

rm *.tar
