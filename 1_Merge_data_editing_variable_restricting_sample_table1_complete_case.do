*Initial settings to merge data of the MCS sweep 1 & 2*
version 15.0
clear all
set more off

global data "path_to_your_data"
use "$data/mcs_longitudinal_family_file.dta", clear
replace BOVWT2 = . if BOVWT2<0
merge 1:1 MCSID using "$data\mcs1_derived_variables.dta"
assert _merge != 2
drop _merge
merge 1:1 MCSID using "$data\mcs2_derived_variables.dta"
assert _merge != 2
drop _merge
gen mcsid=MCSID
merge 1:1 mcsid using "$data\mcs1_parent_interview.dta"
assert _merge != 2
drop _merge
merge 1:1 mcsid using "$data\mcs2_parent_interview.dta"
assert _merge != 2
drop _merge
svyset SPTN00 [pweight=BOVWT2], strata(PTTYPE2) fpc(NH2)
noi svydes

*Combining 9 items of the modified Rutter Malaise Inventory as a discrete variable of main respondents' PD*
gen amtire0or1 = 1 if amtire00==1
replace amtire0or1 = 0 if amtire00==2
gen amdepr0or1 = 1 if amdepr00==1
replace amdepr0or1 = 0 if amdepr00==2
gen amworr0or1 = 1 if amworr00==1
replace amworr0or1 = 0 if amworr00==2
gen amrage0or1 = 1 if amrage00==1
replace amrage0or1 = 0 if amrage00==2
gen amscar0or1 = 1 if amscar00==1
replace amscar0or1 = 0 if amscar00==2
gen amupse0or1 = 1 if amupse00==1
replace amupse0or1 = 0 if amupse00==2
gen amkeyd0or1 = 1 if amkeyd00==1
replace amkeyd0or1 = 0 if amkeyd00==2
gen amnerv0or1 = 1 if amnerv00==1
replace amnerv0or1 = 0 if amnerv00==2
gen amhera0or1 = 1 if amhera00==1
replace amhera0or1 = 0 if amhera00==2
gen amdist = amtire0or1 + amdepr0or1 + amworr0or1 + amrage0or1 + amscar0or1 + amupse0or1 + amkeyd0or1 + amnerv0or1 + amhera0or1

*Combining 9 items of the modified Rutter Malaise Inventory as a discrete variable of partner respondents' PD*
gen aptire0or1 = 1 if aptire00==1
replace aptire0or1 = 0 if aptire00==2
gen apdepr0or1 = 1 if apdepr00==1
replace apdepr0or1 = 0 if apdepr00==2
gen apworr0or1 = 1 if apworr00==1
replace apworr0or1 = 0 if apworr00==2
gen aprage0or1 = 1 if aprage00==1
replace aprage0or1 = 0 if aprage00==2
gen apscar0or1 = 1 if apscar00==1
replace apscar0or1 = 0 if apscar00==2
gen apupse0or1 = 1 if apupse00==1
replace apupse0or1 = 0 if apupse00==2
gen apkeyd0or1 = 1 if apkeyd00==1
replace apkeyd0or1 = 0 if apkeyd00==2
gen apnerv0or1 = 1 if apnerv00==1
replace apnerv0or1 = 0 if apnerv00==2
gen aphera0or1 = 1 if aphera00==1
replace aphera0or1 = 0 if aphera00==2
gen apdist = aptire0or1 + apdepr0or1 + apworr0or1 + aprage0or1 + apscar0or1 + apupse0or1 + apkeyd0or1 + apnerv0or1 + aphera0or1

*Making maternal PD variable from main and partenr's PD by their each sex*
gen amatdist = amdist if ampsex00==2 & appsex00==1
replace amatdist = apdist if ampsex00==1 & appsex00==2

*Making paternal PD variable from main and partenr's PD by their each sex*
gen apatdist = amdist if ampsex00==1 & appsex00==2
replace apatdist = apdist if ampsex00==2 & appsex00==1

*Making categorical variable of maternal or paternal PD by a cut point of >=4*
gen amatdistcat = 1 if .>amatdist & amatdist>=4
replace amatdistcat = 0 if amatdist<4
gen apatdistcat = 1 if .>apatdist & apatdist>=4
replace apatdistcat = 0 if apatdist<4

