#!/bin/sh

# Initialize variable to contain the directory of sam files
samPath="SAM/"

# Initialize variable to contain the suffix for the sam files
samSuffix=".sam"

# Initialize variable to contain the suffix for the bam files
bamSuffix=".sorted.bam"

# Initialize variable with the desired output path for the BAM files
bamOutPath="BAM/"

# Loop through all the sam files in the $samPath
for samFile in $samPath*$samSuffix
do
	# Remove the path from filename and assign to pathRemoved
	pathRemoved="${samFile/$samPath/}"
	# Remove the suffix from $pathRemoved and assign to $sampleName
	sampleName="${pathRemoved/$samSuffix/}"
	#echo $sampleName
	samtools sort \
	$samPath$sampleName$samSuffix \
	-o $bamOutPath$sampleName$bamSuffix \
	1>$sampleName.sort.log 2>$sampleName.sort.err 
done
