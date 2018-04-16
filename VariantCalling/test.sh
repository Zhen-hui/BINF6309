#!/bin/bash

# Step 1: Analyze patterns of covariation in the sequence dataset

baseCommand='nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar'

$baseCommand -T BaseRecalibrator \
	     -R vShiloni.fasta \
  	     -I noDup/SRR5231228.bam \
	     -knownSites filteredSnps.vcf \
 	     -o recal.table \
1>recalibrate.log 2>recalibrate.err &
