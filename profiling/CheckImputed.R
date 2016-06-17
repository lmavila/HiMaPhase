## Reads parental haplotypes and progeny genotype
## of one family of a selfed plants
## filters for loci > 100 nt apart

source("SharedFunctions.R")
library("data.table")
parentage<-fread('Parentage_for_imputeR.csv',sep=",",header=TRUE)

#parentage[1:5,1:3,with=FALSE]

loci<-c("S7_303611","S7_307845","S7_308866","S7_572703","S7_572895","S7_985908","S7_995036",
"S7_1292768","S7_1317078","S7_1317188","S7_1938404","S7_1956185",
"S7_1957043",
"S7_2062531")


#Loading the parents file
parents<-fread('/group/jrigrp4/phasing/cj_teo_updated/teo_parents_hap_AGPv2.txt',header=TRUE);
dim(parents)
#parents[1:5,1:5,with=FALSE]
parents<-as.data.frame(parents)
parents[as.character(parents$snpid)%in%loci, c("snpid","chr","pos","PC_I58_ID2_chunk","PC_I58_ID2_hap1","PC_I58_ID2_hap2")]

#loading imputed progeny
progeny<-fread('/group/jrigrp4/phasing/cj_teo_updated/teo_imputeR_03162016.txt',sep="\t", header = TRUE);
date()
dim(progeny)
#progeny[1:5,1:5,with=FALSE]



#these are 10 kids of selfed "PC_I58_ID2"
genotypes<-c("A0082", "A0178" ,"A0513" ,"A0594" ,"A1061","A1163", "A2262", "A3674", "A3678", "A3697")

cat("\n")
progeny<-as.data.frame(progeny)
rownames(progeny)<-progeny$snpid
progeny[1:5,1:5]
progeny.subset<-progeny[loci,genotypes]
dim(progeny.subset)
progeny.subset

#loading raw data
raw.progeny<-fread('/group/jrigrp4/phasing/cj_teo_updated/teo_raw_biallelic_recoded_20160303_AGPv2.txt',sep="\t" , header = TRUE);
raw.progeny<-as.data.frame(raw.progeny)
rownames(raw.progeny)<-raw.progeny$snpid
raw.progeny.subset<-raw.progeny[loci,genotypes]
dim(raw.progeny.subset)
raw.progeny.subset




