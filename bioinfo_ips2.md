---
layout: default
title: Summer school in Port-Royal - From gene expression to genomic network
---

### <span class="glyphicon glyphicon-calendar"></span> Contents

This session aims to provide an overview of sparse Gaussian graphical
models and their used for inferring networks from transcriptomic data.

During the practical, we will illustrate these methods on two
transcriptomic data set by means of R. We will also perform some small
numerical experiments to understand the notion of partial correlation
and what those GGM represent from the statistical point of view.

### <span class="glyphicon glyphicon-download-alt"></span> Documents 

* [slides](doc/teachings/ips2/slides.pdf)
* [practical sheet](doc/teachings/ips2/td_ips2.pdf)
* [practical correction sheet](doc/teachings/ips2/td_ips2_correction.pdf) _Use with parcimony and only when necessary_
* [summary of main R commands](doc/teachings/commandes_r.pdf)
* [zip file with all the data sets](data/data_school.zip)

### <span class="glyphicon glyphicon-download-alt"></span> Technical point

#### R version and Packages 

You need a recent R version installed with the following packages (including their dependencies)

- huge, ggplot2, spikeslab, scales, reshape2, parallel (or doMC) (hopefully that's all...)

#### A couple of R functions

-  [functions for computing ROC curves + AUC + multiple plots with ggplot2](doc/teachings/ips2/external_functions.R)
