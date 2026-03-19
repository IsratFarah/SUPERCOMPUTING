#!/bin/bash

set -euo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"

# create the environment from the correct channels
mamba create -y -n flye-env -c conda-forge -c bioconda flye=2.9.6

conda activate flye-env

flye -v

conda env export --no-builds > flye-env.yml

conda deactivate



