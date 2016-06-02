## Reads parental haplotypes and progeny genotype
## and runs the viterbi algorithm over our HMM
## to identify parental segments in the progeny
source("SharedFunctions.R")
library("genetics")
parentage<-read.table('Parentage_for_imputeR.csv',sep=",",header=TRUE)
#parentage

#Loading the parents file
date()
parents<-read.table('/group/jrigrp4/phasing/cj_teo_updated/teo_parents_hap_AGPv2.txt',header=TRUE);
date()
dim(parents)

#loading the progeny file
date()
progeny<-read.table('/group/jrigrp4/phasing/cj_teo_updated/teo_raw_biallelic_recoded_20160303_AGPv2.txt',sep="\t" , header = TRUE);
date()
dim(progeny)

#head(progeny)


#selecting one family of selfed progeny
progeny.list<-parentage[parentage$Mother=="PC_I58_ID2"&parentage$Father=="PC_I58_ID2",]
#restrinting loci to chr 7
#progeny<-progeny[]
progeny.subset<-progeny[grep(paste("S",7,"_",sep=""), progeny$snpid),]
dim(progeny.subset)
cat("\n")
#progeny$snpid[1:10]
cat("\nwhat is going on here\n")
loci.names<-progeny$snpid[grep("S7_",progeny$snpid)]
#loci.names[1:10]
#progeny.list
progeny.subset<-progeny.subset[,progeny.list[,1]]
dim(progeny.subset)
#head(progeny.subset)
#sliding window
window.size<-20
window.overlap<-5
geno.vector<-c("A/A","A/T","T/T",NA)
GetGenotype<-function(numbers) {return(genotype(sapply(numbers,FUN=function(x) {return(geno.vector[x+1])})))}

#for(window.start in 1:((num.loci/20)-1){
# progeny.subset[1,]
# progeny.subset[2,]
 
cat(file="ld.txt","locus1\tlocus2\tp.val\n");
for(window.start in 1:(dim(progeny.subset)[1]-1)){
     
   locus1<-progeny.subset[window.start,]
   locus2<-progeny.subset[window.start+1,]
   if(nallele(GetGenotype(locus1))+nallele(GetGenotype(locus2))==4){
     LD(GetGenotype(locus1),GetGenotype(locus2)) 
     cat(file="ld.txt",as.character(loci.names[window.start]),as.character(loci.names[window.start+1]),LD(GetGenotype(as.matrix(locus1)),GetGenotype(as.matrix(locus2)))$"P-value","\n",sep="\t",append=TRUE)

   }
   

}


