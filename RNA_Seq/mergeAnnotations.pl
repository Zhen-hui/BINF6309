#!/bin/perl
use Bio::SearchIO;
use Bio::Search::Result::GenericResult;
use Data::Dumper;

# Instantiate Bio::SearchIO and assign the variable $blastXml
my $blastXml = Bio::SearchIO->new(
	-file   => 'Trinity-GG.blastp.xml',
	-format => 'blastxml'
);

# Open a filehandle to write the results to aipSwissProt.tsv
open( OUT, ">", "aipSwissProt.tsv" ) or die $!;

# Print a tab-separated header line to the output file
print OUT join( "\t", Trinity, SwissProt, SwissProtDesc, eValue ), "\n";

# Get the first hit from the blast result
# Loop through the file using while next_result()
while ( my $result = $blastXml->next_result() ) {

	# Get query description for each annotation
	my $queryDesc = $result->query_description;

# Get query description that are between pairs of colons using regular expression;
# ? before the closing parenthesis sats match with the shortest distance between the pairs of colons
	if ( $queryDesc =~ /::(.*?)::/ ) {

# REGEX assign matches to numbered variables based on the number of opening parentheses
# There's one opening parenthesis before .*?, which means it will be stored as $1
		my $queryDescShort = $1;
		my $hit            = $result->next_hit;
		if ($hit) {
			# Print the shorten query description to output
			print OUT $queryDescShort, "\t";

			# Print the accession number for each hit to output
			print OUT $hit->accession, "\t";

			# Get subject description for each hit
			my $subjectDescription = $hit->description;

			# Shorten subject descriptio by capturing the part between Full= and either [ or ;
			if ( $subjectDescription =~ /Full=(.*?);/ ) {
				$subjectDescription = $1;
			}

			# [ is a special character, so use \ to escape
			if ( $subjectDescription =~ /Full=(.*?)\[/ ) {
				$subjectDescription = $1;
			}

			# Print subject description to output
			print OUT $subjectDescription, "\t";

			# Print sifinifance value to output
			print OUT $hit->significance, "\n";
		}
	}
}
