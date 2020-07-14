library(dplyr)
high_mt_genes <- high_mt_genes[,-c(1)]
colnames(high_mt_genes) <- c("gene.name", "gene.chr", "gene.start", "gene.end")
high_mt_genes <- high_mt_genes[,c(2, 3,4,1)]
high_mt_genes$gene.chr <- paste0("Chr", high_mt_genes$gene.chr)
high_mt_genes$broad.category <- "mt"
high_mt_genes$narrow.category <- "high-mt"

low_mt_genes <- low_mt_genes[,-c(1)]
colnames(low_mt_genes) <- c("gene.name", "gene.chr", "gene.start", "gene.end")
low_mt_genes <- low_mt_genes[,c(2, 3,4,1)]
low_mt_genes$gene.chr <- paste0("Chr", low_mt_genes$gene.chr)
low_mt_genes$broad.category <- "mt"
low_mt_genes$narrow.category <- "low-mt"

all_cattle_genes_ARS <- all_cattle_genes_ARS[,-c(4)]
colnames(all_cattle_genes_ARS) <- c("gene.chr", "gene.start", "gene.end", "gene.name")
all_cattle_genes_ARS$broad.category <- "non-mt"
all_cattle_genes_ARS$narrow.category <- "non-mt"

all_genes <- do.call("rbind", list(all_cattle_genes_ARS, low_mt_genes, high_mt_genes))
dups <- all_genes[duplicated(all_genes$gene.name),]                     
dups <- all_genes[,all_genes$broad.category]

dups <- all_genes %>%
  filter(duplicated(.[["gene.name"]]))

dups <- subset(dups, broad.category=="non-mt")

all_cattle_genes <- all_genes %>% anti_join(dups)

all_cattle_genes <- all_cattle_genes[
  order( all_cattle_genes[,1], all_cattle_genes[,2] ),
  ]

write.table(all_cattle_genes, "all_cattle_genes.bed", col.names = F, row.names = F, quote = F, sep = "\t")
write.table(BorgouSNPinfo, "borgou_snp_info.bed", col.names = F, row.names = F, quote = F,sep = "\t")
write.table(EASZ_SNPinfo, "easz_snp_info.bed", col.names = F, row.names = F, quote = F,sep = "\t")
