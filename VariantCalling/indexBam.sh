#!/bin/bash
# This script index all the bam files in the noDup directory
indexBam(){
	for bamFile in noDup/*.bam
	do
		nice -n19 samtools index $bamFile
	done

}
indexBam 1>indexBam.log 2>indexBam.err &
