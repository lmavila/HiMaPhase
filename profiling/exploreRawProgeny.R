date()
#progeny<-read.table('/group/jrigrp4/phasing/cj_teo_updated/teo_imputeR_03162016.txt',sep="\t" , header = TRUE);
#progeny<-read.table('/group/jrigrp4/phasing/cj_teo_updated/teo_imputeR_short2.txt', header = TRUE,sep="\t");
progeny<-read.table('/group/jrigrp4/phasing/cj_teo_updated/teo_raw_biallelic_recoded_20160303_AGPv2.txt',sep="\t" , header = TRUE);

date()
dim(progeny)
summary(progeny[,1:7])
progeny[1:5,1:5]

#obs<-progeny[,as.character(progeny.individual.name)]
progeny[1:10,"A0066"]

##
progeny[1:10,"PC_I11_ID2"]
progeny[1:10,"PC_I50_ID2"]
progeny[1:10,"A0064"]
progeny[1:10,"A2643"]


#write.table(data.frame(progeny[,1],progeny[,"A0118"]),sep="\t",file="A0118_raw.txt")
date()
genotype.names<-colnames(progeny)
genotype.names<-genotype.names[2:length(genotype.names)]
genotype.names<-genotype.names[4:length(genotype.names)]
for(genotype.name in genotype.names){
  obs<-progeny[,genotype.name]
  obs.table<-table(obs)
  cat(genotype.name,obs.table, obs.table["3"]/length(obs),"\n",sep="\t")

}
#levels(as.factor($chr))
#levels(as.factor(parents[,4]))
