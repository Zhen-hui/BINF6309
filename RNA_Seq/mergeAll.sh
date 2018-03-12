#!/bin/sh
<<cut
This script merges the 24 bam files into a single bam file because Trinity requires as input a single bam file
cut

ls bam/*.sorted.bam > bamIn.txt
samtools merge -b bamIn.txt AipAll.bam \
1>merge.log 2>merge.err &

<<cut 
The second line of the script uses ls and redirects the output to bamIn.txt to produce the list

The third line of the script runs samtools merge and uses the -b parameter to pass in bamIn.txt.
The merged bam file will be written to AipAll.bam
cut


