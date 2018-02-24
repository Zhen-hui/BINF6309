#!/bin/perl
use strict;
use warnings;

use Bio::OntologyIO;

# Instantiate Bio::OntologyIO and assign the $parser variable
my $parser = Bio::OntologyIO->new(
	-format => "obo",
	-file   => "go-basic.obo"
);

open (OUT, ">", "bioProcess.tsv") or die $!; 

# Loop through the ontology with while and next_ontology
while (my $ont = $parser->next_ontology()){
	
# Get the root terms and leaf terms
#	print "read ontology ", $ont->name(), " with ",
#	  scalar($ont->get_root_terms)," root terms, and ",
#	  scalar($ont->get_leaf_terms)," leaf terms\n";

	# Get biological process terms
	if ($ont->name() eq "biological_process"){
		# Iterate over its leaves with a foreach loop
		foreach my $leaf ($ont->get_leaf_terms){
			# Get the name and ID of each leave
			my $go_name = $leaf->name();
			my $go_id   = $leaf->identifier();
			# Print leave name and ID in tab-separated format using join
			print OUT join("\t",$go_id,$go_name),"\n";
		}
	}	
}