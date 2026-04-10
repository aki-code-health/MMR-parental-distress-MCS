*Making categorical variable of immunusation status as outcome for sensitivity analyses
gen bmmmrlabbi=1 if bmmmrlab==0
replace bmmmrlabbi=0 if bmmmrlab==1
label define lab_bmmmrlabbi 0"MMR Vaccinated" 1"Not complete MMR"
label values bmmmrlabbi lab_bmmmrlabbi

*Making Table
table1, by (bmmmrlabbi) vars(anatpatmatdistsincat cat \ AMATDAGB00cat3 cat \ APATDAGB00cat3 cat \ ADTOTS00cat3 cat \ amatacqucat3 cat \ apatacqucat3 cat \ AOECDUK0cat5 cat \ ampeta00cat3 cat \ ADGPAR00 cat \ amatwkst00cat2 cat \ apatwkst00cat2 cat \ AXD07S00cat3 cat)onecol

*Logistc regression analysis as complete case analysis
svy:logistic bmmmrlabbi i.anatpatmatdistsincat i.AMATDAGB00cat3 i.APATDAGB00cat3 i.ADTOTS00cat3 i.amatacqucat3 i.apatacqucat3 i.AOECDUK0cat5 i.ampeta00cat3 ADGPAR00 i.amatwkst00cat2 i.apatwkst00cat2 i.AXD07S00cat3

*Making tables about missing in each variable
misstable summarize  anatpatmatdistsincat AMATDAGB00cat3 APATDAGB00cat3 ADTOTS00cat3 amatacqucat3 apatacqucat3 AOECDUK0cat5 ampeta00cat3 ADGPAR00 amatwkst00cat2 apatwkst00cat2 AXD07S00cat3 bmmmrlabbi
misstable pattern anatpatmatdistsincat AMATDAGB00cat3 APATDAGB00cat3 ADTOTS00cat3 amatacqucat3 apatacqucat3 AOECDUK0cat5 ampeta00cat3 ADGPAR00 amatwkst00cat2 apatwkst00cat2 AXD07S00cat3 bmmmrlabbi

*Multiple imputation
mi set mlong
mi register imputed anatpatmatdistsincat apatacqucat3 apatwkst00cat2 ampeta00cat3 AMATDAGB00cat3 APATDAGB00cat3 amatacqucat3 AOECDUK0cat5 amatwkst00cat2 AXD07S00cat3 ADTOTS00cat3 ADGPAR00
mi register regular bmmmrlabbi ahcsexa0 ADBWGTA0cat
mi impute chained (mlogit) anatpatmatdistsincat apatacqucat3 apatwkst00cat2 amatwkst00cat2 ampeta00cat3 AMATDAGB00cat3 APATDAGB00cat3 amatacqucat3 AOECDUK0cat5 AXD07S00cat3 ADTOTS00cat3 ADGPAR00 = bmmmrlabbi ahcsexa0 ADBWGTA0cat, add(40) rseed(12345) augment force
mi svyset SPTN00 [pweight=BOVWT2], strata(PTTYPE2) fpc(NH2)
mi estimate, or post: svy: logistic bmmmrlabbi i.anatpatmatdistsincat i.AMATDAGB00cat3 i.APATDAGB00cat3 i.ADTOTS00cat3 i.amatacqucat3 i.apatacqucat3 i.AOECDUK0cat5 i.ampeta00cat3 ADGPAR00 i.amatwkst00cat2 i.apatwkst00cat2 i.AXD07S00cat3
ssc install mimrgns
mimrgns anatpatmatdistsincat, predict(pr)
