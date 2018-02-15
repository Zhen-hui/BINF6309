#!/bin/sh
<<Comment
This script aligns the sample Aip02 reads against the GMAP database. 
Comment

nice -n 19 gsnap \
-A sam \          # -A tells GSNAP to produce the sam alignment format 
-s AiptasiaGmapIIT.iit \
-D . \
-d AiptasiaGmapDb \
Aip02.R1.paired.fastq \
Aip02.R2.paired.fastq \ 
1>Aip02.sam 2>Aip02.err &  
