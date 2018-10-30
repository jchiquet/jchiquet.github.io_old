---
layout: default
title: Bioinformatics summer school in Angers - Statistics and Classification for Genomic data
---

### <span class="glyphicon glyphicon-calendar"></span> Contents

This session aims to provide an overview of a series of statistical
methods now routinely used to process genomic data. The statistical
tasks at play will concern both supervised and unsupervised
classification problems.

During the practical, we will illustrate these methods on the
classical Golub data set by means of R.

### <span class="glyphicon glyphicon-download-alt"></span> Documents 

* [slides](doc/teachings/angers/slides_angers.pdf)
* [practical sheet](doc/teachings/angers/td_angers.pdf)
* [practical correction sheet](doc/teachings/angers/td_angers_cor.pdf) _Use with parcimony and only when necessary_
* [Golub data set](doc/teachings/angers/leukemia.RData)
* [summary of main R commands](doc/teachings/commandes_r.pdf)

### <span class="glyphicon glyphicon-download-alt"></span> Technical point

#### R version and Packages 

You need a recent R version installer with the following packages (including their dependencies)

- glmnet, grpreg, mclust, ggplot2, spikeslab, FactoMineR, scales, reshape2, parallel (or doMC) (hopefully that's all...)

#### A couple of R functions

-  [function for computing the BIC/ICL of the k-means clustering](doc/teachings/angers/func_BIC.R)
-  [function for performing spectral clustering](doc/teachings/angers/func_spectralClustering.R)
-  [function for a fancy representation of a matrix](doc/teachings/angers/func_matplot.R)
