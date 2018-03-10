#!/bin/perl
use strict;
use warnings;

# Add a filehandle to read spToGo.tsv
open( SP_TO_GO, "<", "spToGo.tsv" ) or die $!;

# Initialize a hash to store SwissProt IDs and GO terms
my %spToGo;

# Loop through the filehandle and chomp each line
while (<SP_TO_GO>) {
	chomp;

	# Split each line one tabs, and assign the results to $swissProt and $go
	my ( $swissProt, $go ) = split( "\t", $_ );

	# Store both $swissProt and $go as keys
	# Increment a counter to be stored as the value for this 2-dimensional hash
	$spToGo{$swissProt}{$go}++;
}

# Open a filehandle to read bioProcess.tsv
open( BIO_PROCESS, "<", "bioProcess.tsv" ) or die $!;

# Initialize a hash to store SwissProt IDs and GO terms
my %bioProcess;

# Loop through the filehandle
while (<BIO_PROCESS>) {

	# chomp each line
	chomp;

# Split on tabs, assign the two columns in IN to two variables $go_id and $go_name
	my ( $go_id, $go_name ) = split( "\t", $_ );

	# Store $go_id as key and $go_name as value
	$bioProcess{$go_id} = $go_name;
}

# Open a filehandle to store the output
open( TRINITY_SP_GO, ">", "trinitySpGo.tsv" ) or die $!;
print TRINITY_SP_GO join( "\t", "Trinity ID", "SwissProt ID", "SwissProt Description", "GO Term", "GO Description" ), "\n";

# Open a filehandle to read the aipSwissProt.tsv created with mergeAnnotations.pl
open( SP, "<", "aipSwissProt.tsv" ) or die $!;

# Loop through the filehandle line by line
while (<SP>) {

	# chomp each line
	chomp;

	# Split on tabs, assign the four columns in the file to four variables
	my ( $trinity, $swissProt, $description, $eValue ) = split( "\t", $_ );

	# If $swissProt ID is defined in the hash, loop through the keys
	if ( defined $spToGo{$swissProt} ) {

		# Get the GO keys for the SwissProt IDs from the aipSwissProt.tsv file
		foreach my $go ( sort keys %{ $spToGo{$swissProt} } ) {

			# If the GO term is in the bio_process hash, loop through the keys
			if ( defined $bioProcess{$go} ) {

				# Get the go_name from the bioProcess.tsv file
				my $go_name = $bioProcess{$go};

				# Print all the variables in tab-separated format
				print TRINITY_SP_GO join( "\t",
					$trinity, $swissProt, $description, $go, $go_name ),
				  "\n";
			}
		}
	}
}

