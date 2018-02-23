#!/bin/perl
use Bio::SearchIO;
use Bio::Search::Result::GenericResult;
use Data::Dumper;

my $blastXml = Bio::SearchIO->new(
	-file   => 'Trinity-GG.blastp.xml',
	-format => 'blastxml'
);

open(OUT, ">", "aipSwissProt.tsv") or die $!;
while (<OUT>) {
	while (my $result = $blastXml -> next_result()) {
		my $queryDesc = $result->query_description;
		if ($queryDesc =~ /::(.*?)::/) {
			my $trinity = $1;
			my $hit   = $result->next_hit;
				if ($hit) {
				print OUT $trinity, "\t";
				my $swissProt = $hit->accession;
				print OUT $swissProt, "\t";			
				my $SwissProtDesc = $hit->description;
				if ($SwissProtDesc =~ /Full=(.*?);/){
					$SwissProtDesc = $1;
				}
				if ($SwissProtDesc =~ /Full=(.*?)\[/){
					$SwissProtDesc = $1;
				}
				print OUT $SwissProtDesc, "\t";
				my $eValue = $hit->significance;
				print OUT $hit->significance, "\n";
			}
		}
	}
}