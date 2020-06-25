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

Resulting object will be a list with each entry being one chromosome, within each chromosome will be an array with dimensions:
$$
A×2N×G
$$
Where A is the number of modelled ancestries, N is the number of target individuals and G is the number of SNPs. 

We can generate local ancestry plots for each chromosome using the R script *lanc_pos_plots.R*. 

