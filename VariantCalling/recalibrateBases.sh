#!/bin/bash

# Step 1: Analyze patterns of covariation in the sequence dataset

bamDir='noDup/'
bamSuffix='.bam'

# Create a directory for the table outputs 
tableDir='tables/'
mkdir -p $tableDir

# Define a function to recalibrate the bases 
recalibrateBases(){

# Loop through every bam file in the noDup directory 
for bamFile in $bamDir*$bamSuffix
do 

outFile="${bamFile/$bamDir/$tableDir}"
outFile="${outFile/bamFile/$tableDir}"
baseCommand='nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar'

$baseCommand -T BaseRecalibrator \
	     -R vShiloni.fasta \
  	     -I $bamFile \
	     -knownSites filteredSnps.vcf \
 	     -o $outFile.table  
done 
}
recalibrateBases 1>recalibrate.log 2>recalibrate.err &
