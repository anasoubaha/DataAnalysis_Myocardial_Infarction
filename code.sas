/*Creating data table */
data cas1;
    infile "/infactus.txt";
    input frcar incar insys prdia papul pvent repul prono $ prono1;
run;

proc print data=cas1;
run;

/*Stats depending on prono variable (life/death)*/
proc means data=cas1 chartype mean std min max n vardef=df maxdec=1;
    class prono;
run;

/*Studying correlation between variables*/
proc corr data=cas1 pearson nosimple noprob plots=none;
    var frcar incar insys prdia papul pvent repul prono1;
run;

/*Applying PCA*/
proc princomp DATA=cas1;
run;

/*Ploting Componenent Pattern*/
ods graphics on;
ods select patternPlot;
proc princomp data=cas1 plots=pattern(vector);
    var frcar incar insys prdia papul pvent repul prono1;
run;

/*Ploting cloud of point*/

ods graphics on;
proc sgplot data=work.cas1;
    scatter x=Prin1 y=Prin2 / group=prono;
    Xaxis grid;
    Yaxis grid;
run;
