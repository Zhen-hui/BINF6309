#!/bin/bash
# This script aligns the paired reads to the reference. 
# sam output files will be piped and redirected to samtools sort to be written as sorted bam files 
pairedDir='Paired/'
suffix='_1.fastq.gz'
leftInFile='Paired/SRR5231018_1.fastq.gz'
bamOut='bam/'
mkdir -p $bamOut
alignAll(){
for leftInFile in $pairedDir*$suffix
	do
		rightInFile="${leftInFile/_1/_2}"
		sample="${leftInFile/$pairedDir/}"
		sample="${sample/$suffix/}"
		nice -n19 bwa mem \
		-R "@RG\tID:$sample\tSM:sample1\tPL:illumina\tLB:lib1\tPU:unit1" \
		-t 8 vShiloni \
		$leftInFile $rightInFile |\
		samtools sort \
		1>$bamOut$sample.bam
	done
}
alignAll 2>alignAll.err &
