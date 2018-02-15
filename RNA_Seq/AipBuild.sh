#!/bin/sh
<<Comment
This script is to build a GMAP database from the Aiptasia genome. 
GSNAP will use this database to perform the alignment of the RNA seq reads. 
Comment

gmap_build -D . \   # -D indicates the directory in which to build the databse . = use pwd 
-d AiptasiaGmapDb \ # -d indicates the name of the database 
\scratch/AiptasiaMiSeq/\
GCA_001417965.1_Aiptasia_genome_1.1_genomic.fna \
1>AipBuild.log 2>AipBuild.err &    # where to store success and error output 
