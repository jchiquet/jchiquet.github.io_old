---
layout: default
title: Projet Modélisation
---

<div class="bs-callout bs-callout-warning"> <span class="glyphicon glyphicon-warning-sign"></span> 
This page written in French is out of date, yet it contains some
materials and links that might be interesting for students
</div>

### Le sujet et les données

Choisir librement un jeu de données adapté à la régression linéaire
multivarié et qui contienne au moins une dizaine de prédicteurs, par
exemple

* sur le [dépôt Machine-Learning
  UCI](http://archive.ics.uci.edu/ml/datasets.html
  format=&task=&att=&area=&numAtt=&numIns=&type=&sort=taskDown&view=table)
  parmi les données multivariées ('Data type : Multivariate')
  destinées à un problème de régression ('Default Task : Regression'),
  * parmi des données du package `faraway` de `R`, * à la page
  [http://www-stat.stanford.edu/~tibs/ElemStatLearn/](http://www-stat.stanford.edu/~tibs/ElemStatLearn/),
  * etc.

Traiter le jeu de données choisi à l'aide d'un modèle linéaire
multivarié. Utiliser diverses méthodes de sélection de variable
(stepwise, forward/backward selection) et de régression biaisées
(ridge/Lasso/etc) pour proposer un modèle qui vous semblera
adéquate. Évaluer l'erreur de prédiction commise (avec validation
croisée, ensemble test/apprentissage). Vous pourrez comparer vos
modèles avec celui des moindres carrés quand cela est possible, pour
lequel les techniques habituelles adaptées au modèle linéaire
(bootstrap, régression robuste, analyse des résidus, etc.) peuvent
être envisagées.

Pour chacun des jeux de données, vous commencerez par une étude de
statistiques descriptives : posez-vous des questions sur les données,
en trouvez des pistes à l'aide d'histogrammes, de nuages de points,
boîtes à moustaches, moyennes, variances, etc. Si vous choisissez
d'ôter des données, recomposer l'échantillon, cela peut être une bonne
idée, mais justifiez-le !

### Étude des données prostate

Vous pourrez vous faire les dents sur les données prostates afin de
tester la validité des scripts `R` implémentés. Nous allons
retrouver les résultats du livre *The Elements of Statistical
Learning - 2nd Edition* en testant les modèles sur les données de
cancer de la prostate.

* [Le fichier de données](doc/teachings/ensiie/prostate.rda) contient 3
  variables : une matrice de prédicteurs ''x'', une matrice de
  réponses ''y'' et un vecteur ''set'' indiquant l'appartenance à
  l'ensemble de d'apprentissage.
* [Mon fichier de fonctions](doc/teachings/ensiie/functions_mpr.r) pourrait vous être utile
* [Mon fichier de fonctions](doc/teachings/ensiie/functions_cv_mpr.r)
  pour la validation croisée (à compléter par vous pour d'autres
  méthodes que le Lasso et la ridge).

#### Les moindres carrés ordinaires

[Résolution commentée](doc/teachings/ensiie/ols.pdf)

Nous dérivons l'estimateur des moindres carrés, son biais, sa variance
et mettons en place le test d'hypothèse fondé sur le Z-score pour
décider de la nullité d'un paramètre. Un script `R` complet et
commenté implémente ces résultats.

#### La régression ridge

[Quelques notes sur la régression ridge](doc/teachings/ensiie/ridge.pdf)

Nous dérivons l'estimateur de la régression *ridge*, qui pénalise la
taille des coefficients à estimer, réduisant donc la variance mais
augmentant le biais par rapport au moindres carrés.

#### Les méthodes de régularisation en norme 1

[Présentation du Lasso et de ses dérivées](doc/teachings/ensiie/l1_reg.pdf)

Nous présentons les critères du Lasso, de l'elastic-net, du
group-lasso et de l'adaptive Lasso. Nous montrons comment les calculer
en pratique sous `R`. On étudie le problème des données
`prostate`.

Sous `R`, ces problèmes peuvent être résolus à l'aide des packages
`lars`, `glmnet` et `grplasso`.

#### Validation croisée et choix de paramètres

[Présentation de la validation croisée pour le choix de lambda](doc/teachings/ensiie/cv_l1.pdf)

Nous présentons la validation croisée comme estimation de l'erreur de
prédiction. Nous montrons comment l'appliquer au choix du paramètre de
pénalisation dans les méthodes ridge et Lasso. Ceci se généralise
facilement aux autres méthodes étudiées.


### Bibliographie

#### Modèle linéaire avec R

Un [livre dévolu à la pratique de la régression sous
R](http://cran.r-project.org/doc/contrib/Faraway-PRA.pdf).

#### Apprentisssage Statistique

Un [livre de
référence](http://www-stat.stanford.edu/~tibs/ElemStatLearn/index.html)
disponible *gratuitement* au format PDF (à voir en particulier: les
chapitres 3 et 7 pour la régression linéaire pénalisée et la
validation croisée)

#### L'article fondateur du Lasso

Tibshirani, R. (1996), Regression shrinkage an selection via the Lasso, *Journal of the Royal Statistical Society*, vol. 58, pp 267--288, [preprint](http://www-stat.stanford.edu/~tibs/lasso/lasso.pdf/),

#### Algorithme de résolution

Un article répertoriant les méthodes de type Lasso, group-Lasso,
Elastic-Net, etc. pouvant être résolu via un algorithme très simple de
descente de coordonnées (le lecture des premières pages est suffisante
pour vous).

Friedman, J. and Hastie, T. and Hoefling, H. and Tibshirani,
R. (2007), Pathwise coordinate optimization, vol. 1, pp 302--332,
*Annals of Applied Statistics*,
[preprint](http://www-stat.stanford.edu/~hastie/Papers/pathwise.pdf)

### Documentation R

* [L'introduction officielle](http://stat.genopole.cnrs.fr/dw/~jchiquet/fr/softwares)
* [Une bonne introduction pour commencer pratiquement](http://cran.r-project.org/doc/contrib/Paradis-rdebuts_fr.pdf)
* [Une ref-card](doc/teachings/commandes_r.pdf) des commandes les plus classiques

### Quelques packages R utiles

* Le paquet [faraway](http://cran.r-project.org/web/packages/faraway/) avec les données du livre de Faraway.
* Le paquet [lars](http://cran.r-project.org/web/packages/lars/) permet de calculer efficacement la solution du Lasso pour toutes les valeurs du paramètre de pénalisation lambda.
* Le paquet [glmnet](http://cran.r-project.org/web/packages/glmnet/) permet de calculer la solution du Lasso et de l'elastic Net pour une grille de valeurs de lambda
* Le paquet [grplasso](http://cran.r-project.org/web/packages/grplasso/) permet de calculer la solution du group-Lasso pour une grille de valeurs de lambda.
* Le paquet [simone](/simone) permet d'inférence des réseaux biologiques avec diverse méthodes en particulier avec la sélection de voisinage Lasso.
* Le paquet [bootsptrap](http://cran.r-project.org/web/packages/bootstrap/index.html) implémente diverses méthodes de validation croisée (leave-one-out, jack-knife, bootstrap).

