/* ============================================================ */
/* 																*/
/* IMPORTATION ET MISE EN FORME	DES DONNÉES 					*/
/* 																*/

/* LECTURE DES DONNÉES */
DATA RATS ;
infile "/folders/myfolders/rats/rats.txt" expandtabs firstobs=2;
input obs regime$ animal t0-t9;
drop obs;
run;

PROC PRINT DATA=RATS;
RUN;

/* MISE EN FORME UNIVARIÉE (POUR PROC GLM ET MIXED) */
PROC TRANSPOSE DATA=RATS OUT=RATS_Y NAME=temps;
BY regime animal;
VAR t0-t9;
run;

DATA RATS_Y; SET RATS_Y;
rename Col1 = Poids;
Semaine = input(substr(temps, 2, 1), 1.);
if regime = 'faible' then Date = Semaine - 0.05;
if regime = 'moyen' then Date = Semaine + 0.05;
if regime = 'fort' then Date = Semaine + 0.15;
run;

PROC PRINT DATA=RATS_Y;

PROC SORT DATA=RATS_Y;
BY REGIME ANIMAL SEMAINE;
run;

PROC SGPLOT DATA=RATS_Y;
SERIES X = Date Y = Poids / Group=Regime ;
run;

/* ============================================================ */
/* 																*/
/* SIMPLE ANOVA 2 (SANS STRUCTURE DE BRUIT) 					*/
/* 																*/

PROC GLM DATA=RATS_Y;
CLASS Regime Animal Semaine;
MODEL Poids = Regime Semaine Regime*Semaine;
OUTPUT out=ANOVA2 r=residu p=predict ;
run;
proc print DATA=ANOVA2; run;

/* Graphes des résidus */
PROC SGPANEL DATA=ANOVA2;
Panelby animal;
SCATTER X = predict Y = residu / group=regime;
run;

/* recherche d'une structure au sein des résidus */

/* Matrice de corrélation */
PROC CORR DATA=resANOVA2 nosimple noprob ;
Var res1-res10;
run;


PROC TRANSPOSE DATA=ANOVA2 OUT=resANOVA2 prefix=res;
var residu;
by regime animal;
run;
proc print DATA=resANOVA2; run;

/* res1 vs res 2 */
PROC SGPLOT DATA=resANOVA2;
SCATTER X = res1 Y = res2 ;
SCATTER X = res2 Y = res3 ;
SCATTER X = res3 Y = res4 ;
SCATTER X = res4 Y = res5 ;
SCATTER X = res5 Y = res6;
SCATTER X = res6 Y = res7 ;
SCATTER X = res7 Y = res8 ;
SCATTER X = res8 Y = res9 ;
SCATTER X = res9 Y = res10 ;
run;


/* ============================================================ */
/* 																*/
/* MODÈLE À MESURES RÉPÉTÉES				 					*/
/* 																*/

/* Compound symmetry */
PROC MIXED DATA=RATS_Y;
class Regime Animal Semaine;
Model Poids = Regime Semaine Regime*Semaine;
repeated	 / subject=Animal(Regime) type = CS;
run;

/* Compound symmetry heterogeneous*/
PROC MIXED DATA=RATS_Y;
class Regime Animal Semaine;
Model Poids = Regime Semaine Regime*Semaine;
repeated	 / subject=Animal(Regime) type = CSH ;
run;

/* AR(1)*/
PROC MIXED DATA=RATS_Y;
class Regime Animal Semaine;
Model Poids = Regime Semaine Regime*Semaine;
repeated	 / subject=Animal(Regime) type = AR(1) ;
run;

/* ARH(1)- does have the smallest AIC */
PROC MIXED DATA=RATS_Y;
class Regime Animal Semaine;
Model Poids = Regime Semaine Regime*Semaine;
repeated	 / subject=Animal(Regime) type = ARH(1) ;
lsmeans Regime / adjust=bon; 
run;