*Making categorical variable of maternal and paternal PD*
gen apatmatdistcat = 0 if apatdistcat==0 & amatdistcat==0
replace apatmatdistcat = 1 if apatdistcat==0 & amatdistcat==1
replace apatmatdistcat = 2 if apatdistcat==1 & amatdistcat==0
replace apatmatdistcat = 3 if apatdistcat==1 & amatdistcat==1
label define lab_apatmatdistcat 0"no-distress" 1"mother distressed" 2"father distressed" 3"both distressed"
label values apatmatdistcat lab_apatmatdistcat

*PD variable is limited to natural and couple parents and this is the exposure in this study*
gen anatpatmatdistcat=apatmatdistcat
replace anatpatmatdistcat=. if ADHTYP00>=2
label define lab_anatpatmatdistcat 0"no-distress" 1"mother distressed" 2"father distressed" 3"both distressed"
label values anatpatmatdistcat lab_anatpatmatdistcat
gen anatpatmatdistsincat=anatpatmatdistcat if ahnoba00==1
label define lab_anatpatmatdistsincat 0"no-distress" 1"mother distressed" 2"father distressed" 3"both distressed"
label values anatpatmatdistsincat lab_anatpatmatdistsincat

*Making each parental PD limited to natural and couple parents 
gen anatpatdistcat=apatdistcat
replace anatpatdistcat=. if ADHTYP00>=2
gen anatpatdistsincat=anatpatdistcat if ahnoba00==1
label define lab_anatpatdistsincat 0"no-distress" 1"distressed"
label values anatpatdistsincat lab_anatpatdistsincat
gen anatmatdistcat=amatdistcat
replace anatmatdistcat=. if ADHTYP00>=2
gen anatmatdistsincat=anatmatdistcat if ahnoba00==1
label define lab_anatmatdistsincat 0"no-distress" 1"distressed"
label values anatmatdistsincat lab_anatmatdistsincat


*Making categorical variable of immunisation status as outcome
gen bmmmrlaabi=1 if bmmmrlaa==1
replace bmmmrlaabi=0 if bmmmrlaa==0
label define lab_bmmmrlaabi 0"Vaccinated" 1"No vaccinations"
label values bmmmrlaabi lab_bmmmrlaabi

*Making ordinal variable of maternal and paternal academic qualification*
recode amacqu00 (-9=.) (-8=.) (-1=.) (1/3=1) (4/5=2) (6/96=3), gen(amacqucat3)
label define lab_amacqucat3 1"Degree / Diplomas in higher education" 2"A levels / GCSE A-C" 3"GCSE D-G / Other / None"
label values amacqucat3 lab_amacqucat3
recode apacqu00 (-9=.) (-8=.) (-1=.) (1/3=1) (4/5=2) (6/96=3), gen(apacqucat3)
label define lab_apacqucat3 1"Degree / Diplomas in higher education" 2"A levels / GCSE A-C" 3"GCSE D-G / Other / None"
label values apacqucat3 lab_apacqucat3
gen amatacqucat3 = amacqucat3 if ampsex00==2 & appsex00==1
replace amatacqucat3 = apacqucat3 if ampsex00==1 & appsex00==2
label define lab_amatacqucat3 1"Degree / Diplomas in higher education" 2"A levels / GCSE A-C" 3"GCSE D-G / Other / None"
label values amatacqucat3 lab_amatacqucat3
gen apatacqucat3 = amacqucat3 if ampsex00==1 & appsex00==2
replace apatacqucat3 = apacqucat3 if ampsex00==2 & appsex00==1
label define lab_apatacqucat3 1"Degree / Diplomas in higher education" 2"A levels / GCSE A-C" 3"GCSE D-G / Other / None"
label values apatacqucat3 lab_apatacqucat3

