#!/bin/bash

#samtools faidx <ref.fasta>: index reference in the fasta format or extract subsequence from indexed reference sequence. Since no region is specified, the faidx command will index the file and create <ref.fasta>.fai on the disk. 
samtools faidx vShiloni.fasta

# Create a sequence dictionary for a reference sequence with the CreateSequenceDictionary tool in Picard.jar. 
# R = specify input reference fasta or fasta.gz file 
# O = specify output SAM file containing only the sequence dictionary 
java -jar /usr/local/bin/picard.jar CreateSequenceDictionary \
R=vShiloni.fasta O=vShiloni.dict \
1>prepRef.log 2>prepRef.err &
