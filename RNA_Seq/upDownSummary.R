library("DESeq2")
library("RColorBrewer")
library("pheatmap")

# Load summarized DE results 
load("summarizedDeResults.RData")

# Plot dispersion 
plotDispEsts(ddsAll)

# Get subsets of genes up-regulated or down-regulated for each factor using a p-value cutoff of .05
logThreashold = 0
alpha = .05
upVibrio <- subset(dfBothAnnot, (padj.Vibrio < alpha) & (log2FoldChange.Vibrio > logThreashold))
downVibrio <- subset(dfBothAnnot, (padj.Vibrio < alpha) & (log2FoldChange.Vibrio < logThreashold))
upMenthol <- subset(dfBothAnnot, (padj.Menthol < alpha) & (log2FoldChange.Menthol > logThreashold))
downMenthol <- subset(dfBothAnnot, (padj.Menthol < alpha) & (log2FoldChange.Menthol < logThreashold))
listAll <- list(UpVibrio=row.names(upVibrio), DownVibrio=row.names(downVibrio),
                UpMenthol=row.names(upMenthol), DownMenthol=row.names(downMenthol))

# Volcano plots
# Plot log2 fold change as a function of mean normalized counts. 
# Each point on the graph represents a gene.
# Red indicated an adjusted p-value of .05 or lower
plotMA(resVibrio,ylim=c(-4,4),alpha=.05)
plotMA(resMenthol,ylim=c(-4,4),alpha=.05)

# Perform an rlog transformation on the counts to construct a sample distance matrix.
# The sample distance matrix provides a measure of how similar overall gene expression patterns are for each sample 
rldAll <- rlog(ddsAll,blind = F)
sampleDists <- dist(t(assay(rldAll)))
sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- paste(rldAll$Vibrio, rldAll$Menthol, sep = "-")
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette(rev(brewer.pal(9,"Blues")))(255)

# Cluster samples based on overall gene expression patterns
pheatmap(sampleDistMatrix,
         clustering_distance_rows = sampleDists,
         clustering_distance_cols = sampleDists,
         col = colors)

# Perform principal component analysis to determine percentage of variation explained by each variable
# About 40% explained by Vibrio exposure, and about 13% by Menthol exposure
plotPCA(rldAll, intgroup=c("Vibrio","Menthol"))

# Make a Venn diagram showing overlap between Vibrio Up, Vibrio Down, Menthol Up, and Menthol Down
upVibrio$count <- rep(1,nrow(upVibrio))
downVibrio$count <- rep(1, nrow(downVibrio))
upMenthol$count <- rep(1,nrow(upMenthol))
downMenthol$count <- rep(1,nrow(downMenthol))
vibrioCount <- merge(upVibrio,downVibrio,by=0,all=T,suffixes=c("Up","Down"))
mentholCount <- merge(upMenthol,downMenthol,by=0,all=T,suffixes=c("Up","Down"))
rownames(vibrioCount) <- vibrioCount$Row.names
rownames(mentholCount) <- mentholCount$Row.names
vibrioCount <- subset(vibrioCount, select=-c(Row.names))
mentholCount <- subset(mentholCount,select=-c(Row.names))
bothCount <- merge(vibrioCount,mentholCount,by=0,all=T,suffixes=c("Vibrio","Menthol"))
rownames(bothCount) <- bothCount$Row.names
bothCount <- subset(bothCount,select=c(countUpVibrio,countDownVibrio,
                                       countUpMenthol,countDownMenthol))

# Change NAs to zero 
bothCount$countUpVibrio[is.na(bothCount$countUpVibrio)] <- 0
bothCount$countDownVibrio[is.na(bothCount$countDownVibrio)] <- 0
bothCount$countUpMenthol[is.na(bothCount$countUpMenthol)] <- 0
bothCount$countDownMenthol[is.na(bothCount$countDownMenthol)] <- 0

# Display Venn diagram 
library("limma")
vennDiagram(vennCounts(bothCount),names = c("UpVibrio","DownVibrio","UpMenthol",
                                            "DownMenthol"),
            circle.col = c("red","green","blue","yellow"))
