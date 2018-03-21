# Clear environment variables 
rm(list = ls())

# Load summarized DE results 
load("summarizedDeResults.RData")

# Read annotation files 
spAnnot <- read.delim("proteinGeneGo.txt",sep = "\t", header = F)

# Set column names
colnames(spAnnot) = c("Gene","Protein", "GeneDesc","GO")

# Select desired columns 
goDesc <- subset(spAnnot,select=c(GO,Gene))

# Find immune-related 
immune <- goDesc[grep("immune",goDesc$GO),]
immuneGenes <- unique(immune$Gene)
immuneDE <- dfBothAnnot[row.names(dfBothAnnot) %in% immuneGenes,]
colnames(immuneDE) <- c("lfcM","pM","lfcV","pV","Desc")
rownames(immuneDE) <- paste(rownames(immuneDE),immuneDE$Desc,sep = '-')
immuneDE <- subset(immuneDE,select=c(lfcM,pM,lfcV,pV))
write.csv(immuneDE,file = "ImmuneRelated.csv")
