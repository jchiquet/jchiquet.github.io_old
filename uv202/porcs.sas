options linesize=89 pagesize=34 pageno=1 nodate;

data PORCS;
infile '/folders/myfolders/porcs/porcs.txt' expandtabs firstobs=2;
input Id$ Pere$ Mere$ Sexe$ Bande$ PdsFinal RTN Lard;
Pere = substr(Pere,5,3);
run;

proc sort data=PORCS;
by Pere Mere; 
run;

title2 'Effet du pere sur l''indice RTN chez le porc';
proc print data = porcs (obs=10);
run;

proc Sort data=PORCS;
by Pere;
run;

title2 'Effectif par pere';
proc sgplot data=PORCS;
hbar Pere;
run;

/* Equilibrage des effectifs */
data PorcsEqui;
set PORCS;
if Pere='9170041' or Pere='9170044' or Pere='9170066' then delete;
Rep+1;
if (_n_>1) and (Pere ne lag(Pere)) then Rep=1;
if Rep < 16;
run;

title2 'Effectif par pere';
proc sgplot data=PORCSEqui;
hbar Pere;
run;

/* Etude de la variabilité Intra-pères */
proc Means data=PorcsEqui noprint;
var RTN;
by Pere;
output out=MEAN std=ECARTYPE mean=moy;
run;
data Mean;
set Mean;
keep Pere ecartype;
run;

title2 'Etude de la variabilité Intra-peres';
proc print data = Mean;
run;

data PorcsEqui;
merge PorcsEqui MEAN;
by Pere;
if ECARTYPE > 4;
run;

proc sgplot data=PORCSEqui;
hbar Pere;
run;

title2 'Egalité des variances';
proc glm data=PorcsEqui;
class Pere;
model RTN = Pere;
means Pere / hovtest;
run;

/* Modele avec effet pere aleatoire, donnees equilibrees */
title2 'Modele avec effet pere aleatoire, donnees equilibrees, proc Mixed, methode Anova';
proc Mixed data=PorcsEqui method=type3 covtest;
     class Pere;
     model RTN = ;
     random Pere / solution;
run;

title2 'Modele avec effet pere aleatoire, donnees equilibrees, proc Mixed, methode ANOVA et ecriture mesures repetees';
proc Mixed data=PorcsEqui method=reml covtest;
     class Pere;
     model RTN = ;
     repeated /  subject=Pere type=cs;
run;

/* Modele avec effet pere aleatoire, donnees desequilibrees */
title2 'Modele avec effet pere aleatoire, donnees desequilibrees, proc Mixed, methode Anova';
proc Mixed data=PORCS  method=type3 covtest;
     class Pere;
     model RTN =;
     random Pere / solution;
run;

title2 'Modele avec effet pere aleatoire, donnees desequilibrees, proc Mixed, methode REML';
proc Mixed data=PORCS method=reml covtest;
     class Pere;
     model RTN =;
     random Pere / solution;
run;

/* Modele avec effets pere et mere aleatoires, donnees desequilibrees */
title2 'Modele avec effets pere et mere aleatoires, donnees desequilibrees';
proc Mixed data=PORCS  method=type3 covtest;
     class Pere Mere;
     model RTN =;
     random Pere Mere(Pere);
run;

title2 'Existence d une mere volage';
proc freq data = porcs (where = (mere = "9070877"));
tables mere*pere / nopct nocol norow;
run;

/* On retire la mere volage*/
proc sort data = porcs; by pere mere; run;
data PORCS_CORR;
set PORCS;
if mere ne "9070877";
retain NumPere;
if Pere ne lag(Pere) then NumPere +1;
retain NumMere;
if Mere ne lag(Mere) then NumMere +1;
if  Pere ne lag(Pere) then NumMere =1; 
NumEnfant +1;
if Mere ne lag(Mere) then NumEnfant=1;
run;

title2 'Etude des effectifs, par p�re et par m�re';
proc freq data = PORCS_CORR;
tables NumPere*NumMere / nopct nocol norow;
run;

/* Cr�ation d'un jeu de donn�es �quilibr�es */
data PORCS_CORR_EQUI;
set PORCS_CORR;
if NumPere ne 1;
if NumPere ne 10;
if NumMere < 3;
if NumEnfant < 5;
run;

title2 'Donnees corrigees et equilibrees';
proc freq data = PORCS_CORR_EQUI;
tables NumPere*NumMere / nopct nocol norow;
run;

title2 'Dispersion intra-mere au sein des peres';
proc Means data=PORCS_CORR noprint;
var RTN;
by Pere Mere;
output out=MERE mean=MoyRTN;
run;
data PORCS_BOXPLOT;
merge PORCS_CORR MERE;
by Pere Mere;
DispRTN = RTN - MoyRTN;	 
run;
proc BoxPlot data=PORCS_BOXPLOT;
     plot DispRTN * Pere;
run;

title2 'Modele avec effets pere et mere aleatoires, donnees equilibrees, peres 1 et 10 et mere 9070877 exclus';
proc Mixed data=PORCS_CORR_EQUI method = type3 covtest;
     class Pere Mere;
     model RTN = ;
     random Pere Mere(Pere);
run;

title2 'Modele avec effets pere et mere aleatoires, donnees desequilibrees, mere 9070877 exclus';
proc Mixed data=PORCS_CORR method = type3 covtest;
     class Pere Mere;
     model RTN = ;
     random Pere Mere(Pere);
run;

title2 'Modele avec effets pere et mere aleatoires, donnees desequilibrees, mere 9070877 exclus';
proc Mixed data=PORCS_CORR method = reml covtest;
     class Pere Mere;
     model RTN = ;
     random Pere Mere(Pere);
run;

title2 'Modele avec effet pere aleatoire, donnees desequilibrees, mere 9070877 exclus';
proc Mixed data=PORCS_CORR method = reml covtest;
     class Pere ;
     model RTN = ;
     random Pere ;
run;
