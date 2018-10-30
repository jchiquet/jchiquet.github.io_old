data Hepta;
infile '/folders/myfolders/heptathlon/HEPTA.don' firstobs=2;
format nom $16. ;
input Nom M100H Hauteur Poids M200 Longueur Javelot M800;
run;

proc Print data=Hepta;
run;


* CAH;
* ================================;
data Hepta2;
set Hepta;
NomCourt = substr(Nom,1,8);
run;


proc Cluster data=Hepta2 outtree=WARD method=Ward std;
id NomCourt;
var M100H Hauteur Poids M200 Longueur Javelot M800;
run;

proc Tree data=WARD NCLUSTERS=4 out=CLASSEMENT height=RSQ;
run;

proc sort data = CLASSEMENT; by cluster; run;

proc print data=CLASSEMENT;
run;

/*Repr�sentation graphique des classifications obtenues pour 4 et 3 classes sur le premier plan factoriel*/

proc Tree data=WARD NCLUSTERS=4 out=CLASSEMENT_CAH4 height=RSQ;
run;

proc Tree data=WARD NCLUSTERS=3 out=CLASSEMENT_CAH3 height=RSQ;
run;

proc sort data = CLASSEMENT_CAH4;
by _NAME_;
run;

proc sort data = CLASSEMENT_CAH3;
by _NAME_;
run;

proc sort data = anno;
by nom; 
run;

data anno2;
set anno;
NomCourt = substr(Nom,1,8);
run;

data anno_cah4 (keep = nom x y cluster);
merge anno2 classement_cah4 (rename = (_name_ =  NomCourt));
by NomCourt;
run;

data anno_cah3(keep = nom x y cluster);
merge anno2 classement_cah3 (rename = (_name_ =  NomCourt));
by NomCourt;
run;

* CAH - 4 groupes;
proc gplot data=anno_cah4; 
symbol1 c=green v=circle i=none height=7;
symbol2 c=red v=circle i=none  height=7;
symbol3 c=blue v=circle i=none  height=7;
symbol4 c=orange v=circle i=none  height=7;
plot y*x=cluster/annotate=anno2; 
run; quit;

* CAH - 3 groupes;
proc sgplot data=anno_cah3; 
scatter	 x=x y=y/group=cluster; 
run; quit;

* K-MEANS;
* ================================;

* 3 groupes;
* ================================;

proc fastclus data=Hepta2 maxc=3 out=sorclust3 summary mean=groupes maxit=100 replace=random std;
       id NomCourt;
var M100H Hauteur Poids M200 Longueur Javelot M800;
run;
proc print data=groupes;
run;

proc sort data=sorclust3; by cluster;
run;

proc print data=sorclust3;
run;

proc sort data = sorclust3;
by nom;
run;

proc sort data = anno;
by nom;
run;

data anno_sorclust3 (keep = nom x y cluster);
merge anno sorclust3;
by nom;
run;

/*Repr�sentation graphique sur le premier plan factoriel*/

proc sgplot data=anno_sorclust3; 
symbol1 c=green v=circle i=none height=7;
symbol2 c=red v=circle i=none  height=7;
symbol3 c=blue v=circle i=none  height=7;
plot y*x=cluster/annotate=anno; 
run; quit;


* 4 groupes;
* ================================;

proc fastclus data=Hepta2 maxc=4 out=sorclust4 summary mean=groupes maxit=100 replace=random std;
       id NomCourt;
var M100H Hauteur Poids M200 Longueur Javelot M800;
run;
proc print data=groupes;
run;

proc sort data=sorclust4; by cluster;
run;

proc print data=sorclust4;
run;


* 5 groupes;
* ================================;

proc fastclus data=Hepta2 maxc=5 out=sorclust5 summary mean=groupes maxit=100 replace=random std;
       id NomCourt;
var M100H Hauteur Poids M200 Longueur Javelot M800;
run;
proc print data=groupes;
run;

proc sort data=sorclust5; by cluster;
run;

proc print data=sorclust5;
run;

* ACP;
* ================================;

proc princomp outstat=diag out=coord; 
var M100H Hauteur Poids M200 Longueur Javelot M800;
run;
 

* calcul des coordonnees des variables;
* ====================================;
data lambda (keep=lambda); set diag (where=(_TYPE_='EIGENVAL'));
array l{*} _numeric_;
do k=1 to dim(l);
lambda=l{k};
output;
end;
run;

data coordvar (drop=i lambda);
set diag (where=(_TYPE_='SCORE'));
set lambda;
array coord{*} M100H Hauteur Poids M200 Longueur Javelot M800;
do i = 1 to dim(coord);
coord{i}=coord{i}*sqrt(lambda);
end;
run;

proc transpose out=coordvar prefix=v;
var _numeric_;
run;

* calcul des correlations variables x facteurs;
data corr (keep=sig); 
set diag (where=(_TYPE_='CORR' or _TYPE_='COV'));
array covcor{*} _numeric_;
sig=sqrt(covcor{_n_});
run;

data covarfac (drop=i sig);
set  coordvar;
set corr;
array coord{*} _numeric_;
do i = 1 to dim(coord);
coord{i}=coord{i}/sig;
end;
run;

* Calculs concernant les individus;
* ================================;
* Calculs  des cos carres;
data coorind; set coord; 
array c{*}  prin1-prin6;
array cosca{2};  
disto=uss(of c{*});
do j=1 to 2;
cosca{j}=c{j}*c{j}/disto;
end;
cosca12=cosca{1}+cosca{2};
keep Nom prin1-prin2  cosca1-cosca2 cosca12;
run;

title2 'Coordonn�es des individus et cosinus carr�s sur le plan principal';
proc print noobs round;
var Nom prin1-prin2  cosca1-cosca2 cosca12;
run;

*    Graphique des variables avec cercle des correlations;
*    x : numero axe horizontal et y : numero axe vertical;
data anno;
retain  xsys ysys '2';
set covarfac nobs=p;
y= v2; x= v1; style='swiss';
text=substr(_name_,1,10);
size=0.8*(1-max(0,p/10)+1.3*sqrt(x*x+y*y));
label y = "Axe 2" x = "Axe 1";
output;
function='pie';
x=0;text='';
y=0;style='E';
hsys='8';size=1.02;
rotate=360;output;
run;
 

proc gplot data=anno; symbol1 v='none' i=join;
axis1 order = (-1 to 1 by 0.5) length=12CM; 
plot y*x=1 / annotate=anno haxis=axis1 vaxis=axis1;
run;
quit;


*    Graphique des individus;
*    x : numero axe horizontal et y : numero axe vertical;

data anno;
set coorind nobs=nind;
retain  xsys ysys '2';
style='swiss'; y= prin2; x= prin1;
text=substr(left(Nom),1,4); 
size=0.8*(1.6-max(0,nind/100)+(cosca1+cosca2)/1.8);*0.8:controle de taille;
label y = "Axe 2" x = "Axe 1";
run;


proc gplot data=anno; symbol1 v='none' i=none;
plot y*x=1 / annotate=anno frame  href=0 vref=0;
run; quit;

 
 

 

