* Importing the dataset in SAS;

proc import out=work.sales
datafile='/folders/myfolders/Worldwide_Sales.xls'
dbms=xls replace;
getnames=yes;
run;

* Extracting country names from the dataset;

proc sort data=work.sales out=work.unique (keep=Country)
nodupkey;
by country;
run;

* Creating multiple datasets from the parent dataset;

data _null_;
set work.unique;
call execute('data ' !! compress(Country) !! '; set work.sales; where Country = "' !! Country !! '"; run;');
run;
