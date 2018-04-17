#!/bin/bash

# Step 1: Analyze patterns of covariation in the sequence dataset

bam="$(ls -q noDup/*.bam)"
#echo $bam

baseCommand='nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar'

$baseCommand -T BaseRecalibrator \
	     -R vShiloni.fasta \
 	     -I $bam \
	     -knownSites filteredSnps.vcf \
 	     -o recal.table \
1>test.log 2>test.err &
 
