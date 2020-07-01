read_snpinfo <- function(chr) {
  assign(paste0("snpfile.",chr), chr) <<- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",chr, ".csv"), row.names=1)
}

read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",5, ".csv"), row.names=1)


chr1 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",1, ".csv"), row.names=1)
chr2 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",2, ".csv"), row.names=1)
chr3 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",3, ".csv"), row.names=1)
chr4 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",4, ".csv"), row.names=1)
chr5 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",5, ".csv"), row.names=1)
chr6 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",6, ".csv"), row.names=1)
chr7 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",7, ".csv"), row.names=1)
chr8 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",8, ".csv"), row.names=1)
chr9 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",9, ".csv"), row.names=1)
chr10 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",10, ".csv"), row.names=1)
chr11 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",11, ".csv"), row.names=1)
chr12 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",12, ".csv"), row.names=1)
chr13 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",13, ".csv"), row.names=1)
chr14 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",14, ".csv"), row.names=1)
chr15 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",15, ".csv"), row.names=1)
chr16 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",16, ".csv"), row.names=1)
chr17 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",17, ".csv"), row.names=1)
chr18 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",18, ".csv"), row.names=1)
chr19 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",19, ".csv"), row.names=1)
chr20 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",20, ".csv"), row.names=1)
chr21 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",21, ".csv"), row.names=1)
chr22 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",22, ".csv"), row.names=1)
chr23 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",23, ".csv"), row.names=1)
chr24 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",24, ".csv"), row.names=1)
chr25 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",25, ".csv"), row.names=1)
chr26 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",26, ".csv"), row.names=1)
chr27 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",27, ".csv"), row.names=1)
chr28 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",28, ".csv"), row.names=1)
chr29 <- read.csv(paste0("~/projects/mito_disequilibria/second_analysis/output/MOSAIC_inputs/snpinfo_files/snpinfo",29, ".csv"), row.names=1)


allSNPinfo <- do.call("rbind", list(chr1, 
                                 chr2, 
                                 chr3, 
                                 chr4, 
                                 chr5, 
                                 chr6, 
                                 chr7, 
                                 chr8, 
                                 chr9, 
                                 chr10, 
                                 chr11, 
                                 chr12, 
                                 chr13, 
                                 chr14, 
                                 chr15, 
                                 chr16, 
                                 chr17, 
                                 chr18, 
                                 chr19, 
                                 chr20, 
                                 chr21, 
                                 chr22, 
                                 chr23, 
                                 chr24, 
                                 chr25, 
                                 chr26, 
                                 chr27, 
                                 chr28, 
                                 chr29))

write.table(allSNPinfo, "../MOSAIC_inputs/snpinfo_files/allSNPinfo.txt", row.names = F, col.names = T, quote = F)
