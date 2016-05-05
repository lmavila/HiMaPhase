## Reads parental haplotypes and progeny genotype
## and runs the viterbi algorithm over our HMM
## to identify parental segments in the progeny
source("SharedFunctions.R")

parentage<-read.table('Parentage_for_imputeR.csv',sep=",",header=TRUE)
#parentage

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

# End of loading files, now  starting loop for each progeny individual
#initializing summary file
cat("num_taxa\ttaxa\tmom\tdad\tnum_rec_events\n",file="hmm-summary.txt")


### START OF MAIN LOOP
for (progeny.index in 1:100){
  progeny.individual.name<- parentage[progeny.index,1]
  #progeny.individual.name
  maternal.parent.name<-parentage[progeny.index,2]
  #maternal.parent.name
  paternal.parent.name<-parentage[progeny.index,3]
  #paternal.parent.name

  #formatting the data for our HMM

  mom.chromatid<-list(maternal=parents[,paste(maternal.parent.name,"_hap1",sep="")],paternal=parents[,paste(maternal.parent.name,"_hap2",sep="")])
  dad.chromatid<-list(maternal=parents[,paste(paternal.parent.name,"_hap1",sep="")],paternal=parents[,paste(paternal.parent.name,"_hap2",sep="")])

  ### testing with our HMM
  start.p<-c(0.25,0.25,0.25,0.25)
  trans.p<-GetTransitionProb(0.001)


  obs<-progeny[,as.character(progeny.individual.name)]
  #obs[1:10]
  #length(mom.chromatid$maternal)
  #length(obs)
  vit<-ViterbiWithMissingData(obs,start.p, trans.p,mom.chromatid,dad.chromatid,0.4)
  vitrowmax.2 <- apply(vit, 1, function(x) which.max(x))
  estimated<-rownames(trans.p)[vitrowmax.2]
  ## Some reports
  cat('\n################################################################\n')
  cat("taxa #",progeny.index,". Working with (taxa mom dad): ",sep="")
  cat(paste(as.character(parentage[progeny.index,1]) ,as.character(parentage[progeny.index,2]),as.character(parentage[progeny.index,3])  ),"\n")
  cat(progeny.index,as.character(parentage[progeny.index,1]) ,as.character(parentage[progeny.index,2]),as.character(parentage[progeny.index,3]),CountRecombEvents(estimated) ,"\n",file="hmm-summary.txt",append=TRUE,sep="\t")
  

  cat("Numb.recomb.events: ",CountRecombEvents(estimated),"\n")
  eventIndex<-ListRecombEvents(estimated)
  #cat(eventIndex)
  ## listing indexes of recombination events
  #eventIndex[1:max(20,length(eventIndex))]
  min.index<-1
  max.index<-1
  for(event.index in 1:length(eventIndex)){
    locus.index<-eventIndex[event.index]
    min.index<-max(1,locus.index-2)
    max.index<-min(length(obs),locus.index+2)

    cat("Recomb event at locus:",as.character(parents[locus.index,1]),as.character(parents[locus.index,2]),":",as.character(parents[locus.index,3]),"\n")
    cat("showing loci: ",as.character(progeny[min.index:max.index,1]),"\n")
    cat("mom.hap.1 ",mom.chromatid$maternal[min.index:max.index],"\n")
    cat("mom.hap.2 ",mom.chromatid$paternal[min.index:max.index],"\n")
    cat("dad.hap.1 ",dad.chromatid$maternal[min.index:max.index],"\n")
    cat("dad.hap.2 ",dad.chromatid$paternal[min.index:max.index],"\n")
    cat("child.gen ",obs[min.index:max.index],"\n")
    cat("child.phasing ",estimated[min.index:max.index],"\n");
    cat("\n")
 
  }
         
 
  ### For each recombination event we will show flanking loci
  ### for the panret haps and progeny

} # END OF MAIN LOOP

date()

#recomb.results<-read.table(file="hmm-summary.txt",header=TRUE)

