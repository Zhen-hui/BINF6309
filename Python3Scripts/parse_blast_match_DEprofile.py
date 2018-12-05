'''
Created on Oct 28, 2018

@author: cathytrinh
'''
class BLAST_record():
    def __init__(self, blastInput):
        all_fields = blastInput.rstrip('\n').split('\t')
        
        self.transcript_ID = all_fields[0].split('|')[0]
        self.swissProt_ID  = all_fields[1].split('|')[3].split('.')[0]
        self.identity      = all_fields[2]
      
class DE_MATRIX():
    def __init__(self, DE_FILE_PATH):
        self.line = [x.split('\t') for x in open(DE_FILE_PATH).readlines()]

# function that will accept a BLAST object and return whether its identity attribute is > 95.
def analyzeBLAST(pident):
    if float(pident) > 95:
        return(True)
    else:
        return(False)
    
# function that accept a tuple and return it as a tab-separated string.
def tuple_to_string(tupleInput):
    return('\t'.join(tupleInput))

# loads the BLAST objects into a dictionary.
filepath = "../scratch/RNASeq/blastp.outfmt6"
with open(filepath) as blastfile:
    blastfile_all_lines = blastfile.readlines()
            
    filteredDict = {blastob.transcript_ID:blastob.swissProt_ID 
                   for blastob in (BLAST_record(line) for line in blastfile_all_lines)
                   if analyzeBLAST(blastob.identity)}       

# performs a transcript-to-protein lookup.  Default the protein to the transcript if no match is found.
DE = DE_MATRIX("../scratch/RNASeq/diffExpr.P1e-3_C2.matrix")

# print result to file
with open("Outputs/parsed_blast2.txt", "w") as out:
    for x in DE.line:
        if(x[0] in filteredDict):
            out.write(filteredDict[x[0]] + "\t" + tuple_to_string(x[1:]))
        else:
            out.write(tuple_to_string(x))