*** Internal Validation by Splitting Data

** use validation dataset
use "/Users/hteza/Desktop/Class/RACE626/Assignment 1/Upload assignment I/Assignment I epg for validation phase.dta"

* cleaning again

sum age
sum hgb2
sum lym2
sum glob2
sum cai2
sum agapt2
sum gfr2
misstable sum


* grouping data according to Aj
generate agegp=1 if age<60
replace agegp=2 if age>=60 & age!=.
tab agegp

encode sex, gen (gender)

generate hgbgp=1 if hgb2<100
replace hgbgp=2 if hgb2>=100 & hgb2!=.
tab hgbgp

* considering lymphocyte count=0 is impossible
replace lym2=. if lym2==0
sum lym2

generate lymgp=1 if lym2<1.9
replace lymgp=2 if lym2>=1.9 & lym2!=.
tab lymgp

* A normal range for total globulins is 23 to 35 g/L
* I will consider 70 g/L as the maximum limit for globulin

replace glob2=. if glob2>70
sum glob2

generate glogp=1 if glob2<38
replace glogp=2 if glob2>=38 & glob2!=.
tab glogp

generate cagp=1 if cai2<1.35
replace cagp=2 if cai2>=1.35 & cai2!=.
tab cagp

generate angp=1 if agapt2<10
replace angp=2 if agapt2>=10 & agapt2!=.
tab angp

* A normal range for eGFR is 80-120 (125ml/min/1.73m2)
* I will consider 250 ml/min/1.73m2 as the maximum limit for gfr2

replace gfr2=. if gfr2>250
sum gfr2

generate gfrgp=1 if gfr2<60
replace gfrgp=2 if gfr2>=60 & gfr2!=.
tab gfrgp

mdesc gender agegp hgbgp lymgp glogp cagp angp gfrgp
* misstable sum gender agegp hgbgp lymgp glogp cagp angp gfrgp

label define age 1 "younger than 60" 2 "older than 60"
label value agegp age

label define hgb 1 "less than 100 g/L" 2 "more than 100 g/L" 
label value hgbgp hgb

label define lymph 1 "less than 1.9 x10^9/L" 2 "more than 1.9 x10^9/L"
label value lymgp lymph

label define globulin 1 "less than 38 g/L" 2 "more than 38 g/L"
label value glogp globulin

label define ical 1 "less than 1.35 mmol/L" 2 "more than 1.35 mmol/L"
label value cagp ical

label define angap 1 "less than 10 mmol/L" 2 "more than 10 mmol/L"
label value angp angap

label define gfrgp 1 "less than 60 mL/min/1.73 m2" 2 "more than 60 mL/min/1.73 m2"
label value gfrgp gfrgp


** generate score
gen score_final=[-5.04]+ [1.15]*2.glogp+ [0.92]*2.agegp+ [0.75]*1.lymgp+ [0.67]*1.gfrgp+ [0.39]*2.gender+ [0.39]*2.hgbgp


qui : logit epg score_final

* calibration
* hosmer lemeshow
estat gof, group(10)

*discrimination
*roc curve
lroc


****** Compare C statistics between derivative and validated model

** make the validated data set as data 2
** save and clear
gen data=2
save "/Users/hteza/Desktop/Class/RACE626/Assignment 1/Upload assignment I/Assignment I epg for validation phase.dta"
clear

** re enter the derivative fiited data set
use "/Users/hteza/Desktop/Class/RACE626/Assignment 1/Upload assignment I/Assignment I epg for derive phase.dta"

** only keep the important ones we are going to use
** make it data 1
** save the dataset
keep id epg score_final
gen data=1
save "/Users/hteza/Desktop/Class/RACE626/Assignment 1/Upload assignment I/Assignment I epg for derive phase.dta"


** join data 2 ( internal validated dataset into the derivative data ) ( append )
append using "/Users/hteza/Desktop/Class/RACE626/Assignment 1/Upload assignment I/Assignment I epg for validation phase.dta"
tab data

** after joining two data set
** compare their ROC Area
roccomp epg score_final, by (data)
** by (data) specify how they are grouped
