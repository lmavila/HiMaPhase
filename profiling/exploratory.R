date()
parents<-read.table('/group/jrigrp4/phasing/cj_teo_updated/teo_parents_hap_AGPv2.txt',header=TRUE);
date()
dim(parents)
summary(parents[,1:7])
date()
levels(as.factor(parents$chr))
levels(as.factor(parents[,4]))
