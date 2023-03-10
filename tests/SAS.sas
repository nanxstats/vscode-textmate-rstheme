/* From https://github.com/highlightjs/highlight.js/blob/ac40b1027d62f81f710042ee8b5c115634ca72dc/test/markup/sas/default.txt */

/**********************************************************************
 * Program: example.sas
 * Purpose: SAS Example for HighlightJS Plug-in
 **********************************************************************/

%put Started at %sysfunc(putn(%sysfunc(datetime()), datetime.));
options
    errors = 20  /* Maximum number of prints of repeat errors */
    fullstimer   /* Detailed timer after each step execution  */
;

%let maindir = /path/to/maindir;
%let outdir  = &maindir/out.;

systask command "mkdir -p &outdir." wait;
libname main "&maindir" access = readonly;

data testing;
    input name $ number delimiter = ",";
    datalines;
    John,1
    Mary,2
    Jane,3
    ;
    if number > 1 then final = 0;
    else do;
        final = 1;
    end;
run;

%macro testMacro(positional, named = value);
    %put positional = &positional.;
    %put named      = &named.;
%mend testMacro;
%testMacro(positional, named = value);

dm 'clear log output odsresults';

proc datasets lib = work kill noprint; quit;
libname _all_ clear;

data _null_;
    set sashelp.macro(
        keep  = name
        where = (scope = "global");
    );
    call symdel(name);
run;
