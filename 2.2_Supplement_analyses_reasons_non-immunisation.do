*Supplementary analysis of reasons for MMR non-immunisation
tab bmmmrcaa
recode bmmmrcaa(-1=.)(1=3)(2=3)(3=0)(4=2)(5=2)(6=2)(7=2)(8=1)(9=2)(10=1)(11=2)(12=2)(13=2)(14=0)(15=0)(16=1)(17=2)(18=2)(19=2)(20=2)(21=2)(22=1)(23=2)(24=1)(25=2)(26=1)(27=2)(28=2)(29=1)(31=1)(32=2)(33=2)(34=2)(35=2)(36=2)(37=2)(38=2)(39=2)(40=2)(41=1)(42=2)(85=3)(86=3)(98=.)(99=3), gen(bmmmrcaacat4)
label define lab_bmmmrcaacat4 0"medical" 1"practical" 2"conscious" 3"others"
label values bmmmrcaacat4 lab_bmmmrcaacat4
tab bmmmrcaacat4
gen bmmmrcaanoanyvaccat4 = bmmmrcaacat4
replace bmmmrcaanoanyvaccat4 = . if bmmmrlaabi==0
label define lab_bmmmrcaanoanyvaccat4 0"medical" 1"practical" 2"conscious" 3"others"
label values bmmmrcaanoanyvaccat4 lab_bmmmrcaanoanyvaccat4
*Weighted percentages
svy: tab bmmmrcaanoanyvaccat4 anatpatmatdistsincat,row
*Unweighted counts
tab bmmmrcaanoanyvaccat4 anatpatmatdistsincat,row

*Each reason with any no vaccine
gen bmmmrcaanoanyvac = bmmmrcaa
replace bmmmrcaanoanyvac = . if bmmmrlaabi==0
label variable bmmmrcaanoanyvac "`: variable label bmmmrcaa'"
label values bmmmrcaanoanyvac `: value label bmmmrcaa'




