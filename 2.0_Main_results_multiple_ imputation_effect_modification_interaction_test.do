*Making tables about missing in each variable
misstable summarize  anatpatmatdistsincat AMATDAGB00cat3 APATDAGB00cat3 ADTOTS00cat3 amatacqucat3 apatacqucat3 AOECDUK0cat5 ampeta00cat3 ADGPAR00 amatwkst00cat2 apatwkst00cat2 AXD07S00cat3 bmmmrlaabi
misstable pattern anatpatmatdistsincat AMATDAGB00cat3 APATDAGB00cat3 ADTOTS00cat3 amatacqucat3 apatacqucat3 AOECDUK0cat5 ampeta00cat3 ADGPAR00 amatwkst00cat2 apatwkst00cat2 AXD07S00cat3 bmmmrlaabi

*Multiple imputation
mi set mlong
mi register imputed anatpatmatdistsincat apatacqucat3 apatwkst00cat2 ampeta00cat3 AMATDAGB00cat3 APATDAGB00cat3 amatacqucat3 AOECDUK0cat5 amatwkst00cat2 AXD07S00cat3
mi register regular bmmmrlaabi ahcsexa0 ADBWGTA0cat ADTOTS00cat3 ADGPAR00
mi impute chained (mlogit) anatpatmatdistsincat apatacqucat3 ampeta00cat3 AMATDAGB00cat3 APATDAGB00cat3 amatacqucat3 AOECDUK0cat5 AXD07S00cat3 amatwkst00cat2 apatwkst00cat2 = bmmmrlaabi ahcsexa0 ADBWGTA0cat ADTOTS00cat3 ADGPAR00, add(40) rseed(12345) augment force
mi svyset SPTN00 [pweight=BOVWT2], strata(PTTYPE2) fpc(NH2)
mi estimate, or post: svy: logistic bmmmrlaabi i.anatpatmatdistsincat i.AMATDAGB00cat3 i.APATDAGB00cat3 i.ADTOTS00cat3 i.amatacqucat3 i.apatacqucat3 i.AOECDUK0cat5 i.ampeta00cat3 ADGPAR00 i.amatwkst00cat2 i.apatwkst00cat2 i.AXD07S00cat3
ssc install mimrgns
mimrgns anatpatmatdistsincat, predict(pr)

*Effect modification of Income
mi passive: gen AOECDUK0cat2 = AOECDUK0cat5==5 if !missing(AOECDUK0cat5)
label define AOECDUK0cat2 0 "Higher income (Q1–4)" 1 "Lowest income quintile"
label values AOECDUK0cat2 AOECDUK0cat2
mi estimate, or post: svy: logistic bmmmrlaabi i.anatpatmatdistsincat##i.AOECDUK0cat2 i.AMATDAGB00cat3 i.APATDAGB00cat3 i.ADTOTS00cat3 i.amatacqucat3 i.apatacqucat3 i.ampeta00cat3 ADGPAR00 i.amatwkst00cat2 i.apatwkst00cat2 i.AXD07S00cat3
lincom 1.anatpatmatdistsincat + 1.anatpatmatdistsincat#1.AOECDUK0cat2, or
lincom 2.anatpatmatdistsincat + 2.anatpatmatdistsincat#1.AOECDUK0cat2, or
lincom 3.anatpatmatdistsincat + 3.anatpatmatdistsincat#1.AOECDUK0cat2, or
testparm i.anatpatmatdistsincat#i.AOECDUK0cat2

*Interaction test of maternal and paternal psycholocgical distress
mi estimate, or: svy: logistic bmmmrlaabi i.anatmatdistsincat##i.anatpatdistsincat i.AMATDAGB00cat3 i.APATDAGB00cat3 i.ADTOTS00cat3 i.amatacqucat3 i.apatacqucat3 i.AOECDUK0cat5 i.ampeta00cat3 ADGPAR00 i.amatwkst00cat2 i.apatwkst00cat2 i.AXD07S00cat3
