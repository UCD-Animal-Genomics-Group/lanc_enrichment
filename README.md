# rLocal Ancestry - mt Gene Enrichment

*For project on enrichment of mitochondrial genes.*

*Having completed local ancestry analysis using MOSAIC, I will now look at the resulting files and pull the necessary information from them to determine if mitochondrial genes are enriched in regions of high taurine local ancestry.* 

### MOSAIC Outputs

To load the output from MOSAIC the following commands in R are used:

```R
load("MOSAIC_RESULTS/EASZ_2way_1-92_1-29_300_60_0.99_100.RData")
load("MOSAIC_RESULTS/localanc_EASZ_2way_1-92_1-29_300_60_0.99_100.RData")
```

This will load all the lists generated, we are interested in the *localanc* list for the moment.  These *localanc* calculations show local ancestry along evenly spaced gridpoints on recombination. We want the local ancestry estimates on SNP positions, we can get this using:

```R
local_pos=grid_to_pos(localanc,"../MOSAIC_output/",g.loc,chrnos)
```

Resulting object will be a list with each entry being one chromosome, within each chromosome will be an array with dimensions:
$$
A×2N×G
$$
Where A is the number of modelled ancestries, N is the number of target individuals and G is the number of SNPs. 

Following are attempts to create local ancestry plots for SNP positions:

```R
library(reshape2)
library(ggplot2)

load("lanc_pos.RData")
lanc_chr <- local_pos[[7]]

lanc_plots <- function(chrno) {
  x <- list()
  for (i in 1:26780) {
    x[[i]] <- mean(lanc_chr[1,1:184,i]) 
  }
  y <- list()
  for (i in 1:26780) {
    y[[i]] <- mean(lanc_chr[2,1:184,i])
  }
  
  chr_pos<- do.call(rbind, Map(data.frame, Indicine=x, Taurine=y))
  snpfile <- read.table(paste0("snpfile.",chrno))
  chr_pos$Position <- snpfile$V4
  
  mchr_pos <- melt(chr_pos, id.vars=c("Position"), variable.name="Ancestry", value.name="Ancestry_Proportion")
  
  png(paste0("lanc_chr",chrno,".png"), width = 6, height = 4, units = "in", res = 150)
  ggplot(mchr_pos, aes(x=Position, y=Ancestry_Proportion, fill=Ancestry)) + 
    geom_area()
  dev.off()
}

lanc_plots(7)
```

```R
x <- list()
for (i in 1:26780) {
  x[[i]] <- mean(lanc_chr[1,1:184,i]) 
}
y <- list()
for (i in 1:26780) {
  y[[i]] <- mean(lanc_chr[2,1:184,i])
}

chr_pos<- do.call(rbind, Map(data.frame, Indicine=x, Taurine=y))
snpfile <- read.table(paste0("snpfile.",7))
chr_pos$Position <- snpfile$V4

mchr_pos <- melt(chr_pos, id.vars=c("Position"), variable.name="Ancestry", value.name="Ancestry_Proportion")

png(paste0("lanc_chr",7,".png"), width = 6, height = 4, units = "in", res = 150)
ggplot(mchr_pos, aes(x=Position, y=Ancestry_Proportion, fill=Ancestry)) + 
  geom_area()
dev.off()
```

