***************** INTERNAL VALIDATION BY BOOTSTRAPING

// ** FIT FINAL MODEL

qui : logit epg i.glogp i.agegp ib(2).lymgp ib(2).gfrgp i.gender i.hgbgp

****** Step 1 : Estimate original Somers'D and C statistics

** ROC model to get original C statistics
lroc

** get Sommers' D coefficients
predict probsa0, pr 
* specify probsa0 since we will have mean probsa of bootstraps later 

somersd epg probsa

*** make sure you write down the original numbers for c statistics or else you gonna regret only after 100 bootstraps

*********************
********************
********************

****** Step 2 : Estimate Soimer'D and C statistics

** bootstraps
cd "/Users/hteza/Desktop/Class/RACE626/bootstrapping"

* random seed
set seed 123456

* 100 bootstraps 
local nsim=100

* postfile create new variable/list into new file ( as specified )
* option replace will replace if old file with same name exists in the directory
postfile estsom dboot cboot using "result_boot.dta", replace
forvalues i=1/`nsim'{
bsample
*bsample means you are sampling "with" replacement or "bootstrapping"
tempvar probsa dboot cscore cboot
* declare temp variable
logit epg i.glogp i.agegp ib(2).lymgp ib(2).gfrgp i.gender i.hgbgp
predict `probsa', pr
predict `cscore', xb
* fill the tempvars
somersd epg `probsa'
gen `dboot'=_b[`probsa']
* somer'd is kept on dboot
roctab epg `cscore'
gen `cboot'=r(area)
* return list
* because stata keps the c statitics in r(area)
post estsom (`dboot') (`cboot')
* post adds results to the target file every loop, accumulation
}
postclose estsom
* postclose halts the loop

* from here we will only work with result datasetclear
use "/Users/hteza/Desktop/Class/RACE626/bootstrapping/result_boot.dta"
list

****** Step 3 : calculate the difference of coefficients between original and bootstrap model

* get the old original somer'd(line 96) and c stat(line 91)
gen corigin=????
gen dorigion=???

* c optimism and d optimism
gen cop= corigin - cboot
gen dop = dorigion - dboot
list 

****** Step 4 : calculatte a mean optimism from the whole bootstrap

* get mean of them with confident intervals
ci means cop dop

****** Step 5 : calculate bootstrpa corrected calibration and discrimination coefficients
gen ccor = corigin-cop
gen dcor = dorigion-dop

* get mean of them with confident intervals
ci means ccor dcor
