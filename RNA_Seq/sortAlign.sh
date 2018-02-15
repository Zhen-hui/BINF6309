#!/bin/sh
<<Comment
SAM files are converted to BAM using the "samtools" utility 
This script convert Aip02.sam to a sorted BAM version 
Comment

samtools sort \
Aip02.sam \
-o Aip02.sorted.bam \
1>Aip02.sort.log 2>Aip02.sort.err &
