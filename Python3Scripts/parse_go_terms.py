'''
Created on Oct 30, 2018

@author: cathytrinh
'''
import re

# Define a function for splitting the file into records
def records(file_path):
    with open(file_path) as f:
        data = f.read()        
        data_1 = re.split("\[Term\]|\[Typedef\]", data)        
        return data_1

# test_record = records("/Users/cathytrinh/Desktop/BINF6200/Module01/scratch/go-basic.obo")[1]
# print test_record

# Define a function to parse and capture the following fields of a single GO term. 
def parseGO(term):
    ID_pattern = re.compile(r"^id:\s+(GO:[0-9]+)", re.M)
    name_pattern = re.compile(r"^name:\s+(.*)\s+", re.M)
    namespace_pattern = re.compile(r"^namespace:\s+(.*?)\s+", re.M)
    is_a_pattern = re.compile(r"^is_a:\s+(.*?\s+.*)", re.M)
    
    ID = re.findall(ID_pattern, term)
    name = re.findall(name_pattern, term)
    namespace = re.findall(namespace_pattern, term)
    is_a = re.findall(is_a_pattern, term)
    key_inDict = "".join(ID)
    value_inDict = "\n\t".join(namespace + name + is_a)

    return key_inDict, value_inDict

# print(parseGO(test_record)[0])
# print(parseGO(test_record)[1])
# 
# Use the parseGO function to store the returned values in a dictionary
GO_dict = {}
allrecords = records("../scratch/go-basic.obo")[1:-5]
for record in allrecords:
    GO_dict.update({parseGO(record)[0]:parseGO(record)[1]})
    
# Iterate through the dictionary and print each parsed record to file
with open ("Outputs/parsed_go_terms.txt", "w") as p:
    for k in sorted (GO_dict.keys()):
        p.write("%s\t%s \n\n" % (k, GO_dict[k]))