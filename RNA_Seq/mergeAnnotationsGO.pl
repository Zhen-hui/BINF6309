#!/bin/perl
use strict;
use warnings;

open (SP_TO_GO, "<", "spToGo.tsv") or die $!;

my %spToGo;

while (<SP_TO_GO>) {
	chomp;
	my ($swissProt, $go) = split("\t",$_);
	$spToGo{$swissProt}{$go}++;
}

foreach my $swissProt(sort keys %spToGo){
	foreach my $go ( sort keys %{$spToGo{$swissProt}} ) {
		print join("\t",$swissProt,$go),"\n";
	}
}