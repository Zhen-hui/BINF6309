#!/bin/bash

# This script creates a bwa index that will be used as a reference to align the reads 

# -p Prefix of the output database 
# -a Algorithm for constructing BWT index. 
# is IS linear-time algorithm for constructing suffix array. It requires 5.37N memory where N is the size of the database. IS is moderately fast, but does not work with database larger than 2GB. 

nice -n19 bwa index -p vShiloni -a is vShiloni.fasta \
1>bwaIndex.log 2>bwaIndex.err &
