#!/bin/sh
<<cut
This script assemble the reads from the merged bam file into a transcriptome
cut
nice -n19 /usr/local/programs/\
trinityrnaseq-2.2.0/\
Trinity --genome_guided_bam AipAll.bam \
--genome_guided_max_intron 10000 \
--max_memory 10G --CPU 4 \
1>trinity.log 2>trinity.err &
