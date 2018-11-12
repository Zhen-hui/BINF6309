'''
Created on Oct 28, 2018

@author: cathytrinh
'''
import re

# Define a function that parses a single line of BLAST output and returns the transcript ID and SwissProt ID. 
def parseBLAST(blastoutput):
    transcriptID = re.split(r"[\t\.\|]", blastoutput)[0]
    SwissProtID = re.split(r"[\t\.\|]", blastoutput)[6]
    return(transcriptID, SwissProtID)

# Read in BLAST file and apply the parseBLAST function
blastfile = open("../scratch/RNASeq/blastp.outfmt6")
blastfile_all_lines = blastfile.readlines()

# Test the function with one assertion 
test = blastfile_all_lines[0]
result = parseBLAST(test)
assert result == ('c0_g1_i1', 'Q9HGP0')

# Store transcript ID as key, SwissProt ID as value in a dictionary
transcriptsAndSwiss = {}
for line in blastfile_all_lines:
    transcriptsAndSwiss.update({parseBLAST(line)[0]: parseBLAST(line)[1]}) 

myfile = open("Outputs/parsed_blast2.txt", "w")
myfile.write("" + "\t" + "Sp_ds" + "\t" + "Sp_hs" + "\t" + "Sp_log" + "\t" + "Sp_plat" + "\n")
# Read in the DE transcript file and parse all the fields
diff_exp = open("../scratch/RNASeq/diffExpr.P1e-3_C2.matrix")
diff_exp_all_lines = diff_exp.readlines()
for row in diff_exp_all_lines[1:]:
    transcript = re.split(r"\t", row)[0]
    if transcript in transcriptsAndSwiss.keys():
        transcript = transcriptsAndSwiss[transcript]
    Sp_ds = re.split(r"\t", row)[1]
    Sp_hs = re.split(r"\t", row)[2]
    Sp_log = re.split(r"\t", row)[3]
    Sp_plat = re.split(r"\t", row)[4]
    myfile.write(transcript+ "\t" + Sp_ds + "\t" + Sp_hs + "\t" + Sp_log + "\t" + Sp_plat + "\n")
    
# Close files
blastfile.close()
diff_exp.close()
myfile.close()