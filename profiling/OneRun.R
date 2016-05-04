#Taxa,Mother,Father
# A0003,PC_N14_ID2,PC_N14_ID2
# A0004,PC_J48_ID2,PC_J48_ID2
# A0008,PC_J13_ID1,PC_K60_ID1
# A0013,PC_N10_ID2,PC_N10_ID2
# A0014,PC_K60_ID1,PC_K60_ID1
# A0015,PC_J10_ID1,PC_M15_ID1
# A0017,PC_L56_ID1,PC_N58_ID1
# A0020,PC_M59_ID1,PC_L56_ID1
# A0021,PC_I08_ID1,PC_I08_ID1

progeny.individual.name<-"A0003"
maternal.parent.name<-"PC_N14_ID2"
paternal.parent.name<-"PC_N14_ID2"

#Loading the parents file
date()
parents<-read.table('/group/jrigrp4/phasing/cj_teo_updated/teo_parents_hap_AGPv2.txt',header=TRUE);
date()
dim(parents)

#loading the progeny file
date()
progeny<-read.table('/group/jrigrp4/phasing/cj_teo_updated/teo_imputeR_03162016.txt',fill = TRUE , header = TRUE);
date()
dim(progeny)


#formatting the data for our HMM

mom.chromatid<-list(maternal=parents[,paste(maternal.parent.name,"_hap1",sep="")],paternal=parents[,paste(maternal.parent.name,"_hap2",sep="")])

mom.chromatid

mom.chromatid$maternal[870:900]
mom.chromatid$paternal[870:900]

## haps are equal
sum(parents[,"PC_N14_ID2_hap1"]==parents[,"PC_N14_ID2_hap2"])
## haps are different
sum(parents[,"PC_N14_ID2_hap1"]!=parents[,"PC_N14_ID2_hap2"])


## showing this segment that looks IBD on both chromatids
parents[,"PC_N14_ID2_hap1"][870:900]
parents[,"PC_N14_ID2_hap2"][870:900]

### testing with our HMM

source("SharedFunctions.R")

start.p<-c(0.25,0.25,0.25,0.25)
trans.p<-GetTransitionProb(0.001)
dad.chromatid<-mom.chromatid #because it is a self cross
#obs<-as.vector(t(progeny[progeny$child=='A2410',4:dim(progeny)[2]]))
obs<-progeny[,progeny.individual.name]
vit<-ViterbiWithMissingData(obs,start.p, trans.p,mom.chromatid,dad.chromatid,0.4)
vitrowmax.2 <- apply(vit, 1, function(x) which.max(x))
estimated<-rownames(trans.p)[vitrowmax.2]
CountRecombEvents(estimated)
#[1] 3
eventIndex<-ListRecombEvents(estimated)

eventIndex[1:50]

