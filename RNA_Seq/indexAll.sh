#!/bin/bash

# Initialize variable to contain the directory of bam files
fastqPath="/scratch/AiptasiaMiSeq/fastq/"
leftSuffix=".R1.fastq"
bamOutPath="bam/"

# Loop through all the left-read fastq files in the $fastqPath
for leftInFile in $fastqPath*$leftSuffix
do
	pathRemoved="${leftInFile/$fastqPath/}"
	sampleName="${pathRemoved/$leftSuffix/}"
	
	samtools index \
	$bamOutPath$sampleName.sorted.bam \
	1>$bamOutPath$sampleName.index.log 2>$bamOutPath$sampleName.index.err 
done
