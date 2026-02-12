# Assignment 2: HPC Access & Remote File Transfer

Name: Israt Farah  

## Task 1: HPC Workspace Setup

Connected to the William & Mary VPN using GlobalProtect (portal: gp.wm.edu).

SSH into the cluster:

ssh ifarah@bora.sciclone.wm.edu

Make data directory in assignment_02:

mkdir -p ~/SUPERCOMPUTING/assignments/assignment_02/data


## Task 2: Download Files from NCBI

Attempted to use command-line ftp:

ftp ftp.ncbi.nlm.nih.gov
Username: anonymous
Password: (email address)

Navigated to:

cd genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2

Attempted to download files but encountered:

500 Illegal PORT command  
425 Unable to build data connection: Connection refused

Firewall did not allow me to use command-line ftp so I used WinSCP to download the following files:

- GCF_000005845.2_ASM584v2_genomic.fna.gz
- GCF_000005845.2_ASM584v2_genomic.gff.gz


## Task 3: Transfer Files to HPC and Set Permissions

### 3.1 File Transfer

Used WinSCP with SFTP to connect to:

Host: bora.sciclone.wm.edu  
Port: 22  
Protocol: SFTP  

Uploaded both .gz files to:

~/SUPERCOMPUTING/assignments/assignment_02/data/

### 3.2 File Permissions

Checked permissions on HPC:

ls -l

If files were not world-readable; came back with rw-------

Used chmod to change permissions

chmod 644 *.gz

Verified updated permissions:

ls -l

Final permissions were:

-rw-r--r--

Makes sure files are readable by the instructor and others

## Task 4: Verify File Integrity with md5sum

On Local Machine:

cd ~/SUPERCOMPUTING/assignments/assignment_02/data
md5sum *.gz

Output:
c13d459b5caa702ff7e1f26fe44b8ad7 *GCF_000005845.2_ASM584v2_genomic.fna.gz
2238238dd39e11329547d26ab138be41 *GCF_000005845.2_ASM584v2_genomic.gff.gz

On HPC:

cd ~/SUPERCOMPUTING/assignments/assignment_02/data
md5sum *.gz

Output:
c13d459b5caa702ff7e1f26fe44b8ad7 *GCF_000005845.2_ASM584v2_genomic.fna.gz
2238238dd39e11329547d26ab138be41 *GCF_000005845.2_ASM584v2_genomic.gff.gz

The MD5 hashes from the local machine and the HPC matched exactly

## Task 5: Bash Aliases

Added the following aliases to ~/.bashrc on the HPC:

alias u='cd ..;clear;pwd;ls -alFh --group-directories-first'
alias d='cd -;clear;pwd;ls -alFh --group-directories-first'
alias ll='ls -alFh --group-directories-first'

Activated them using:

source ~/.bashrc

### Alias Descriptions

ll  
Displays a detailed listing of files including hidden files, file sizes (human-readable), and groups directories first.

u  
Moves up one directory (cd ..), then clears the terminal, then prints the working directory, and finally lists contents in detailed format.

d  
Returns to the previous directory (cd -), then clears the terminal, then prints the working directory, and then lists contents in detailed format.


## Reflection

From this assignment I have learned how to successfully use ftp commands use them correctly. I attempted to do these commands in my terminal, but 
my firewall did not allow me to access files. I used winSCP to transfer files from my local computer and to the HPC. Additionally, I learned new commands
like chmod to change the permissions of the files that I input. The md5sum function produces a unique has-value for files, and I learned that you can check 
if you have the correct files because each file has one unique hash-value. Honestly, the hardest part of this assignment was to create the README.md file 
to keep track of everything I do because I procrastinate a lot, so I have to retrack my steps. In the next assignment, I will make sure I take screenshots 
of everything as I go to not forget information. Next time I also want to find a way to use command-line ftp effectively, and find a way to bypass 
the firewall  on my computer.
