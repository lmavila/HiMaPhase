## Reads parental haplotypes and progeny genotype
## of one family of a selfed plants
## filters for loci > 100 nt apart
## estimates max linkage deseq for window of 10 loci left and right of current locus.

source("SharedFunctions.R")
library("genetics")
library("data.table")
date()
parentage<-fread('Parentage_for_imputeR.csv',sep=",",header=TRUE)

parentage[1:5,1:3,with=FALSE]


#Loading the parents file
date()
parents<-fread('/group/jrigrp4/phasing/cj_teo_updated/teo_parents_hap_AGPv2.txt',header=TRUE);
date()
dim(parents)
parents[1:5,1:5,with=FALSE]
#stop("hammertime")
#loading the progeny file
date()
#progeny<-fread('/group/jrigrp4/phasing/cj_teo_updated/teo_raw_biallelic_recoded_20160303_AGPv2.txt',sep="\t" , header = TRUE);
progeny<-fread('/group/jrigrp4/phasing/cj_teo_updated/teo_imputeR_03162016.txt',sep="\t", header = TRUE);
date()
dim(progeny)
progeny[1:5,1:5,with=FALSE]

#loading the file of loci >100 nt appart
good.loci<-fread("good_loci.txt",header=FALSE)
good.loci[1:5,]
names(good.loci)<-"locus"
#good.loci<-as.character(good.loci$locus)

good.loci[1:5,]

#selecting one family of selfed progeny
progeny.list<-parentage[parentage$Mother=="PC_I58_ID2"&parentage$Father=="PC_I58_ID2",]
#restrinting loci to chr 7
#progeny<-progeny[]
progeny.subset<-progeny[grep(paste("S",7,"_",sep=""), progeny$snpid),]
dim(progeny.subset)
progeny.subset[1:3,1:5,with=FALSE]
cat("\n")
progeny.subset<-as.data.frame(progeny.subset)
progeny.subset<-progeny.subset[progeny.subset$snpid %in% good.loci$locus,]
dim(progeny.subset)
cat("\n")
#progeny$snpid[1:10]
loci.names<-as.character(progeny.subset$snpid) 

progeny.subset[1:5,1:5]

#loci.names[1:10]
#progeny.list
progeny.subset<-progeny.subset[,as.character(progeny.list$Taxa)]
rownames(progeny.subset)<-loci.names
dim(progeny.subset)

progeny.subset<-progeny.subset[as.numeric(apply(progeny.subset,1,FUN=function(x){length(table(x))}))>1,]

loci.names<-rownames(progeny.subset)
dim(progeny.subset)
progeny.subset[1:5,1:5]

write.table(progeny.subset,file="PC_I58_ID2_selfed_family_imputed.txt",sep="\t")
#write.table(progeny.subset,file="PC_I58_ID2_selfed_family_imputed.txt",sep="\t")
#stop("stop here")
#window.size<-20
#window.overlap<-5
#geno.vector<-c("A/A","A/T","T/T",NA)
#GetGenotype<-function(numbers) {return(genotype(sapply(numbers,FUN=function(x) {return(geno.vector[x+1])})))}

#output.filename<-"ld_from_raw.txt"
output.filename<-"ld_from_imputed.txt"
 
cat(file=output.filename,"locus\tp.val\n");
for(window.start in 1:(dim(progeny.subset)[1])){
#for(window.start in 1:5){
 
    min.index<-max(1,window.start-10) 
    max.index<-min(window.start+10,dim(progeny.subset)[1])
    temp.r.values<-c()
    #cat(file=output.filename,"window defined by: ",min.index,max.index,"\n",sep="\t",append=TRUE)

    for(event.index in min.index:max.index){
      if(event.index!=window.start){
        locus1<-as.numeric(progeny.subset[window.start,])
        locus2<-as.numeric(progeny.subset[event.index,])
        #length(table(as.numeric(family[2764,])))
         cat(loci.names[window.start],loci.names[event.index],abs(cor(locus1,locus2,method="spearman",use="na.or.complete")),"\n")
        if(!is.na(cor(locus1,locus2,method="spearman",use="na.or.complete"))){
          temp.r.values<-c(temp.r.values,abs(cor(locus1,locus2,method="spearman",use="na.or.complete")))
        }
       }
     }  

##code for ld
 #  if(nallele(GetGenotype(locus1))+nallele(GetGenotype(locus2))==4){
 #    LD(GetGenotype(locus1),GetGenotype(locus2)) 
 #    cat(file=output.filename,as.character(loci.names[window.start]),as.character(loci.names[window.start+1]),LD(GetGenotype(as.matrix(locus1)),GetGenotype(as.matrix(locus2)))$"P-value","\n",sep="\t",append=TRUE)
##code for correlation
     #cat(file=output.filename,temp.r.values,"\n",sep=",",append=TRUE)
     if(length(temp.r.values)!=0){
       cat(file=output.filename,as.character(loci.names[window.start]),max(temp.r.values),"\n",sep="\t",append=TRUE)
     }
}
   



