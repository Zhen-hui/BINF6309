#!/bin/sh

# Initialize variable to contain the directory of bam files

bamPath="BAM/"

# Initialize variable to contain suffix for  the bam files
bamSuffix=".sorted.bam"

# Initialize variable for the output files
indexPath="BAM/"

# Loop through all the bam files in the $bamPath
for bamFile in $bamPath*$bamSuffix
do
	pathRemoved="${bamFile/$bamPath/}"
	sampleName="${pathRemoved/$bamSuffix/}"
	#echo $sampleName
	echo samtools index \
	$bamPath$sampleName$bamSuffix \
	#1>$sampleName.index.log 2>$sampleName.index.err &
done
