#altered script to generate plots assocaited with bootstrap script.
library(ggplot2)
library(plyr)
library(data.table)
library(reshape2)

easz<-fread("EASZ_lanc_deviation_bootstrap_unweighted.txt",header=T)

easz$pop<-"EASZ"

comb<- easz

mcomb<-melt(comb,id.vars=c("category","pop"))
colnames(mcomb)<-c("Category","Pop","Ancestry","Deviation")

dmcomb<-ddply(mcomb,
              .(Pop,Ancestry,Category),
              summarize,
              median=median(Deviation),
              lower=quantile(Deviation,probs=c(0.025)),
              upper=quantile(Deviation,probs=c(0.975))
)

box.plts<-ggplot()+
  geom_violin(data=mcomb,aes(Category,Deviation))+
  geom_point(data=dmcomb,aes(Category,median),color="blue")+
  geom_errorbar(data=dmcomb,aes(x=Category,ymin=lower,ymax=upper),color="blue",width=0.5)+
  geom_hline(yintercept = 0,color="red",linetype="dashed")+
  facet_grid(Pop~Ancestry,scales="free_y")+
  scale_x_discrete(labels=c("High-mt","Low-mt","Non-mt"))+
  theme_bw()+
  theme(strip.text.y=element_text(angle = 0,size=14),strip.text.x=element_text(size=14),axis.text.x=element_text(angle=90,size=14),axis.title=element_text(size=18))

ggsave("lanc_deviation_boxplts_06122018.pdf",box.plts,height=10,width=7)
