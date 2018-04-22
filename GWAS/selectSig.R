epilepsy.txt.assoc <- read.table("epilepsy.txt.assoc", header=T)

epilepsy.txt.assoc <- epilepsy.txt.assoc[epilepsy.txt.assoc$P<0.05,]

write.table(epilepsy.txt.assoc, "newepilepsy.txt.assoc", sep="\t")
