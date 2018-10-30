---
layout: default
title: Simone software home page
---

### SIMoNe software home page

#### Context

SIMoNe (Statistical Inference for MOdular NEtworks) is an `R` package
which implements the inference of co-expression networks based on
partial correlation coefficients from either steady-state or
time-course transcriptomic data. Note that with both type of data this
package can deal with samples collected in different experimental
conditions and therefore not identically distributed. In this
particular case, multiple but related graphs are inferred on one
simone run.

The underlying statistical tools enter the framework of Gaussian
graphical models (GGM). Basically, the algorithm searches for a latent
clustering of the network to drive the selection of edges through an
adaptive l1-penalization of the model likelihood.

#### Slides

<div id="__ss_4344157"><object id="__sse4344157" width="700" height="583">
<embed name="__sse4344157" src="http://static.slidesharecdn.com/swf/ssplayer2.swf?doc=slides-100528105210-phpapp01&stripped_title=simone-4344157" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="700" height="583"></embed></object>
</div>

#### Features

The available inference methods for edges selection include

* *neighborhood selection* as in Meinshausen and Buhlman (2006), steady-state data only;
* *graphical Lasso* as in Banerjee et al, 2008 and Friedman et al (2008), steady-state data only;
* *VAR(1) inference* as in Charbonnier, Chiquet and Ambroise (2010), time-course data only;
* *multitask learning* as in Chiquet, Grandvalet and Ambroise (preprint), both time-course and steady-state data. 

All the listed methods are based l1-norm penalization, with an
additional grouping effect for multitask learning (including three
variants: "intertwined", "group-Lasso" and "cooperative-Lasso").

The penalization of each individual edge may be weighted according to
a latent clustering of the network, thus adapting the inference of the
network to a particular topology. The clustering algorithm is
performed by the mixer package, based upon Daudin, Picard and Robin
(2008)'s Mixture Model for Random Graphs.

Since the choice of the network sparsity level remains a current issue
in the framework of sparse Gaussian network inference, the algorithm
provides a full path of estimators starting from an empty network and
adding edges as the penalty level progressively decreases. Bayesian
Information Criteria (BIC) and Akaike Information Criteria (AIC) are
adapted to the GGM context in order to help to choose one particular
network among this path of solutions.

Graphical tools are provided to summarize the results of a SIMoNe run
and offer various representations for network plotting.

#### Demos and code examples

##### Cancer data, pooled estimate

~~~
library(simone)
data(cancer)
str(cancer, max.level=1)

attach(cancer)
boxplot(expr, las=3, cex.axis=0.6)
table(status)

## no clustering by default
res.no <- simone(expr)
plot(res.no) ## "trop" de monde sur BIC / AIC
g.no <- getNetwork(res.no, 30)
plot(g.no)
plot(g.no, type = "cluster")

## try with clustering now
ctrl <- setOptions(clusters.crit=30)
res.cl <- simone(expr, clustering=TRUE, control=ctrl)
g.cl <- getNetwork(res.cl, 30)
plot(g.cl)
plot(g.cl, type = "circles")

## Let us compare the two networks
plot(g.no,g.cl)
plot(g.no,g.cl, type="overlap")
~~~

##### Cancer data, multi-task learning

~~~
library(simone)
data(cancer)
str(cancer, max.level=1)

attach(cancer)
boxplot(expr, las=3, cex.axis=0.6)
table(status)

out <- simone(expr, tasks=status)

plot(out)

glist <- getNetwork(out, "AIC")
plot(glist[[1]],glist[[2]])
glist <- getNetwork(out, "BIC")
plot(glist[[1]],glist[[2]])
glist <- getNetwork(out, 65)
plot(glist[[1]],glist[[2]])
plot(glist[[1]],glist[[2]], type="overlap")

detach(cancer)
~~~

#### installation

Within `R`, just type 

~~~
install.packages("simone")
~~~

#### First steps

Have a look at the [documentation](http://cran.r-project.org/web/packages/simone/simone.pdf). You may also check the demos:

~~~
demo(cancer_pooled)
demo(cancer_multitask)
demo(check_glasso, echo=FALSE)
demo(simone_steadyState)
demo(simone_timeCourse)
demo(simone_multitask)
~~~

#### Contacts

* bugs, maintenance, feedback, questions: <a href="mailto:julien [dot] chiquet [at] genopole [dot] cnrs [dot] fr">julien [dot] chiquet [at] genopole [dot] cnrs [dot] fr</a>

#### References

* J. Chiquet, Y. Grandvalet, and C. Ambroise (2010). Inferring multiple graphical structures, Statistics and Computing. http://dx.doi.org/10.1007/s11222-010-9191-2 

* C. Charbonnier, J. Chiquet, and C. Ambroise (2010). Weighted-Lasso for Structured Network Inference from Time Course Data. Statistical Applications in Genetics and Molecular Biology, vol. 9, iss. 1, article 15. http://www.bepress.com/sagmb/vol9/iss1/art15/

* C. Ambroise, J. Chiquet, and C. Matias (2009). Inferring sparse Gaussian graphical models with latent structure. Electronic Journal of Statistics, vol. 3, pp. 205–238. http://dx.doi.org/10.1214/08-EJS314

* O. Banerjee, L. El Ghaoui, A. d'Aspremont (2008). Model Selection Through Sparse Maximum Likelihood Estimation. Journal of Machine Learning Research, vol. 9, pp. 485–516. http://www.jmlr.org/papers/volume9/banerjee08a/banerjee08a.pdf

* J. Friedman, T. Hastie and R. Tibshirani (2008). Sparse inverse covariance estimation with the graphical Lasso. Biostatistics, vol. 9(3), pp. 432–441. http://www-stat.stanford.edu/~tibs/ftp/graph.pdf

* N. Meinshausen and P. Buhlmann (2006). High-dimensional graphs and variable selection with the Lasso. The Annals of Statistics, vol. 34(3), pp. 1436–1462. http://projecteuclid.org/DPubS/Repository/1.0/Disseminate?view=body&id=pdfview_1&handle=euclid.aos/1152540754

* J.-J. Daudin, F.Picard and S. Robin, S. (2008). Mixture model for random graphs. Statistics and Computing, vol. 18(2), pp. 173–183. http://www.springerlink.com/content/9v6846342mu82x42/fulltext.pdf 
