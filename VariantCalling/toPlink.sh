#!/bin/bash
# Use vcftools to convert VCF files to PLINK format for GWAS
baseCommand='/usr/local/programs/vcftools_0.1.12b/bin/vcftools'
$baseCommand --vcf filteredSnps.vcf --plink
