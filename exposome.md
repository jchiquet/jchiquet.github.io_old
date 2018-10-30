---
layout: default
title: Exposome Advance - Biological Network Inference with Sparse Gaussian Graphical Models 
---

<div class="bs-callout bs-callout-info">
<a href="doc/teachings/exposome/transcriptomics_networks_inference.html"> Tutorial on preliminary analysis of exposome transcriptomics data</a>
</div>

### <span class="glyphicon glyphicon-calendar"></span> Contents

This session aims to provide an overview of sparse Gaussian graphical
models and their used for inferring networks from transcriptomic data.

During the practical, we will illustrate these methods on two
transcriptomic data set by means of R. We will also perform some small
numerical experiments to understand the notion of partial correlation
and what those GGM represent from the statistical point of view.

### <span class="glyphicon glyphicon-download-alt"></span> Documents 

* [slides](doc/teachings/exposome/slides.pdf), [short version!](doc/teachings/exposome/surf64.pdf) for the Surf64 summer school

#### London practical

* [practical sheet in PDF](doc/teachings/exposome/td_exposome_sheet.pdf) or [practical sheet in html](doc/teachings/exposome/td_exposome_sheet.html)
* [practical correction sheet](doc/teachings/exposome/td_exposome_correction.pdf) or [practical sheet in html](doc/teachings/exposome/td_exposome_correction.html) _Use with parcimony and only when necessary_
* [zip file with all the data sets](data/data_school.zip)

#### Anglet tutorial

* [Tutorial on preliminary analysis of exposome transcriptomics data](doc/teachings/exposome/transcriptomics_networks_inference.html)

### <span class="glyphicon glyphicon-download-alt"></span> External resources

* [Course on Statistical Network Analysis](https://github.com/jchiquet/CourseStatNetwork)
* [Course on Advanced R](https://github.com/jchiquet/CourseAdvancedR)

### <span class="glyphicon glyphicon-download-alt"></span> Technical point

#### R version and Packages 

You need a recent R version installed with the following packages (including their dependencies)

- tidyverse, huge, igraph, QUIC, stabs, limma (bioconductor)

#### A couple of R functions

-  [functions for computing ROC curves + AUC + multiple plots with ggplot2](doc/teachings/exposome/external_functions.R)
