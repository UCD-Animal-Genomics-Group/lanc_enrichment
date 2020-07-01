#script used to generate local ancestry plots from MOSAIC data.

library(reshape2)
library(ggplot2)
library(magrittr)
library(scales)

load("lanc_pos.RData")

lanc_pos_plots <- function(chr) {
  lanc_chr <- local_pos[[chr]]
  z <- dim(local_pos[[chr]])[3]
  x <- list()
  for (i in 1:z) {
    x[[i]] <- mean(lanc_chr[1,1:184,i]) 
  }
  y <- list()
  for (i in 1:z) {
    y[[i]] <- mean(lanc_chr[2,1:184,i])
  }
  
  chr_pos<- do.call(rbind, Map(data.frame, Indicine=x, Taurine=y))
  snpfile <- read.table(paste0("snpfile.",chr))
  chr_pos$Position <- snpfile$V4
  chr_pos <- chr_pos[!duplicated(chr_pos$Position),]
  
  mchr_pos <- melt(chr_pos, id.vars=c("Position"), variable.name="Ancestry", value.name="Ancestry_Proportion")
  
  mchr_pos$Ancestry %<>% factor(levels = c("Taurine", "Indicine"))
  
  col29 = c("#1f77b4", "#d62728")
  names(col29) = levels(mchr_pos$Ancestry)
  
   ggplot(mchr_pos, aes(x=Position, y=Ancestry_Proportion, fill=Ancestry)) + 
    geom_area() +
    theme_classic() +
    theme(legend.key=element_rect(colour="black")) +
    labs(title = "MOSAIC Local Ancestry") +
    scale_x_continuous(name=paste0("Position on Chromosome",chr), labels = label_number_si(unit = "b"), expand=c(0, 0)) +
    scale_y_continuous(name="Mean Ancestry", labels = label_percent(), expand=c(0, 0)) +
    scale_fill_manual(values=col29) +
    guides(fill=guide_legend(override.aes=list(colour=NULL)))
   
   ggsave(filename=paste0("../MOSAIC_inputs/MOSAIC_PLOTS/lanc_pos_plots/lanc_pos_chr",chr,".png"), plot=last_plot(), width = 6, height = 4, units = "in")
  
}

chrs <- 1:29

lapply(chrs, lanc_pos_plots)
