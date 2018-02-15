#!/bin/sh
<<Comment
This script creates an index of intron splice sites from the GFF3 file. 
GSNAP will use this intron index to align reads across introns and not within them
Comment

nice -n19 iit_store \
-G /scratch/AiptasiaMiSeq/\
GCA_001417965.1_Aiptasia_genome_1.1_genomic.giff \
-o AiptasiaGmapIIT \
1>buildIIT.log 2>buildIIT.err &
