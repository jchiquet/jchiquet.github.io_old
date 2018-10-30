/* ============================================================ */
/* 																*/
/* IMPORTATION ET MISE EN FORME	DES DONNÉES 					*/
/* 																*/

/* LECTURE DES DONNÉES */

/* Chargement des données */
DATA COLZA;
	INFILE "/folders/myfolders/colza/Colza.txt" firstobs=2;
	INPUT	Fertilisation$ Rotation$ PdsGrains;
RUN;
PROC PRINT DATA=COLZA ;

/* Calcul des moyennes et écarts-types */
PROC MEANS DATA=COLZA noprint;
	BY Fertilisation Rotation;
	output out=INTER mean=PdsGrains std=EcartType ;
PROC PRINT DATA=INTER;
RUN;

/* Boxplot */
PROC SGPLOT DATA=COLZA ;
VBOX PdsGrains/Category=Fertilisation;
RUN;
PROC SGPLOT DATA=COLZA ;
VBOX PdsGrains/Category=Rotation ;
RUN;

/* ANOVA 1 Factor*/
PROC ANOVA DATA=COLZA;
	class Fertilisation;
	Model PdsGrains = Fertilisation;
RUN;	

/* ANOVA 2 Factor*/
PROC GLM DATA=COLZA;
class Fertilisation Rotation;
Model PdsGrains = Fertilisation Rotation Fertilisation*Rotation / e2;
means Fertilisation Rotation; 
means Fertilisation Rotation / bon ; 
lsmeans Fertilisation Rotation / adjust=bon ; 
RUN;

