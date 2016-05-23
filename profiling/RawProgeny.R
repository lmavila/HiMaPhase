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
progeny<-read.table('/group/jrigrp4/phasing/cj_teo_updated/teo_raw_biallelic_recoded_20160303_AGPv2.txt',sep="\t" , header = TRUE);
date()
dim(progeny)

# End of loading files, now  starting loop for each progeny individual
#initializing summary file
cat("num_taxa\ttaxa\tmom\tdad\tnum_rec_events\n",file="raw-hmm-summary.txt")
#initializing CO events file
cat("num_taxa\ttaxa\tmom\tdad\tlocus\tchromosome\tphysical_position\n",file="raw-hmm-summary-co.txt")

### START OF MAIN LOOP
#for (progeny.index in 1:dim(parentage)[1]){
for (progeny.index in c(26,33,56,195,212)){

  progeny.individual.name<- parentage[progeny.index,1]
  #progeny.individual.name
  maternal.parent.name<-parentage[progeny.index,2]
  #maternal.parent.name
  paternal.parent.name<-parentage[progeny.index,3]
  #paternal.parent.name
  total.recomb.events<-0                           
  chromosomes<-as.character(levels(as.factor(parents$chr)))
  for(chromosome in chromosomes) #by chromosome
  {
     current.chromosome.parent.subset<-parents[parents$chr==chromosome,]
     current.chromosome.progeny.subset<-progeny[grep(paste("S",chromosome,"_",sep=""), progeny$snpid),]


     #formatting the data for our HMM

     mom.chromatid<-list(maternal=current.chromosome.parent.subset[,paste(maternal.parent.name,"_hap1",sep="")],paternal=current.chromosome.parent.subset[,paste(maternal.parent.name,"_hap2",sep="")])
     dad.chromatid<-list(maternal=current.chromosome.parent.subset[,paste(paternal.parent.name,"_hap1",sep="")],paternal=current.chromosome.parent.subset[,paste(paternal.parent.name,"_hap2",sep="")])
     obs<-current.chromosome.progeny.subset[,as.character(progeny.individual.name)]
    
    ###  burn-in to infer initial hidden state (initial phasing)
    cat("entering burn-in\n")
    num.burnin.loci<-50
    burnin.mom.chromatid<-list(maternal=mom.chromatid$maternal[1:num.burnin.loci],
                               paternal=mom.chromatid$paternal[1:num.burnin.loci])

    burnin.dad.chromatid<-list(maternal=dad.chromatid$maternal[1:num.burnin.loci],
                               paternal=dad.chromatid$paternal[1:num.burnin.loci])
    burnin.obs<-obs[1:num.burnin.loci] 

    burnin.start.p<-c(0.25,0.25,0.25,0.25)
    trans.p<-GetTransitionProb(0.0001)

    vit<-ViterbiWithMissingDataAndError(burnin.obs,
                                burnin.start.p, 
                                trans.p,
                                burnin.mom.chromatid,
                                burnin.dad.chromatid,0.1)

    vitrowmax.2 <- apply(vit, 1, function(x) which.max(x))
    cat("end of burn-in\n\n")
    #### now we used the inferred hidden state of the last of the burn-in loci
    #### as our starting probability for our actual complete run
    #### along the chromosome
    last.state<-vitrowmax.2[length(vitrowmax.2)]
    start.p<-c(last.state==1,last.state==2,last.state==3,last.state==4)
    start.p<-start.p+0 ## to transform TRUE,FALSE to 0,1

    # cat("observed for",as.character(progeny.individual.name)," :",obs[1:10],"\n")
    #length(mom.chromatid$maternal)
    #length(obs)

    #Now te actual run for the current chromosome, using the inferred initial state
    #cat("length obs",length(obs),"\n")
    #cat("length mom.maternal",length(mom.chromatid$maternal),"\n")

    vit<-ViterbiWithMissingDataAndError(obs,start.p, trans.p,mom.chromatid,dad.chromatid,0.1)
    vitrowmax.2 <- apply(vit, 1, function(x) which.max(x))
    estimated<-rownames(trans.p)[vitrowmax.2]
    ## Some reports per chromosome
    if(chromosome=="1") { #print header only at the start of chr1
      cat('\n################################################################\n')
      cat("taxa #",progeny.index,". Working with (taxa mom dad): ",sep="")
      cat(paste(as.character(parentage[progeny.index,1]) ,
         as.character(parentage[progeny.index,2]),
         as.character(parentage[progeny.index,3])  ),"\n")
    }

    cat("Chromosome",chromosome,"events: ",CountRecombEvents(estimated),"\n")
    total.recomb.events<-total.recomb.events+CountRecombEvents(estimated)
    if(CountRecombEvents(estimated)>0){

      #cat("Numb.recomb.events: ",CountRecombEvents(estimated),"\n")
       eventIndex<-ListRecombEvents(estimated)
      #cat(eventIndex)
      ## listing indexes of recombination events
      #cat("eventIndex:",eventIndex[1:max(20,length(eventIndex))],"\n")
      #cat("length(eventIndex)",length(eventIndex),"\n")
      min.index<-1
      max.index<-1
      for(event.index in 1:length(eventIndex)){
        locus.index<-eventIndex[event.index]
        min.index<-max(1,locus.index-2)
        max.index<-min(length(obs),locus.index+2)
        #cat("locus.index,min.index,max.index: ",locus.index,min.index,max.index,"\n",sep=",")
        #cat("num_taxa\ttaxa\tmom\tdad\tnum_rec_events\n",file="hmm-summary.txt")
        cat(progeny.index,
            as.character(parentage[progeny.index,1]),
            as.character(parentage[progeny.index,2]),
            as.character(parentage[progeny.index,3]),
            as.character(current.chromosome.parent.subset[locus.index,1]),
            as.character(current.chromosome.parent.subset[locus.index,2]),
            as.character(current.chromosome.parent.subset[locus.index,3]),
            sep="\t","\n",file="raw-hmm-summary-co.txt",append=TRUE)
 

        cat("Recomb event at locus:",as.character(current.chromosome.parent.subset[locus.index,1]),
                                   as.character(current.chromosome.parent.subset[locus.index,2]),
                               ":",as.character(current.chromosome.parent.subset[locus.index,3]),"\n")
        cat("showing loci: ",as.character(current.chromosome.progeny.subset[min.index:max.index,1]),"\n")
        cat("mom.hap.1 ",mom.chromatid$maternal[min.index:max.index],"\n")
        cat("mom.hap.2 ",mom.chromatid$paternal[min.index:max.index],"\n")
        cat("dad.hap.1 ",dad.chromatid$maternal[min.index:max.index],"\n")
        cat("dad.hap.2 ",dad.chromatid$paternal[min.index:max.index],"\n")
        cat("child.gen ",obs[min.index:max.index],"\n")
        cat("child.phasing ",estimated[min.index:max.index],"\n");
        cat("\n")
      } #end  of recomb.event report
    }  #end of num.recomb.events>1
         
  } ## END OF CHROMOSOME LOOP
      cat(progeny.index,as.character(parentage[progeny.index,1]) ,
        as.character(parentage[progeny.index,2]),
        as.character(parentage[progeny.index,3]),
        total.recomb.events,
        "\n",file="raw-hmm-summary.txt",append=TRUE,sep="\t")
  
  ### For each recombination event we will show flanking loci:
  ### for the parent haps and progeny

} # END OF MAIN LOOP

date()

#recomb.results<-read.table(file="hmm-summary.txt",header=TRUE)