*Recode household social class*
gen AMD07S00cat = AMD07S00
replace AMD07S00cat = 8 if amwkst00==3
replace AMD07S00cat = 9 if amwkst00==4
replace AMD07S00cat = . if AMD07S00cat==-1
label define lab_AMD07S00cat 1"Hi manag/prof" 2"Lo manag/prof" 3"Intermediate" 4"Small emp and s-emp" 5"Low sup and tech" 6"Semi routine" 7"Routine" 8"Has worked in the past but no current paid work" 9"Never had a paid job"
label values AMD07S00cat lab_AMD07S00cat
gen APD07S00cat = APD07S00
replace APD07S00cat = 8 if apwkst00==3
replace APD07S00cat = 9 if apwkst00==4
replace APD07S00cat = . if APD07S00cat==-1
label define lab_APD07S00cat 1"Hi manag/prof" 2"Lo manag/prof" 3"Intermediate" 4"Small emp and s-emp" 5"Low sup and tech" 6"Semi routine" 7"Routine" 8"Has worked in the past but no current paid work" 9"Never had a paid job"
label values APD07S00cat lab_APD07S00cat
recode AMD07S00cat (1/2=1) (3=2) (4=3) (5=4) (6/7=5) (8=6) (9=7), gen(AMD07S00cat7)
label define lab_AMD07S00cat7 1"Managerial and professional" 2"Intermediate" 3"Small employer/self-employed" 4"Lower supervisory and technical" 5"Semi-routine and routine" 6"Has worked in the past but no current p" 7"Never had a paid job"
label values AMD07S00cat7 lab_AMD07S00cat7
recode APD07S00cat (1/2=1) (3=2) (4=3) (5=4) (6/7=5) (8=6) (9=7), gen(APD07S00cat7)
label define lab_APD07S00cat7 1"Managerial and professional" 2"Intermediate" 3"Small employer/self-employed" 4"Lower supervisory and technical" 5"Semi-routine and routine" 6"Has worked in the past but no current p" 7"Never had a paid job"
label values APD07S00cat7 lab_APD07S00cat7
gen AXD07S00cat7=AMD07S00cat7 if AMD07S00cat7<=APD07S00cat7
replace AXD07S00cat7=APD07S00cat7 if  AMD07S00cat7>=APD07S00cat7
label define lab_AXD07S00cat7 1"Managerial and professional" 2"Intermediate" 3"Small employer/self-employed" 4"Lower supervisory and technical" 5"Semi-routine and routine" 6"Has worked in the past but no current p" 7"Never had a paid job"
label values AXD07S00cat7 lab_AXD07S00cat7

recode AXD07S00cat7 (1=1) (2/4=2) (5/7=3), gen(AXD07S00cat3)
label define lab_AXD07S00cat3 1"Managerial and professional" 2"Intermediate/Small employer/Self-employed/Lower supervisory and technical" 3"Semi-routine and routine/Has worked in the past but no current position/Never had a paid job"
label values AXD07S00cat3 lab_AXD07S00cat3


*Making ordinal variable of social support of main respondent*
recode ampeta00 (-9/-1=.) (1/2=1) (3=2) (4/5=3) (6=.), gen(ampeta00cat3)
label define lab_ampeta00cat3 1"High support" 2"Medium" 3"Low support"
label values ampeta00cat3 lab_ampeta00cat3

recode ampeta00 (-9/-1=.) (1/2=1) (3/5=2) (6=.), gen(ampeta00cat2)
label define lab_ampeta00cat2 1"High" 2"Low"
label values ampeta00cat2 lab_ampeta00cat2


*Making ordinal variable of maternal and paternal age*
recode AMDAGB00 (-2=.) (14/24=1) (25/34=2) (35/63=3), gen(AMDAGB00cat3)
label define lab_AMDAGB00cat3 1"14-24" 2"25-34" 3"≥35"
label values AMDAGB00cat3 lab_AMDAGB00cat3
recode APDAGB00 (-2=.) (-1=.) (14/24=1) (25/34=2) (35/69=3), gen(APDAGB00cat3)
label define lab_APDAGB00cat3 1"14-24" 2"25-34" 3"≥35"
label values APDAGB00cat3 lab_APDAGB00cat3
gen AMATDAGB00cat3 = AMDAGB00cat3 if ampsex00==2 & appsex00==1
replace AMATDAGB00cat3 = APDAGB00cat3 if ampsex00==1 & appsex00==2
label define lab_AMATDAGB00cat3 1"14-24" 2"25-34" 3"≥35"
label values AMATDAGB00cat3 lab_AMATDAGB00cat3
gen APATDAGB00cat3 = AMDAGB00cat3 if ampsex00==1 & appsex00==2
replace APATDAGB00cat3 = APDAGB00cat3 if ampsex00==2 & appsex00==1
label define lab_APATDAGB00cat3 1"14-24" 2"25-34" 3"≥35"
label values APATDAGB00cat3 lab_APATDAGB00cat3


