#script to generate bootstrapped loal ancestry estimates for genic windows
#load dependencies
library(data.table)
library(plyr)

args<-commandArgs(TRUE)
pop<-args[1]
n.bootstraps<-as.numeric(args[2])
weight<-as.logical(FALSE)

message("loading lanc file")

#load gene-based local ancestry estimates
lanc.mt<-fread("output.txt",header=F,sep="\t")

colnames(lanc.mt)<-c("gene.chr","gene.start","gene.stop","gene.name","broad.category","narrow.category","snp.chr","snp.start","snp.stop","indic.lanc","taur.lanc")

#remove rows where snps are missing
lanc.mt<-lanc.mt[which(lanc.mt$snp.chr!="."),]
lanc.mt$indic.lanc<-as.numeric(lanc.mt$indic.lanc)
lanc.mt$taur.lanc<-as.numeric(lanc.mt$taur.lanc)


message("generating list of genes")
#generate list of gene names
genes<-ddply(lanc.mt,.(broad.category),function(x){return(data.frame(gene.name=unique(x$gene.name)))})
genes$gene.name<-as.character(genes$gene.name)

message("calculating expected ancestry")
avg.indic.lanc <-mean(lanc.mt$indic.lanc)
avg.taur.lanc <-mean(lanc.mt$taur.lanc)

#write function to bootstrap for a specific function category
boot.dev<-function(functional_cat,nboot,weighted=FALSE){
  lanc.deviation<-matrix(NA,nrow=nboot,ncol=2)
  
  if(weighted==TRUE){
    pb<-txtProgressBar(min=0,max=nboot,style=3)
    for(i in 1:nboot){
      sample.genes<-sample(genes$gene.name[which(genes$broad.category==functional_cat)],164,replace=T)
      sample.lanc<-lanc.mt[which(lanc.mt$gene.name%in%sample.genes),]
      lanc.deviation[i,1]<-mean(sample.lanc$indic.lanc)-avg.indic.lanc
      lanc.deviation[i,2]<-mean(sample.lanc$taur.lanc)-avg.taur.lanc 
      setTxtProgressBar(pb,i)
    }
    colnames(lanc.deviation)<-c("Indicine","Taurine")
    lanc.deviation<-as.data.frame(lanc.deviation)
    lanc.deviation$category<-functional_cat
    return(lanc.deviation)
  }
  
  if(weighted==FALSE){
    pb<-txtProgressBar(min=0,max=nboot,style=3)
    for(i in 1:nboot){
      sample.genes<-sample(genes$gene.name[which(genes$broad.category==functional_cat)],164,replace=T)
      sample.lanc<-lanc.mt[which(lanc.mt$gene.name%in%sample.genes),]
      dsample.lanc<-ddply(sample.lanc,.(gene.name),summarize,indic.lanc=mean(indic.lanc),taur.lanc=mean(taur.lanc))
      lanc.deviation[i,1]<-mean(dsample.lanc$indic.lanc)-avg.indic.lanc
      lanc.deviation[i,2]<-mean(dsample.lanc$taur.lanc)-avg.taur.lanc
      setTxtProgressBar(pb,i)
    }
    colnames(lanc.deviation)<-c("Indicine","Taurine")
    lanc.deviation<-as.data.frame(lanc.deviation)
    lanc.deviation$category<-functional_cat
    return(lanc.deviation)
  }
}

message("bootstrapping high-mt genes")
high.lanc<-boot.dev("high-mt",1000, 0)

message("bootstrapping low-mt genes")
low.lanc<-boot.dev("low-mt",1000, 0)

message("bootstrapping non-mt genes")
non.lanc<-boot.dev("non-mt",1000, 0)

comb.lanc<-rbind(high.lanc,low.lanc,non.lanc)

message("writing to file")

if(weight==TRUE){
  fwrite(comb.lanc,paste(EASZ,"_lanc_deviation_bootstrap_weighted.txt",sep=""),col.names=T,row.names=F,quote=F,sep="\t")
}

if(weight==FALSE){
  fwrite(comb.lanc,"EASZ_lanc_deviation_bootstrap_unweighted.txt",col.names=T,row.names=F,quote=F,sep="\t")
}
