#!/bin/sh
nice -n19 /usr/local/programs/SPAdes-3.10.0-Linux/bin/\
spades.py --pe1-1 SRR6728051_1.paired.fastq --pe1-2 SRR6728051_2.paired.fastq --threads 8 --memory 50 -o vibrioAssembly
  
