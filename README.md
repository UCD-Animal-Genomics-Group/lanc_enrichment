# Local Ancestry - mt Gene Enrichment

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

Resulting object will be a list with each entry being one chromosome, within each chromosome will be an array with dimensions *A x 2N x G*. Where A is the number of modelled ancestries, N is the number of target individuals and G is the number of SNPs. 

We can generate local ancestry plots for each chromosome using the R script *lanc_pos_plots.R*. 

### Gene Files

In order to use the script from the *Zaidi et al. 2019* paper, I will need to generate a file that has the following columns:

1. Gene chromosome
2. Gene start 
3. Gene end
4. Gene name
5. Broad category 
6. Narrow category
7. SNP chromosome
8. SNP start 
9. SNP end
10. Local ancestry 1
11. Local Ancestry 2

To get the gene list and the genes associated with mitochondrial function, the MitoCarta 2.0 database was utilised. A gene list comprising all cattle genes was generated using [BovineMine1.6](http://128.206.116.13:8080/bovinemine/begin.do). Genes in this list were then assigned values for two categories. Broad and narrow. Broad included genes which were non-mitochondrial and mitochondrial. Narrow included non-mitochondrial, high-mt and low-mt. In total the number of genes in the list came to ~25,000.

Following this, a list of SNPs and the respective local ancestries was generated from the data using R. 

These two files were made to be in .BED format, the reason being that BEDTOOLS will be used to generate windows of 2.5 Mb either side of the midpoint of the genes. The SNP data will be intersected with the gene data, which will output a file in the format which is detailed above. The command used to do this in BEDTOOLS is below:

```bash
bedtools window -a gene_lists.bed -b snp_lists.bed -w 2500000
```

