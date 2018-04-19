epilepsy.txt.assoc <- read.table("epilepsy.txt.assoc", header=T)
#dim(epilepsy.txt.assoc)

epilepsy.txt.assoc <- epilepsy.txt.assoc[epilepsy.txt.assoc$P<0.05,]

#dim(epilepsy.txt.assoc)

write.table(epilepsy.txt.assoc, "newepilepsy.txt.assoc", sep="\t")
