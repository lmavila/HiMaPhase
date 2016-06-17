#explores the parents file
date()
parents<-read.table('/group/jrigrp4/phasing/cj_teo_updated/teo_parents_hap_AGPv2.txt',header=TRUE);
date()
dim(parents)
summary(parents[,1:7])
date()
levels(as.factor(parents$chr))
levels(as.factor(parents[,4]))

chromosomes<-as.character(levels(as.factor(parents$chr)))

summary(parents[parents$chr==chromosomes[1],1:5])

#diff value adding for I06
sum(parents[,"PC_I06_ID1_hap1"]!=parents[,"PC_I06_ID1_hap2"])
sum(parents[,"PC_I06_ID1_hap1"]==parents[,"PC_I06_ID1_hap2"])

#adding for PC_M04_ID1
sum(parents[,"PC_M05_ID1_hap1"]==parents[,"PC_M05_ID1_hap2"])
sum(parents[,"PC_M05_ID1_hap1"]!=parents[,"PC_M05_ID1_hap2"])

#adding for I06
sum(parents[,"PC_J07_ID2_hap1"]==parents[,"PC_J07_ID2_hap2"])
sum(parents[,"PC_J07_ID2_hap1"]!=parents[,"PC_J07_ID2_hap2"])

#write.table(data.frame(parents[,1],parents[,2],parents[,3],parents[,"PC_M05_ID1_chunk"],parents[,"PC_M05_ID1_hap1"],parents[,"PC_M05_ID1_hap2"]),file="PC_M05_ID1_haps.txt",sep="\t")
write.table(data.frame(parents[,1],parents[,2],parents[,3],parents[,"PC_I05_ID1_chunk"],parents[,"PC_I05_ID1_hap1"],parents[,"PC_I05_ID1_hap2"]),file="PC_I05_ID1_haps.txt",sep="\t")

#aggregate(data=parents,outcrosse ~has.no.event,function(x) length(unique(x)))



