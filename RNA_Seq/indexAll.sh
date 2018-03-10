#!/bin/sh

# Initialize variable to contain the directory of bam files
fastqPath="/scratch/AiptasiaMinSeq/fastq"
leftSuffix=".R1.fastq"
bamPath="BAM/"

# Loop through all the left-read fastq files in the $fastqPath
for leftInFile in $fastqPath*$leftSuffix
do
	pathRemoved="${leftInFile/$fastqPath/}"
	sampleName="${pathRemoved/$leftSuffix/}"
	
	samtools index \
	$bamPath$sampleName.sorted.bam \
	1>$bamPath$sampleName.index.log 2>$bamPath$sampleName.index.err 
done
