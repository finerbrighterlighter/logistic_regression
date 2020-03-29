** distribution and model fitting

*** chisquare / distribution
tab agegp epg, col exp chi2 exact
tab gender epg, col exp chi2 exact
tab hgbgp epg, col exp chi2 exact
tab lymgp epg, col exp chi2 exact
tab glogp epg, col exp chi2 exact
tab cagp epg, col exp chi2 exact
tab angp epg, col exp chi2 exact
tab gfrgp epg, col exp chi2 exact


*** odd ratio

logistic epg i.agegp
logistic epg i.gender
logistic epg ib(2).hgbgp
logistic epg ib(2).lymgp
logistic epg i.glogp
logistic epg i.cagp
logistic epg ib(2).angp
logistic epg ib(2).gfrgp 

*** univariate - constrainted for forward selection
logistic epg i.agegp if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
logistic epg i.gender if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
logistic epg ib(2).hgbgp if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
logistic epg ib(2).lymgp if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
logistic epg i.glogp if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
logistic epg i.cagp if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
logistic epg ib(2).angp if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
logistic epg ib(2).gfrgp if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.

** Step 1
qui: logistic epg i.glogp  if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
est store A
qui: logistic epg i.glogp i.agegp if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
est store B
lrtest A B
qui : logistic epg i.glogp i.gender if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
est store C
lrtest A C
qui : logistic epg i.glogp ib(2).hgbgp if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
est store D
lrtest A D
qui : logistic epg i.glogp ib(2).lymgp if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
est store E
lrtest A E
qui : logistic epg i.glogp ib(2).gfrgp if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
est store F
lrtest A F

** Step 2
qui: logistic epg i.glogp i.agegp i.gender if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
est store C2
lrtest B C2
qui: logistic epg i.glogp i.agegp ib(2).hgbgp if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
est store D2
lrtest B D2
qui: logistic epg i.glogp i.agegp ib(2).lymgp if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
est store E2
lrtest B E2
qui: logistic epg i.glogp i.agegp ib(2).gfrgp if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
est store F2
lrtest B F2

** Step 3
qui: logistic epg i.glogp i.agegp ib(2).lymgp i.gender if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
est store C3
lrtest E2 C3
qui: logistic epg i.glogp i.agegp ib(2).lymgp ib(2).hgbgp  if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
est store D3
lrtest E2 D3
qui: logistic epg i.glogp i.agegp ib(2).lymgp ib(2).gfrgp if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
est store F3
lrtest E2 F3

** Step 4
qui: logistic epg i.glogp i.agegp ib(2).lymgp ib(2).gfrgp i.gender if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
est store C4
lrtest F3 C4
qui: logistic epg i.glogp i.agegp ib(2).lymgp ib(2).gfrgp ib(2).hgbgp if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
est store D4
lrtest F3 D4

** Step 5
qui: logistic epg i.glogp i.agegp ib(2).lymgp ib(2).gfrgp i.gender ib(2).hgbgp if gender!=. & agegp!=. & hgbgp!=. & lymgp!=. & glogp!=. & cagp!=. & gfrgp!=. & angp!=.
est store D5
lrtest C4 D5

// xi: sw logit epg i.agegp i.gender ib(2).hgbgp ib(2).lymgp i.glogp i.cagp ib(2).angp ib(2).gfrgp , pe(0.05)
stepwise, pe(0.05): logit epg i.agegp i.gender ib(2).hgbgp ib(2).lymgp i.glogp i.cagp ib(2).angp ib(2).gfrgp

* Creating Scoring Scheme Using Regression Coefficient
logit epg i.glogp i.agegp ib(2).lymgp ib(2).gfrgp i.gender i.hgbgp
logit epg i.glogp i.agegp ib(2).lymgp ib(2).gfrgp i.gender i.hgbgp,or 

// 

predict score_final, xb


*** model performance assessment
qui : logit epg score_final

** hosmer lemeshow
estat gof, gr(10)

** area under roc curve
lroc

** model classification

* default cut off 0.5
estat class

* calibrating cut off
predict probsa, pr
roctab epg probsa, detail

estat class, cutoff(0.06)

save "/Users/hteza/Desktop/Class/RACE626/Assignment 1/Upload assignment I/Assignment I epg for derive phase.dta"




