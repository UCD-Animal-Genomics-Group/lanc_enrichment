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

To get the gene list and the genes associated with mitochondrial function, the MitoCarta 2.0 database, as well as Ensemble Biomart were utilised. 

A gene list comprising all cattle genes was generated using [BovineMine1.6](http://128.206.116.13:8080/bovinemine/begin.do). From this approximately ~25,000 genes were downloaded into a tab separated file. Genes in this list were then assigned values for two categories. Broad and narrow. Broad included genes which were non-mitochondrial and mitochondrial. Narrow included non-mitochondrial, high-mt and low-mt. High and low-mt genes were found from the Zaidi *et al.* (2019) paper which listed them. These were then selected and using Ensemble biomart, the orthologous genes for cattle were determined for the ARS1.2 assembly. Following QC of the gene set, a total of 18,673 genes remained, of these genes, 138 were in the "high-mt" category and 701 were in the "low-mt" category. 

Following this, a list of SNPs and the respective local ancestries was generated from the data using R. The scripts used to generate the SNP file with respective local ancestries are *snpfile_generator.R* and *snpfile_joiner.R*. 

These two files were made to be in .BED format. To ensure all the files are in the correct format and in order the R script *gene_snp_list.R*  was used. The reason for using .bed format is that that BEDTOOLS will be used to generate windows of 2.5 Mb either side of the midpoint of the genes. The SNP data will be intersected with the gene data, which will output a file in the format which is detailed above. The command used to do this in BEDTOOLS is below:

```bash
bedtools window -a gene_lists.bed -b snp_lists.bed -w 2500000 > output.txt
```

Following this the output can be loaded into R and the *bootstraps.R* script can be run to perform a bootstrap analysis on the data. Following this the results can then be loaded into the *plots.R* script to load the plots.