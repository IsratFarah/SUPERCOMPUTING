# Assignment 4 

## Task 1 

mkdir /programs
ls (to see output)

## Task 2 

cd ~/programs
wget https://github.com/cli/cli/releases/download/v2.74.2/gh_2.74.2_linux_amd64.tar.gz
tar -xzvf gh_2.74.2_linux_amd64.tar.gz

## Task 3 

Create install_gh.sh:

nano ~/programs/install_gh.sh

Script contains: 

#!/bin/bash

set -ueo pipefail

#Set up installation in programs directory

cd ~/programs
wget https://github.com/cli/cli/releases/download/v2.74.2/gh_2.74.2_linux_amd64.tar.gz

# Unpack using tar

tar -xzvf gh_2.74.2_linux_amd64.tar.gz

# Remove file after extraction

rm gh_2.74.2_linux_amd64.tar.gz

## Task 4

echo 'export PATH=$PATH:~/programs/gh_2.74.2_linux_amd64/bin' >> ~/.bashrc
source ~/.bashrc

## Task 5 
gh auth login
entered credentials 
gh auth status

## Task 6 

Create install_seqtk.sh:
nano ~/programs/install_seqtk.sh 

Script contains: 

#!/bin/bash
cd ~/programs
git clone https://github.com/lh3/seqtk.git
cd seqtk
make
echo 'export PATH=$PATH:~/programs/seqtk' >> ~/.bashrc

Make executable:
chmod +x ~/programs/install_seqtk.sh
./install_seqtk.sh
source ~/.bashrc
seqtk

## Task 7 

Used various commands to explore seqtk

## Task 8 

Create summarize_fasta.sh in assignment_04
nano scripts/summarize_fasta.sh

Script contains:

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

Make executable: 

chmod +x scripts/summarize_fasta.sh

## Task 9 

for f in ../data/*.fna;do;./summarize_fasta.sh "$f";done

## Reflection

$PATH is the name of the directory that contains all of the executables, so once I added both directories of the two applications, gh and seqtk, I could execute either of them from any location on the computer just by typing their name without having to type their entire filename while also being in their respective installation directory, as is the case with most system commands, rather than having to always go to where they are installed to use them.

The first 6 tasks were easy to complete because they were all done following the same pattern. All of the tasks involved creating an installation directory, downloading files, extracting files, and adding the installation directory(s) to my user version of $PATH. After task 6, I started having difficulty with later assignments, specifically, writing the file named 'summarize_fasta.sh' so that it conformed to all requirements AND contained no extraneous line(s) of code. In addition to spending time debugging problems with script execution issues and $PATH resolving to problematic file paths, how Bash works made it necessary to pay attention to how Bash interprets and processes input and variable data.

