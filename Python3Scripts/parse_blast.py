'''
Created on Oct 19, 2018

@author: zhentrinh
'''

# Read in file 
blastfile = open("../scratch/RNASeq/blastp.outfmt6")
all_lines = blastfile.readlines()

# Open file for writing
output = open("Outputs/parsed_blast.txt", "w")

# Grab the transcript ID, isoform, SwissProt ID, and percent of identical matches
for line in all_lines:
    element = line.replace('|', '\t').split()
    transcriptID = element[0]
    isoform = element[1]
    SwissProtID = element[5].split(".")[0] 
    pident = element[7] 
    output.write(transcriptID  + '\t' + isoform +  '\t' + SwissProtID +  '\t' + pident + '\n')

blastfile.close()
output.close()