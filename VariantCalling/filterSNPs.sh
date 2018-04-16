#!/bin/bash
# Since we don't have a VCF of known variants for this organism, we are doing hard-filtering here. 
vcf='genotype.vcf'
vcfOut='filteredSnps.vcf'
baseCommand='nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar'
taskRef='-T VariantFiltration -R vShiloni.fasta --filterName snpQual'
$baseCommand $taskRef -V $vcf --filterExpression "MQ < 70.0" -o $vcfOut \
1>filter.log 2>filter.err &
