fam <- read.table("cornell_canine.fam", header=F, sep=" ")

colnames(fam) <- c("dogID","inFam","inFamF","inFamM","sex","pheno")

pheno <- read.table("phenotypes.txt",header=TRUE,sep="\t")

famPheno <- merge(fam, pheno)

famPheno <- subset(famPheno, select=c("dogID", "inFam", "inFamF", "inFamM", "sex", "epilepsy_irishWolfhounds"))

write.table(famPheno,file="famEpilepsy.fam",col.names=FALSE, row.names=FALSE,quote=FALSE)