*Making ordinal variable of the number of children in household
recode ADTOTS00 (1=1) (2/3=2) (4/10=3), gen(ADTOTS00cat3)
label define lab_ADTOTS00cat3 1"1" 2"2/3" 3"≥4"
label values ADTOTS00cat3 lab_ADTOTS00cat3

*Making categorical variable of maternal and paternal working status*
recode amwkst00 (-1=.) (1/2=1) (3/4=2), gen(amwkst00cat2)
label define lab_amwkst00cat2 1"Currently employed" 2"No job"
label values amwkst00cat2 lab_amwkst00cat2
recode apwkst00 (-1=.) (1=1) (3/4=2), gen(apwkst00cat2)
label define lab_apwkst00cat2 1"Currently employed" 2"No job"
label values apwkst00cat2 lab_apwkst00cat2
gen amatwkst00cat2 = amwkst00cat2 if ampsex00==2 & appsex00==1
replace amatwkst00cat2 = apwkst00cat2 if ampsex00==1 & appsex00==2
label define lab_amatwkst00cat2 1"Currently employee" 2"No job"
label values amatwkst00cat2 lab_amatwkst00cat2
gen apatwkst00cat2 = amwkst00cat2 if ampsex00==1 & appsex00==2
replace apatwkst00cat2 = apwkst00cat2 if ampsex00==2 & appsex00==1
label define lab_apatwkst00cat2 1"Currently employee" 2"No job"
label values apatwkst00cat2 lab_apatwkst00cat2

*Making ordinal variable of household income
recode AOECDUK0 (-1=.) (1/2=3) (3=2) (4/5=1), gen(AOECDUK0cat3)
label define lab_AOECDUK0cat3 1"High" 2"Middlle" 3"Low"
label values AOECDUK0cat3 lab_AOECDUK0cat3

recode AOECDUK0 (-1=.) (1=5) (2=4) (3=3) (4=2) (5=1), gen(AOECDUK0cat5)
label define lab_AOECDUK0cat5 1"Highest quintile" 2"Second quintile" 3"Third quintile" 4"Fourth quintile" 5"Lowest quintile"
label values AOECDUK0cat5 lab_AOECDUK0cat5

*Making birthweight category variable for auxiliary variable
gen ADBWGTA0cat = 1 if 2.5>ADBWGTA0
replace ADBWGTA0cat = 1 if  2.5==ADBWGTA0
replace ADBWGTA0cat = 0 if  2.5<ADBWGTA0
label define lab_ADBWGTA0cat 0">2.5kg" 1"2.5kg≥"
label values ADBWGTA0cat lab_ADBWGTA0cat

*Productive families at MCS2 is included
keep if BAOUTC00 == 1

*Restriction to singleton with natural parents
keep if ADHTYP00==1
keep if ahnoba00==1

*Making Table1
table1, by (bmmmrlaabi) vars(anatpatmatdistsincat cat \ AMATDAGB00cat3 cat \ APATDAGB00cat3 cat \ ADTOTS00cat3 cat \ amatacqucat3 cat \ apatacqucat3 cat \ AOECDUK0cat5 cat \ ampeta00cat3 cat \ ADGPAR00 cat \ amatwkst00cat2 cat \ apatwkst00cat2 cat \ AXD07S00cat3 cat)onecol

*Logistc regression analysis as complete case analysis
svy:logistic bmmmrlaabi i.anatpatmatdistsincat i.AMATDAGB00cat3 i.APATDAGB00cat3 i.ADTOTS00cat3 i.amatacqucat3 i.apatacqucat3 i.AOECDUK0cat5 i.ampeta00cat3 ADGPAR00 i.amatwkst00cat2 i.apatwkst00cat2 i.AXD07S00cat3


