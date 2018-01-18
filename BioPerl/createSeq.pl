#!/usr/local/bin/perl 
use strict;
use warnings;
use Bio::Seq;

my $seq_obj = Bio::Seq->new(
	-seq      => "aaaatgggggggggggccccgtt",
	-alphabet => 'dna'
);
print $seq_obj->seq;
