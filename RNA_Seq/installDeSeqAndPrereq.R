# This script installs the packages and prerequisites required to run DESeq

# Set timezone. 
Sys.setenv(TZ="US/Eastern")

# Install knitr to support R Markdown 
install.packages("knitr")

# Install RcolorBrewer to provide palette for plot colors 
install.packages("RColorBrewer", quiet = T)

# Install devtools to support package installation from GitHub
install.packages("devtools")

# Install pheatmap to produce heatmaps
install.packages("pheatmap", quiet = T)

# Set the source to BioConductor 
source("https://www.bioconductor.org/biocLite.R")
# Update all Bioconductor packages 
biocLite(ask = F)

# Install DESeq2
biocLite("DESeq2", quiet = T, ask = F, suppressUpdates = T)
# Install limma for Venn diagrams
biocLite("limma", ask = F, suppressUpdates = T)
