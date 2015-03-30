
/***************************************************************************************************
pick
***************************************************************************************************/

program define _gpick


	syntax newvarname =/exp [if] [in][, BY(varlist) when(string)]
	qui{
		tempvar touse temp
		local gen `varlist'
		local type `typelist'
		mark `touse' `if' `in'
		confirm new variable `gen'
		bys `touse' `by': gen `type' `temp' = `exp' if  (`when') & `touse'
		cap confirm numeric variable `temp'
		if _rc == 0{
			bys `touse' `by' (`temp'): assert `temp' == . if _n == 2
			by  `touse' `by': replace `temp' = `temp'[1] 
			rename `temp' `gen'
		}
		else{
			bys `touse' `by' (`temp'): assert `temp' == . if _n == _N - 1
			by  `touse' `by': replace `temp' = `temp'[_N] 
			rename `temp' `gen'
		}
	}
end
