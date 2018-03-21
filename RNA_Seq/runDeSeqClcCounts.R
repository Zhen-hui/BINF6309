library("DESeq2")
# Load counts and annotations file
load("clcCountsBlast2GoAnnotations.RData")

# Create new DESeq data set 
ddsAll <- DESeqDataSetFromMatrix(countData = rawCounts,
                                 colData = colData,
                                 design = ~ Vibrio + Menthol)
ddsAll$Menthol <- relevel(ddsAll$Menthol, ref = "NoMenthol")
ddsAll$Vibrio <- relevel(ddsAll$Vibrio, ref = "NoVibrio")

# Remove read counts that is less than 10
nrow(counts(ddsAll))
ddsAll <- ddsAll[rowSums(counts(ddsAll)) > 10,]
nrow(counts(ddsAll))

# Run differential expression analysis using DESeq() function 
ddsAll <- DESeq(ddsAll)

# Get the result names with resultsNames() function since we have multi-factor design
resultsNames(ddsAll)

# Get results as data frames
# To simplify some down-stream analysis, get the results where adjusted p-value is less than .05
resVibrio <- results(ddsAll, alpha = 0.05, name = "Vibrio_Vibrio_vs_NoVibrio")
resMenthol <- results(ddsAll, alpha = 0.05, name = "Menthol_Menthol_vs_NoMenthol")
dfVibrio <- as.data.frame(resVibrio)
dfMenthol <- as.data.frame(resMenthol)
head(dfVibrio)
head(dfMenthol)

# Select log2 fold change and adjusted p-value columns from the results
dfVibrio <- subset(subset(dfVibrio, select = c(log2FoldChange, padj)))
head(dfVibrio)
dfMenthol <- subset(subset(dfMenthol, select = c(log2FoldChange, padj)))
head(dfMenthol)

# Merge the results so we can determine which genes are differentially expressed in the 
# same or opposite directions from Menthol and Vibrio
dfBoth <- merge(dfMenthol,dfVibrio, by=0, suffixes=c(".Menthol",".Vibrio"))
# by=0 indicates merge on rowname; suffixes indicate how to differentiate columns 
# which have the same name in the data frames to be merged
rownames(dfBoth) <- dfBoth$Row.names
head(dfBoth)
# The merge function creates a redundant Row.name column, so delete it
dfBoth <- subset(dfBoth, select = -c(Row.names))
head(dfBoth)

# Merge annotations 
dfBothAnnot <- merge(dfBoth,geneDesc,by=0,all.x=T)
rownames(dfBothAnnot) <- dfBothAnnot$Row.names
dfBothAnnot <- subset(dfBothAnnot,select=-c(Row.names))
head(dfBothAnnot,n=10)

# Save the summarized results to use in the scripts that follow 
save(ddsAll,dfBothAnnot,resVibrio,resMenthol,file = "summarizedDeResults.RData")

# Clear environment 
rm(list = ls())
                      