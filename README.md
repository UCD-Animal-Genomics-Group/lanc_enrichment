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

The result will be 29 arrays, for each chromosome, that contain *x* number of matrices, where *x* is the number of SNPs at that chromosome, each with two rows, and 184 columns making up the local ancestry estimates or taurine/indicine as there are 92 samples, 92*2 = 184.

```R
local_pos_chr29 <- local_pos[[29]]
list <- local_pos_chr29[1:2,1:5,1:5]
```

 

