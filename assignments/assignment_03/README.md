Israt Farah 
Assignment_03

# Task 1 - Making data directory in assignment_03

cd SUPERCOMPUTING/assignments/assignment_03

mkdir data 

# Task 2—Download the FASTA sequence file 

cd data 

wget https://gzahn.github.io/data/GCF_000001735.4_TAIR10.1_genomic.fna.gz

gunzip GCF_000001735.4_TAIR10.1_genomic.fna.gz

# Task 3 - Use unix tools to explore the file contents 

Setting the variable name to make using commands easier 

fasta=GCF_000001735.4_TAIR10.1_genomic.fna 

grep -c '^>' "$fasta" # Finds number of sequences (7)

grep -v '^>' "$fasta" | tr -d '\n' | wc -c # Finds number of nucleotides excluding header lines/newlines (119,668,634)

wc -l $fasta # Finds total number of lines (14)

grep -c '^>.*mitochondrion' "$fasta" # Header lines that contain “mitochndrion”

grep -c '^>.*chromosome' “$fasta” # Header lines that contain “chromosome”

Finds how many nucleotides are in each of the first 3 chromosome sequences (30,427,672, 19,698,290,  23,459,831)

- grep -A1 "chromosome 1" "$fasta" | tail -n 1 | tr -d '\n' | wc - grep -A1 "chromosome 2" "$fasta" | tail -n 1 | tr -d '\n' | wc
- grep -A1 "chromosome 3" "$fasta" | tail -n 1 | tr -d '\n' | wc
- grep -A1 "chromosome 5" "$FA" | tail -n 1 | tr -d '\n' | wc -c # Finds number of nucleotides in 5th chromosome (26,975,503)

paste - - < "$FA" | grep -c 'AAAAAAAAAAAAAAAA' # Finds the frequency of that sequence 

grep '^>' "$FA" | sort | head -n 1 # First sequence header by alphabetical order (>NC_000932.1 Arabidopsis thaliana chloroplast, complete genome)

paste - - < "$fasta" > paired_sequences.tsv # Creates the .tsv file

# Reflection

My approach for this task was to work through the FASTA file one step at a time using some of the Unix command-line tools and try to gain an understanding of how the file was formatted before I 
attempted to answer any questions. I started by displaying the file contents using commands such as head or less to check that the file contained a header line followed by a string of 
nucleotide sequence (this helped me to establish each sequence's unique identifier). After establishing this sequence pattern, I utilized multiple combinations of the grep, wc, tr, cut, and paste 
commands to filter specific lines, counting the number of sequences and determining the length of each sequence. This gave me insight into how biological data tasks can sometimes be accomplished 
by the chaining of a handful of consecutive simple commands together. One big takeaway for me was the extent to which basic Unix tools are enhanced when used in conjunction with pipes. More 
specifically, I was amazed at how effective paste was at formatting a set of header lines and associated sequence lines into a tab-delimited format, which facilitated file analysis 
in the beginning, I found it very frustrating that my command-line input would often return no output due to typos in the directory and/or file path). In many cases, I ended up forcing myself to 
slow down, verify my current working directory by running the 'ls' command, and validate the output of the previous command before proceeding. This resulted in a smoother workflow.
The ability to use the command line is imperative for computational biology because we deal with large amounts of data and cannot easily do this by hand; with such a large volume of files, 
it will take too long, and it will take longer to record the exact commands used to generate the analysis than what it would take to automate the process. Therefore, we can either create 
object-oriented programming scripts for our analyses to automate the process from start to finish, allowing us to automate our dating of genomes to make sure they are done at a faster rate.
