load("../MOSAIC_inputs/MOSAIC_RESULTS/lanc_pos_EASZ.RData")

lanc_snpinfo <- function(chr) {
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

  chr_pos<- do.call(rbind, Map(data.frame, tau_lanc=x, idc_lanc=y))
  snpfile <- read.table(paste0("snpfile.",chr))
  chr_pos$snp.start <- snpfile$V4
  chr_pos$snp.end <- snpfile$V4
  chr_pos$snp.end <- snpfile$V4
  chr_pos$snp.chr <- snpfile$V2
  chr_pos <- chr_pos[!duplicated(chr_pos$snp.start),]

  chr_pos <- chr_pos[c("snp.chr", "snp.start", "snp.end", "tau_lanc", "idc_lanc")]

  write.csv(chr_pos, file = paste0("../MOSAIC_inputs/snpinfo_files/EASZ/snpinfo",chr,".csv") )
}

chrs <- 1:29

lapply(chrs, lanc_snpinfo)