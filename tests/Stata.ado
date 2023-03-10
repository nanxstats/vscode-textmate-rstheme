program define gr_log
version 6.0

local or = `2'
local xunits = `3'
local b1 = ln(`or')

* make summary of logistic data from equation
set obs `xunits'
generate pgty = 1 - 1/(1 + exp(score))
/**
 * Comment 1
*/
reg y x
* Comment 2
reg y2 x //comment 3
This is a `loc' $glob ${glob2}
This is a `"string " "' "string`1'two${hi}" bad `"string " "' good `"string " "'

// Limit to just the project ados
cap adopath - SITE
cap adopath - PLUS
/*cap adopath - PERSONAL
cap adopath - OLDPLACE*/
adopath ++ "${dir_base}/code/ado/"
A string `"Wow"'. `""one" "two""'
A `local' em`b'ed
a global ${dir_base} $dir_base em${b}ed

forval i=1/4{
  if `i'==2{
    cap reg y x1, robust
    local x = ln(4)
    local x =ln(4)
    local ln = ln
  }
}

* add mlibs in the new adopath to the index
mata: mata mlib index
