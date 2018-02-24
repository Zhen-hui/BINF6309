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
open (SP, "<", "aipSwissProt.tsv") or die $!;

while (<SP>) {
	chomp;
	my ($trinity, $swissProt, $description, $eValue) = split("\t",$_);
	if (defined $spToGo{$swissProt}) {
		foreach my $go (sort keys %{$spToGo{$swissProt}}){
			print join("\t",$trinity,$description,$swissProt,$go),"\n";
		}
	}
}
=cut
foreach my $swissProt(sort keys %spToGo){
	foreach my $go ( sort keys %{$spToGo{$swissProt}} ) {
		print join("\t",$swissProt,$go),"\n";
	}
}