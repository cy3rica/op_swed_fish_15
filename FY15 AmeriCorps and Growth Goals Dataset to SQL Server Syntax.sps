******************************************************************************************************************************************************
***** FY15 AmeriCorps Performance Measure Analysis.
******************************************************************************************************************************************************
***** WARNING: DO NOT SAVE DATA FILE -- MUST SAVE AS NEW FILE OR YOU WILL PERMANENTLY LOSE DATA.
******************************************************************************************************************************************************
***** See performance improvement definitions here:
*****     https://cyconnect.cityyear.org/funcserv/RSO/Goal%20Management/Forms/AllItems.aspx?RootFolder=%2Ffuncserv%2FRSO%2FGoal%20Management%2FFY15&FolderCTID=0x012000DF5F215501704D44873A6A146F90AC8700AE00225C9FA67C4D8645F91A31955A72&View=%7B937BCFDF%2DD11E%2D452D%2D84E6%2DFDD1EBCACF1E%7D
******************************************************************************************************************************************************

******************************************************************************************************************************************************
***** Pull up and define source data files -- don't forget to make sure all ID variables are identical size/format.
******************************************************************************************************************************************************

***** Pull up student-level data file.
GET FILE = "Z:\Cross Instrument\FY15\FINAL DATASET 2015.02.08.sav".
DATASET NAME StudentData.

***** Pull up MAP Growth Targets.
GET FILE = "Z:\Cross Instrument\FY15\Source Data\2011 NWEA MAP National Norms2011_Growth.sav".
DATASET NAME MAPGrowthTargets.

***** Pull up SRI Growth Targets.
GET FILE = "Z:\Cross Instrument\FY15\Source Data\SRI Growth Targets 2011.sav".
DATASET NAME SRIGrowthTargets.

***** Pull up Providence's Student Level Performance Targets.
*GET FILE = "Z:\Cross Instrument\FY15\Source Data\".
*DATASET NAME ProvidenceGrowthTargets.

***** Pull up San Jose's Student Level Performance Targets.
*GET FILE = "Z:\Cross Instrument\FY15\Source Data\".
*DATASET NAME SanJoseGrowthTargets.

******************************************************************************************************************************************************
***** Merge growth targets.
******************************************************************************************************************************************************

********************************************************************************
***** MAP Assessments: ELA and math.
********************************************************************************

*****     Prep growth targets for merge..
DATASET ACTIVATE MAPGrowthTargets.
*****     Split growth targets into separate ELA and MTH files.
DATASET COPY MAPGrowthTargetsELA.
DATASET COPY MAPGrowthTargetsMTH.
DATASET CLOSE MAPGrowthTargets.

*****     Prep ELA file for merge.
DATASET ACTIVATE MAPGrowthTargetsELA.
SELECT IF Subject = 2.
EXECUTE.
*****     Rename variables for merge.
RENAME VARIABLES (StartGrade = StudentGrade) (StartRIT = LITAssess_PRE_VALUE_NUM).
*****     Sort by grade level, and start score.
SORT CASES BY StudentGrade (A) LITAssess_PRE_VALUE_NUM (A).

*****     Prep student performance dataset for merge.
DATASET ACTIVATE StudentData.
SORT CASES BY StudentGrade (A) LITAssess_PRE_VALUE_NUM (A).

*****     Attach ELA growth targets to performance data.
MATCH FILES /FILE = StudentData
   /TABLE MAPGrowthTargetsELA
   /BY StudentGrade LITAssess_PRE_VALUE_NUM
 /DROP T41 T42 T44 T22 T12 R44 S41 S42 S44 S22 S12.
DATASET NAME StudentData.

*****     Determine which growth value to use.
DATASET ACTIVATE StudentData.
RENAME VARIABLES (R41 = MAPELAR41) (R42 = MAPELAR42) (R12 = MAPELAR12) (R22 = MAPELAR22).
*****     R41=SOY-MY, R42=SOY-EOY, R12=MY-EOY, R22=EOY-EOY.
DO IF (LITAssess_PRE_DATE >= DATE.MDY(7,1,2014) & LITAssess_PRE_DATE <= DATE.MDY(11,30,2014) &
LITAssess_POST_DATE >= DATE.MDY(12,1,2014) & LITAssess_POST_DATE <= DATE.MDY(3,31,2015)).
COMPUTE MAPELADPSelection = 1.
ELSE IF (LITAssess_PRE_DATE >= DATE.MDY(12,1,2014) & LITAssess_PRE_DATE <= DATE.MDY(3,31,2015) &
LITAssess_POST_DATE >= DATE.MDY(4,1,2015) & LITAssess_POST_DATE <= DATE.MDY(6,30,2015)).
COMPUTE MAPELADPSelection = 2.
ELSE IF (LITAssess_PRE_DATE >= DATE.MDY(7,1,2014) & LITAssess_PRE_DATE <= DATE.MDY(11,30,2014) &
LITAssess_POST_DATE >= DATE.MDY(4,1,2015) & LITAssess_POST_DATE <= DATE.MDY(6,30,2015)).
COMPUTE MAPELADPSelection = 3.
ELSE IF (LITAssess_PRE_DATE >= DATE.MDY(4,1,2014) & LITAssess_PRE_DATE <= DATE.MDY(6,30,2014) &
LITAssess_POST_DATE >= DATE.MDY(4,1,2015) & LITAssess_POST_DATE <= DATE.MDY(6,30,2015)).
COMPUTE MAPELADPSelection = 4.
END IF.
VALUE LABELS MAPELADPSelection 1 "SOY to MY"
   2 "MY to EOY"
   3 "SOY to EOY"
   4 "EOY to EOY".
EXECUTE.
IF (MAPELADPSelection = 1) MAPELAPerfGoal = MAPELAR41.
IF (MAPELADPSelection = 2) MAPELAPerfGoal = MAPELAR12.
IF (MAPELADPSelection = 3) MAPELAPerfGoal = MAPELAR42.
IF (MAPELADPSelection = 4) MAPELAPerfGoal = MAPELAR22.
VARIABLE LABELS MAPELAPerfGoal "MAP ELA student performance growth goal based on RIT projection and time of assessment".
EXECUTE.
DATASET CLOSE MAPGrowthTargetsELA.

***** Prep math file for merge.
DATASET ACTIVATE MAPGrowthTargetsMTH.
SELECT IF Subject = 1.
EXECUTE.
*Rename variables for merge.
RENAME VARIABLES (StartGrade = StudentGrade) (StartRIT = MTHAssess_PRE_VALUE_NUM).
*Sort by grade level, and start score.
SORT CASES BY StudentGrade (A) MTHAssess_PRE_VALUE_NUM (A).

*****     Prep student performance dataset for merge.
DATASET ACTIVATE StudentData.
SORT CASES BY StudentGrade (A) MTHAssess_PRE_VALUE_NUM (A).

*****     Attach math growth targets to performance data.
MATCH FILES /FILE = StudentData
   /TABLE MAPGrowthTargetsMTH
   /BY StudentGrade MTHAssess_PRE_VALUE_NUM
 /DROP T41 T42 T44 T22 T12 R44 S41 S42 S44 S22 S12.
DATASET NAME StudentData.

*****     Determine which growth value to use.
DATASET ACTIVATE StudentData.
RENAME VARIABLES (R41 = MAPMTHR41) (R42 = MAPMTHR42) (R12 = MAPMTHR12) (R22 = MAPMTHR22).
*****     R41=SOY-MY, R42=SOY-EOY, R12=MY-EOY, R22=EOY-EOY.
DO IF (MTHAssess_PRE_DATE >= DATE.MDY(7,1,2014) & MTHAssess_PRE_DATE <= DATE.MDY(11,30,2014) &
MTHAssess_POST_DATE >= DATE.MDY(12,1,2014) & MTHAssess_POST_DATE <= DATE.MDY(3,31,2015)).
COMPUTE MAPMTHDPSelection = 1.
ELSE IF (MTHAssess_PRE_DATE >= DATE.MDY(12,1,2014) & MTHAssess_PRE_DATE <= DATE.MDY(3,31,2015) &
MTHAssess_POST_DATE >= DATE.MDY(4,1,2015) & MTHAssess_POST_DATE <= DATE.MDY(6,30,2015)).
COMPUTE MAPMTHDPSelection = 2.
ELSE IF (MTHAssess_PRE_DATE >= DATE.MDY(7,1,2014) & MTHAssess_PRE_DATE <= DATE.MDY(11,30,2014) &
MTHAssess_POST_DATE >= DATE.MDY(4,1,2015) & MTHAssess_POST_DATE <= DATE.MDY(6,30,2015)).
COMPUTE MAPMTHDPSelection = 3.
ELSE IF (MTHAssess_PRE_DATE >= DATE.MDY(4,1,2014) & MTHAssess_PRE_DATE <= DATE.MDY(6,30,2014) &
MTHAssess_POST_DATE >= DATE.MDY(4,1,2015) & MTHAssess_POST_DATE <= DATE.MDY(6,30,2015)).
COMPUTE MAPMTHDPSelection = 4.
END IF.
VALUE LABELS MAPMTHDPSelection 1 "SOY to MY"
   2 "MY to EOY"
   3 "SOY to EOY"
   4 "EOY to EOY".
EXECUTE.
IF (MAPMTHDPSelection = 1) MAPMTHPerfGoal = MAPMTHR41.
IF (MAPMTHDPSelection = 2) MAPMTHPerfGoal = MAPMTHR12.
IF (MAPMTHDPSelection = 3) MAPMTHPerfGoal = MAPMTHR42.
IF (MAPMTHDPSelection = 4) MAPMTHPerfGoal = MAPMTHR22.
VARIABLE LABELS MAPMTHPerfGoal "MAP math student performance growth goal based on RIT projection and time of assessment".
EXECUTE.
DATASET CLOSE MAPGrowthTargetsMTH.

********************************************************************************
***** SRI.
********************************************************************************

*****     Prep growth targets for merge.
DATASET ACTIVATE SRIGrowthTargets.
*****     Rename variables for merge.
RENAME VARIABLES (SRIGrade = StudentGrade) (SRIFallLexileMeasure = SRIFallLexileScoreLink).
*****     Delete unnecessary variables.
DELETE VARIABLES SRIFallLexileMeasureMax SRISpringLexileMeasure.
*****     Sort by grade level, and start score.
SORT CASES BY StudentGrade (A) SRIFallLexileScoreLink (A).
EXECUTE.

*****     Prep student performance dataset for merge.
DATASET ACTIVATE StudentData.
*****     Create fall lexile score linking variable -- can't use original score variable since growth targets are only provided in increments of 10, while actual.
*****     scores can take the form of any integer. Also need to take care of extreme values, by grade-level.
COMPUTE SRIFallLexileScoreLink = LITAssess_PRE_VALUE_NUM - MOD(LITAssess_PRE_VALUE_NUM, 10).
EXECUTE.
IF (SRIFallLexileScoreLink < 100) SRIFallLexileScoreLink = 0.
IF (StudentGrade = 3 & SRIFallLexileScoreLink > 970) SRIFallLexileScoreLink = 970.
IF (StudentGrade = 4 & SRIFallLexileScoreLink > 1060) SRIFallLexileScoreLink = 1060.
IF (StudentGrade = 5 & SRIFallLexileScoreLink > 1160) SRIFallLexileScoreLink = 1160.
IF (StudentGrade = 6 & SRIFallLexileScoreLink > 1220) SRIFallLexileScoreLink = 1220.
IF (StudentGrade = 7 & SRIFallLexileScoreLink > 1270) SRIFallLexileScoreLink = 1270.
IF (StudentGrade = 8 & SRIFallLexileScoreLink > 1330) SRIFallLexileScoreLink = 1330.
IF (StudentGrade = 9 & SRIFallLexileScoreLink > 1370) SRIFallLexileScoreLink = 1370.
IF (StudentGrade = 10 & SRIFallLexileScoreLink > 1400) SRIFallLexileScoreLink = 1400.
EXECUTE.
SORT CASES BY StudentGrade (A) SRIFallLexileScoreLink (A).

*****     Attach SRI growth targets to performance data.
MATCH FILES /FILE = StudentData
   /TABLE SRIGrowthTargets
   /BY StudentGrade SRIFallLexileScoreLink.
DATASET NAME StudentData.

DATASET CLOSE SRIGrowthTargets.

******************************************************************************************************************************************************
*****Attach literacy/math performance goals to each record, and calculate met/not met variables for attendance/behavior.
******************************************************************************************************************************************************

DATASET ACTIVATE StudentData.

********************************************************************************
***** BATON ROUGE (syntax all set XX/XX).
********************************************************************************

***** BATON ROUGE: LIT.
*****     EADMS.
IF (Location = "Baton Rouge" & (LITAssess_PRE_DESC = "EADMS (Educator's Assessment Data Management System" |
   LITAssess_POST_DESC = "EADMS (Educator's Assessment Data Management System")) AC_LIT_SCORE_GOAL = 0.05.
***** BATON ROUGE: MTH.
*****     EADMS.
IF (Location = "Baton Rouge" & (MTHAssess_PRE_DESC = "EADMS (Educator's Assessment Data Management System" |
   MTHAssess_POST_DESC = "EADMS (Educator's Assessment Data Management System")) AC_MTH_SCORE_GOAL = 0.05.
***** BATON ROUGE: ATT -- UPDATE THIS LATER, THIS IS JUST DUMMY/PLACEHOLDER SYNTAX FROM LAST YEAR.
IF (Location = "Baton Rouge" & ATT_INC_BY_2_PERC_PT = 1) AC_ATT_MET_IMP = 1.
IF (Location = "Baton Rouge" & ATT_INC_BY_2_PERC_PT = 0) AC_ATT_MET_IMP = 0.
IF (Location = "Baton Rouge" & ATT_PRE_ADA < 0.9 & ATT_POST_ADA >= 0.9) AC_ATT_MET_ON = 1.
IF (Location = "Baton Rouge" & ATT_PRE_ADA < 0.9 & ATT_POST_ADA < 0.9) AC_ATT_MET_ON = 0.
***** BATON ROUGE: BEH.
EXECUTE.

********************************************************************************
***** BOSTON.
********************************************************************************

***** BOSTON: LIT.
***** BOSTON: MTH.
***** BOSTON: ATT.
***** BOSTON: BEH.

********************************************************************************
***** CHICAGO.
********************************************************************************

***** CHICAGO: LIT.
***** CHICAGO: MTH.
***** CHICAGO: ATT.
***** CHICAGO: BEH.

********************************************************************************
***** CLEVELAND.
********************************************************************************

***** CLEVELAND: LIT.
***** CLEVELAND: MTH.
***** CLEVELAND: ATT.
***** CLEVELAND: BEH.

********************************************************************************
***** COLUMBIA.
********************************************************************************

***** COLUMBIA: LIT.
***** COLUMBIA: MTH.
***** COLUMBIA: ATT.
***** COLUMBIA: BEH.

********************************************************************************
***** COLUMBUS.
********************************************************************************

***** COLUMBUS: LIT.
***** COLUMBUS: MTH.
***** COLUMBUS: ATT.
***** COLUMBUS: BEH.

********************************************************************************
***** DALLAS.
********************************************************************************

***** DALLAS: LIT.
***** DALLAS: MTH.
***** DALLAS: ATT.
***** DALLAS: BEH.

********************************************************************************
***** DENVER.
********************************************************************************

***** DENVER: LIT.
***** DENVER: MTH.
***** DENVER: ATT.
***** DENVER: BEH.

********************************************************************************
***** DETROIT.
********************************************************************************

***** DETROIT: LIT.
***** DETROIT: MTH.
***** DETROIT: ATT.
***** DETROIT: BEH.

********************************************************************************
***** JACKSONVILLE.
********************************************************************************

***** JACKSONVILLE: LIT.
***** JACKSONVILLE: MTH.
***** JACKSONVILLE: ATT.
***** JACKSONVILLE: BEH.

********************************************************************************
***** LITTLE ROCK.
********************************************************************************

***** LITTLE ROCK: LIT.
***** LITTLE ROCK: MTH.
***** LITTLE ROCK: ATT.
***** LITTLE ROCK: BEH.

********************************************************************************
***** LOS ANGELES.
********************************************************************************

***** LOS ANGELES: LIT.
***** LOS ANGELES: MTH.
***** LOS ANGELES: ATT.
***** LOS ANGELES: BEH.

********************************************************************************
***** MIAMI.
********************************************************************************

***** MIAMI: LIT.
***** MIAMI: MTH.
***** MIAMI: ATT.
***** MIAMI: BEH.

********************************************************************************
***** MILWAUKEE.
********************************************************************************

***** MILWAUKEE: LIT.
***** MILWAUKEE: MTH.
***** MILWAUKEE: ATT.
***** MILWAUKEE: BEH.

********************************************************************************
***** NEW HAMPSHIRE.
********************************************************************************

***** NEW HAMPSHIRE: LIT.
***** NEW HAMPSHIRE: MTH.
***** NEW HAMPSHIRE: ATT.
***** NEW HAMPSHIRE: BEH.

********************************************************************************
***** NEW ORLEANS.
********************************************************************************

***** NEW ORLEANS: LIT.
***** NEW ORLEANS: MTH.
***** NEW ORLEANS: ATT.
***** NEW ORLEANS: BEH.

********************************************************************************
***** NEW YORK.
********************************************************************************

***** NEW YORK: LIT.
*****     DRP.
IF (Location = "New York" & (LITAssess_PRE_DESC = "Degrees of Reading Power (DRP)" |
   LITAssess_POST_DESC = "Degrees of Reading Power (DRP)")) AC_LIT_PERF_LVL_GOAL = 1.
EXECUTE.
***** NEW YORK: MTH.
*****     easyCBM.
IF (Location = "New York" & (MTHAssess_PRE_DESC = "easyCBM/easyCBM-2 (Curriculum Based Measurement)" |
MTHAssess_POST_DESC = "easyCBM/easyCBM-2 (Curriculum Based Measurement)")) AC_MTH_PERF_LVL_GOAL = 1.
***** NEW YORK: ATT.
***** NEW YORK: BEH.
EXECUTE.

********************************************************************************
***** ORLANDO.
********************************************************************************

***** ORLANDO: LIT.
***** ORLANDO: MTH.
***** ORLANDO: ATT.
***** ORLANDO: BEH.

********************************************************************************
***** PHILADELPHIA.
********************************************************************************

***** PHILADELPHIA: LIT.
***** PHILADELPHIA: MTH.
***** PHILADELPHIA: ATT.
***** PHILADELPHIA: BEH.

********************************************************************************
***** PROVIDENCE.
********************************************************************************

***** PROVIDENCE: LIT.
***** PROVIDENCE: MTH.
***** PROVIDENCE: ATT.
***** PROVIDENCE: BEH.

********************************************************************************
***** SACRAMENTO.
********************************************************************************

***** SACRAMENTO: LIT.
***** SACRAMENTO: MTH.
***** SACRAMENTO: ATT.
***** SACRAMENTO: BEH.

********************************************************************************
***** SAN ANTONIO.
********************************************************************************

***** SAN ANTONIO: LIT.
***** SAN ANTONIO: MTH.
***** SAN ANTONIO: ATT.
***** SAN ANTONIO: BEH.

********************************************************************************
***** SAN JOSE.
********************************************************************************

***** SAN JOSE: LIT.
***** SAN JOSE: MTH.
***** SAN JOSE: ATT.
***** SAN JOSE: BEH.

********************************************************************************
***** SEATTLE.
********************************************************************************

***** SEATTLE: LIT.
***** SEATTLE: MTH.
***** SEATTLE: ATT.
***** SEATTLE: BEH.

********************************************************************************
***** TULSA.
********************************************************************************

***** TULSA: LIT.
***** TULSA: MTH.
***** TULSA: ATT.
***** TULSA: BEH.

********************************************************************************
***** WASHINGTON, DC.
********************************************************************************

***** WASHINGTON, DC: LIT.
***** WASHINGTON, DC: MTH.
***** WASHINGTON, DC: ATT.
***** WASHINGTON, DC: BEH.

******************************************************************************************************************************************************
***** Add value and variable labels for attendance and behavior met/not met performance goal variables.
******************************************************************************************************************************************************

VALUE LABELS AC_ATT_MET_IMP /*AC_ATT_MET_ON AC_BEH_MET*/ 0 "N"
   1 "Y".
VARIABLE LABELS AC_ATT_MET_IMP "Did the student meet the attendance performance goal? (Measured by change in ADA)"
   AC_ATT_MET_ON "Did the student meet the attendance performance goal? (Measured in terms of moving back on-track)"   /*AC_BEH_MET "Did the student meet the behavior performance goal? (Measured by decrease in suspensions, 3+ pt. increase in DESSA, or 0.5 pt. increase in behavior rubric)"*/ .
EXECUTE.

******************************************************************************************************************************************************
***** Tag students meeting performance goal (LIT and MTH only -- ATT and BEH already incorporated into syntax above).
******************************************************************************************************************************************************

***** Create variable that indicates if a student met the performance goal, in terms of raw score improvement.
*****     LIT.
COMPUTE EOY_LIT_SCORE_DIFF = LITAssess_POST_VALUE_NUM - LITAssess_PRE_VALUE_NUM.
IF (EOY_LIT_SCORE_DIFF >= AC_LIT_SCORE_GOAL) AC_LIT_MET_IMP = 1.
IF (EOY_LIT_SCORE_DIFF < AC_LIT_SCORE_GOAL) AC_LIT_MET_IMP = 0.
EXECUTE.
VALUE LABELS AC_LIT_MET_IMP 0 "N"
   1 "Y".
VARIABLE LABELS AC_LIT_MET_IMP "Did the student meet the literacy performance goal? (Measured by raw score)".
EXECUTE.
*****     MTH.
COMPUTE EOY_MTH_SCORE_DIFF = MTHAssess_POST_VALUE_NUM - MTHAssess_PRE_VALUE_NUM.
IF (EOY_MTH_SCORE_DIFF >= AC_MTH_SCORE_GOAL) AC_MTH_MET_IMP = 1.
IF (EOY_MTH_SCORE_DIFF < AC_MTH_SCORE_GOAL) AC_MTH_MET_IMP = 0.
EXECUTE.
VALUE LABELS AC_MTH_MET_IMP 0 "N"
   1 "Y".
VARIABLE LABELS AC_MTH_MET_IMP "Did the student meet the math performance goal? (Measured by raw score)".
EXECUTE.

***** Create variable that indicates if a student met the performance goal, in terms of performance level improvement.
*****     LIT.
COMPUTE EOY_LIT_PERF_LVL_DIFF = LITAssess_POST_TRACK_NUM - LITAssess_PRE_TRACK_NUM.
IF (EOY_LIT_PERF_LVL_DIFF >= AC_LIT_PERF_LVL_GOAL) AC_LIT_MET_PERF_LVL = 1.
IF (EOY_LIT_PERF_LVL_DIFF < AC_LIT_PERF_LVL_GOAL) AC_LIT_MET_PERF_LVL = 0.
EXECUTE.
VALUE LABELS AC_LIT_MET_PERF_LVL 0 "N"
   1 "Y".
VARIABLE LABELS AC_LIT_MET_PERF_LVL "Did the student meet the literacy performance goal? (Measured by performance level)".
EXECUTE.
*****     MTH.
COMPUTE EOY_MTH_PERF_LVL_DIFF = MTHAssess_POST_TRACK_NUM - MTHAssess_PRE_TRACK_NUM.
IF (EOY_MTH_PERF_LVL_DIFF >= AC_MTH_PERF_LVL_GOAL) AC_MTH_MET_PERF_LVL = 1.
IF (EOY_MTH_PERF_LVL_DIFF < AC_MTH_PERF_LVL_GOAL) AC_MTH_MET_PERF_LVL = 0.
EXECUTE.
VALUE LABELS AC_MTH_MET_PERF_LVL 0 "N"
   1 "Y".
VARIABLE LABELS AC_MTH_MET_PERF_LVL "Did the student meet the math performance goal? (Measured by performance level)".
EXECUTE.

*****Create variable that indicates if a student met the performance goal, in terms of other requirements as specified by grant.
*****     LIT.
*COMPUTE AC_LIT_OTH_DIFF = AC_LIT_POST_OTH_SCORE - AC_LIT_PRE_OTH_SCORE.
*IF (AC_LIT_OTH_DIFF >= AC_LIT_OTH_CHANGE_GOAL) AC_LIT_MET_OTH = 1.
*IF (AC_LIT_OTH_DIFF < AC_LIT_OTH_CHANGE_GOAL) AC_LIT_MET_OTH = 0.
*EXECUTE.
*VALUE LABELS AC_LIT_MET_OTH 0 "N"
   1 "Y".
*VARIABLE LABELS AC_LIT_MET_OTH "Did the student meet the literacy performance goal? (Measured on other terms)".
*EXECUTE.
*****     MTH.
*COMPUTE AC_MTH_OTH_DIFF = AC_MTH_POST_OTH_SCORE - AC_MTH_PRE_OTH_SCORE.
*IF (AC_MTH_OTH_DIFF >= AC_MTH_OTH_CHANGE_GOAL) AC_MTH_MET_OTH = 1.
*IF (AC_MTH_OTH_DIFF < AC_MTH_OTH_CHANGE_GOAL) AC_MTH_MET_OTH = 0.
*EXECUTE.
*VALUE LABELS AC_MTH_MET_OTH 0 "N"
   1 "Y".
*VARIABLE LABELS AC_MTH_MET_OTH "Did the student meet the math performance goal? (Measured on other terms)".
*EXECUTE.

******************************************************************************************************************************************************
***** Create variables indicating whether or not a student met enrollment, (dosage or half-dosage goals), and the performance goal.
******************************************************************************************************************************************************

***** Create variable indicating if a student met the enrollment, HALF DOSAGE, and performance goals.
*****     LIT.
IF ((ACLITMetACDoseHALF = 1) & (AC_LIT_MET_IMP = 1 | AC_LIT_MET_PERF_LVL = 1 /*| AC_LIT_MET_OTH = 1*/ )) AC_ED5_LIT_DoseHALF = 1.
VARIABLE LABELS AC_ED5_LIT_DoseHALF "Did the student meet the enrollment, half dosage, and performance goal for literacy?".
*****     MTH.
IF ((ACMTHMetACDoseHALF = 1) & (AC_MTH_MET_IMP = 1 | AC_MTH_MET_PERF_LVL = 1 /*| AC_MTH_MET_OTH = 1*/ )) AC_ED5_MTH_DoseHALF = 1.
VARIABLE LABELS AC_ED5_MTH_DoseHALF "Did the student meet the enrollment, half dosage, and performance goal for math?".
EXECUTE.

*****Create variable indicating if a student met the enrollment, FULL DOSAGE, and performance goals.
*****     LIT.
IF ((ACLITMetACDose = 1) & (AC_LIT_MET_IMP = 1 | AC_LIT_MET_PERF_LVL = 1 /*| AC_LIT_MET_OTH = 1*/ )) AC_ED5_LIT = 1.
VARIABLE LABELS AC_ED5_LIT "Did the student meet the enrollment, full dosage, and performance goal for literacy?".
*****     MTH.
IF ((ACMTHMetACDose = 1) & (AC_MTH_MET_IMP = 1 | AC_MTH_MET_PERF_LVL = 1 /*| AC_MTH_MET_OTH = 1*/ )) AC_ED5_MTH = 1.
VARIABLE LABELS AC_ED5_MTH "Did the student meet the enrollment, full dosage, and performance goal for math?".
*****     ATT.
IF ((ACATTMet56Dose = 1) & (AC_ATT_MET_IMP = 1 | AC_ATT_MET_ON = 1)) AC_ED27_ATT = 1.
VARIABLE LABELS AC_ED27_ATT "Did the student meet the enrollment, full dosage, and performance goal for attendance?".
*****     BEH.
*IF ((ACBEHMet56Dose = 1) & (AC_BEH_MET = 1)) AC_ED27_BEH = 1.
*VARIABLE LABELS AC_ED27_BEH "Did the student meet the enrollment, full dosage, and performance goal for behavior?".
*EXECUTE.

*****Create Chicago specific variable for students exceeding goal, or increasing by 2-pts on Explore assessment (NEED TO CHECK IF THIS APPLIES TO FY15).
*****     LIT.
*IF ((ACLITMetACDose = 1) & (AC_LIT_MET_OTH = 1)) CHIED5LITFullDosage = 1.
*VARIABLE LABELS CHIED5LITFullDosage "CHICAGO ONLY: Did the student meet the enrollment, full dosage, and either (1) exceeded MAP goal or (2) increased Explore score by at least 2 points?".
*****     MTH.
*IF ((ACMTHMetACDose = 1) & (AC_MTH_MET_OTH = 1)) CHIED5MTHFullDosage = 1.
*VARIABLE LABELS CHIED5MTHFullDosage "CHICAGO ONLY: Did the student meet the enrollment, full dosage, and either (1) exceeded MAP goal or (2) increased Explore score by at least 2 points?".
*EXECUTE.

******************************************************************************************************************************************************
***** Create variables indicating whether or not a student met enrollment and (dosage or half-dosage goals), and had at least two data points.
***** THIS IS THE BASE POPULATION OF STUDENTS.
******************************************************************************************************************************************************

***** Create variable indicating if a student met enrollment, half dosage, and had two data points.
*****     LIT.
IF (ACLITMetACDoseHalf = 1 & NOT MISSING(LITAssess_PRE_VALUE_NUM) & NOT MISSING(LITAssess_POST_VALUE_NUM)) AC_ED5_LIT_EligibleBaseHalfDose = 1.
*****     MTH.
IF (ACMTHMetACDoseHalf = 1 & NOT MISSING(MTHAssess_PRE_VALUE_NUM) & NOT MISSING(MTHAssess_POST_VALUE_NUM)) AC_ED5_MTH_EligibleBaseHalfDose = 1.
VARIABLE LABELS AC_ED5_LIT_EligibleBaseHalfDose "Did the student meet enrollment and half dosage thresholds, and have at least two performance data points for literacy?"
   AC_ED5_MTH_EligibleBaseHalfDose "Did the student meet enrollment and half dosage thresholds, and have at least two performance data points for math?".
EXECUTE.

***** Create variable indicating if a student met enrollment, full dosage, and had two data points.
*****     LIT.
IF (ACLITMetACDose = 1 & NOT MISSING(LITAssess_PRE_VALUE_NUM) & NOT MISSING(LITAssess_POST_VALUE_NUM)) AC_ED5_LIT_EligibleBase = 1.
*****     MTH.
IF (ACMTHMetACDose = 1 & NOT MISSING(MTHAssess_PRE_VALUE_NUM) & NOT MISSING(MTHAssess_POST_VALUE_NUM)) AC_ED5_MTH_EligibleBase = 1.
*****     ATT.
IF (ACATTMet56Dose = 1 & (NOT MISSING(AC_ATT_MET_IMP) | NOT MISSING(AC_ATT_MET_ON))) AC_ED27_ATT_EligibleBase = 1.
*****     BEH.
*IF (ACBEHMet56Dose = 1 & NOT MISSING(AC_BEH_MET)) AC_ED27_BEH_EligibleBase = 1.
VARIABLE LABELS AC_ED5_LIT_EligibleBase "Did the student meet enrollment and full dosage thresholds, and have at least two performance data points for literacy?"
   AC_ED5_MTH_EligibleBase "Did the student meet enrollment and full dosage thresholds, and have at least two performance data points for math?"
   AC_ED27_ATT_EligibleBase "Did the student meet enrollment and full dosage thresholds, and have at least two performance data points for attendance?"   /*AC_ED27_BEH_EligibleBase "Did the student meet enrollment and full dosage thresholds, and have at least two performance data points for behavior?"*/ .
EXECUTE.

***** Create unique count of students met enrollment, full dosage, and had two data points.
IF (AC_ED5_LIT_EligibleBaseHalfDose = 1 | AC_ED5_MTH_EligibleBaseHalfDose = 1) AC_ED5_EligibleBaseUniqueHalfDose = 1.
IF (AC_ED5_LIT_EligibleBase = 1 | AC_ED5_MTH_EligibleBase = 1) AC_ED5_EligibleBaseUnique = 1.
IF (AC_ED27_ATT_EligibleBase = 1 /*| AC_ED27_BEH_EligibleBase = 1*/ ) AC_ED27_EligibleBaseUnique = 1.
VARIABLE LABELS AC_ED5_EligibleBaseUniqueHalfDose "Number of students meeting enrollment/half dosage criteria that had at least two data points - unique across ELA and math"
   AC_ED5_EligibleBaseUnique "Number of students meeting enrollment/full dosage criteria that had at least two data points - unique across ELA and math"
   AC_ED27_EligibleBaseUnique "Number of students meeting enrollment/full dosage criteria that had at least two data points - unique across attendance and behavior".
EXECUTE.

******************************************************************************************************************************************************
***** Count unique students meeting dosage/enrollment criteria and performance goals over math and ELA.
******************************************************************************************************************************************************

IF (AC_ED5_LIT_DoseHalf = 1 | AC_ED5_MTH_DoseHalf = 1) AC_ED5_UniqueDoseHalf = 1.
IF (AC_ED5_LIT = 1 | AC_ED5_MTH = 1) AC_ED5_Unique = 1.
*IF (CHIED5LITFullDosage = 1 | CHIED5MTHFullDosage = 1) CHIED5FullDoseUnique = 1.
IF (AC_ED27_ATT = 1 /*| AC_ED27_BEH = 1*/ ) AC_ED27_Unique = 1.
EXECUTE.

VARIABLE LABELS AC_ED5_UniqueDoseHalf "Number of students meeting ED5 at HALF DOSAGE criteria - unique across ELA and math"
   AC_ED5_Unique "ACTUAL ED5\nNumber of students meeting ED5 at FULL DOSAGE criteria - unique across ELA and math"
   AC_ED27_Unique "ACTUAL ED27\nNumber of students meeting ED27 at FULL DOSAGE criteria - unique across attendance and behavior"   /*CHIED5FullDoseUnique "CHICAGO ONLY: Number of students meeting the enrollment, full dosage, and either (1) exceeded MAP goal or (2) increased Explore score by at least 2 points"*/ .
EXECUTE.

******************************************************************************************************************************************************
***** Operating Goals.
******************************************************************************************************************************************************

***** Create initial target variables for operating goals.
COMPUTE OG_LIT_SCORE_GOAL = AC_LIT_SCORE_GOAL.
COMPUTE OG_LIT_PERF_LVL_GOAL = AC_LIT_PERF_LVL_GOAL.
*COMPUTE OG_LIT_OTH_CHANGE_GOAL = AC_LIT_OTH_CHANGE_GOAL.
COMPUTE OG_MTH_SCORE_GOAL = AC_MTH_SCORE_GOAL.
COMPUTE OG_MTH_PERF_LVL_GOAL = AC_MTH_PERF_LVL_GOAL.
*COMPUTE OG_MTH_OTH_CHANGE_GOAL = AC_MTH_OTH_CHANGE_GOAL.
EXECUTE.

***** Override AmeriCorps targets where performance goals for operating goals differ.
*****     SEATTLE.
IF (Location = "Seattle" & (LITAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
LITAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) OG_LIT_SCORE_GOAL = MAPELAPerfGoal.
IF (Location = "Seattle" & (MTHAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
MTHAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) OG_MTH_SCORE_GOAL = MAPELAPerfGoal.
EXECUTE.

****************************************************************************************************
***** EOY.
****************************************************************************************************

***** Create variables indicating if students met/didn't meet performance targets for operating goals.
***** Create variable that indicates if a student met the performance goal, in terms of raw score improvement.
*****     LIT.
IF (EOY_LIT_SCORE_DIFF >= OG_LIT_SCORE_GOAL) OG_LIT_MET_IMP = 1.
IF (EOY_LIT_SCORE_DIFF < OG_LIT_SCORE_GOAL) OG_LIT_MET_IMP = 0.
EXECUTE.
VALUE LABELS OG_LIT_MET_IMP 0 "N"
   1 "Y".
VARIABLE LABELS OG_LIT_MET_IMP "Did the student meet the literacy performance goal? (Measured by raw score)".
EXECUTE.
*****     MTH.
IF (EOY_MTH_SCORE_DIFF >= OG_MTH_SCORE_GOAL) OG_MTH_MET_IMP = 1.
IF (EOY_MTH_SCORE_DIFF < OG_MTH_SCORE_GOAL) OG_MTH_MET_IMP = 0.
EXECUTE.
VALUE LABELS OG_MTH_MET_IMP 0 "N"
   1 "Y".
VARIABLE LABELS OG_MTH_MET_IMP "Did the student meet the math performance goal? (Measured by raw score)".
EXECUTE.

***** Create variable that indicates if a student met the performance goal, in terms of performance level improvement.
*****     LIT.
IF (EOY_LIT_PERF_LVL_DIFF >= OG_LIT_PERF_LVL_GOAL) OG_LIT_MET_PERF_LVL = 1.
IF (EOY_LIT_PERF_LVL_DIFF < OG_LIT_PERF_LVL_GOAL) OG_LIT_MET_PERF_LVL = 0.
EXECUTE.
VALUE LABELS OG_LIT_MET_PERF_LVL 0 "N"
   1 "Y".
VARIABLE LABELS OG_LIT_MET_PERF_LVL "Did the student meet the literacy performance goal? (Measured by performance level)".
EXECUTE.
*****     MTH.
IF (EOY_MTH_PERF_LVL_DIFF >= OG_MTH_PERF_LVL_GOAL) OG_MTH_MET_PERF_LVL = 1.
IF (EOY_MTH_PERF_LVL_DIFF < OG_MTH_PERF_LVL_GOAL) OG_MTH_MET_PERF_LVL = 0.
EXECUTE.
VALUE LABELS OG_MTH_MET_PERF_LVL 0 "N"
   1 "Y".
VARIABLE LABELS OG_MTH_MET_PERF_LVL "Did the student meet the math performance goal? (Measured by performance level)".
EXECUTE.

*****Create variable that indicates if a student met the performance goal, in terms of other requirements as specified by grant.
*****     LIT.
*COMPUTE OG_EOY_LIT_OTH_DIFF = OG_LIT_POST_OTH_SCORE - OG_LIT_PRE_OTH_SCORE.
*IF (OG_EOY_LIT_OTH_DIFF >= OG_LIT_OTH_CHANGE_GOAL) OG_EOY_LIT_MET_OTH = 1.
*IF (OG_EOY_LIT_OTH_DIFF < OG_LIT_OTH_CHANGE_GOAL) OG_EOY_LIT_MET_OTH = 0.
*EXECUTE.
*VALUE LABELS OG_EOY_LIT_MET_OTH 0 "N"
   1 "Y".
*VARIABLE LABELS OG_EOY_LIT_MET_OTH "Did the student meet the literacy performance goal? (Measured on other terms)".
*EXECUTE.
*****     MTH.
*COMPUTE OG_EOY_MTH_OTH_DIFF = OG_MTH_POST_OTH_SCORE - OG_MTH_PRE_OTH_SCORE.
*IF (OG_EOY_MTH_OTH_DIFF >= OG_MTH_OTH_CHANGE_GOAL) OG_EOY_MTH_MET_OTH = 1.
*IF (OG_EOY_MTH_OTH_DIFF < OG_MTH_OTH_CHANGE_GOAL) OG_EOY_MTH_MET_OTH = 0.
*EXECUTE.
*VALUE LABELS OG_EOY_MTH_MET_OTH 0 "N"
   1 "Y".
*VARIABLE LABELS OG_EOY_MTH_MET_OTH "Did the student meet the math performance goal? (Measured on other terms)".
*EXECUTE.

****************************************************************************************************
***** MY.
****************************************************************************************************

***** Create variables indicating if students met/didn't meet performance targets for operating goals.
***** Create variable that indicates if a student met the performance goal, in terms of raw score improvement.
*****     LIT.
COMPUTE MY_LIT_SCORE_DIFF = LITAssess_MY_VALUE_NUM - LITAssess_PRE_VALUE_NUM.
IF (MY_LIT_SCORE_DIFF >= OG_LIT_SCORE_GOAL) OG_MY_LIT_MET_IMP = 1.
IF (MY_LIT_SCORE_DIFF < OG_LIT_SCORE_GOAL) OG_MY_LIT_MET_IMP = 0.
EXECUTE.
VALUE LABELS OG_MY_LIT_MET_IMP 0 "N"
   1 "Y".
VARIABLE LABELS OG_MY_LIT_MET_IMP "Did the student meet the literacy performance goal? (Measured by raw score, mid-year)".
EXECUTE.
*****     MTH.
COMPUTE MY_MTH_SCORE_DIFF = MTHAssess_MY_VALUE_NUM - MTHAssess_PRE_VALUE_NUM.
IF (MY_MTH_SCORE_DIFF >= OG_MTH_SCORE_GOAL) OG_MY_MTH_MET_IMP = 1.
IF (MY_MTH_SCORE_DIFF < OG_MTH_SCORE_GOAL) OG_MY_MTH_MET_IMP = 0.
EXECUTE.
VALUE LABELS OG_MY_MTH_MET_IMP 0 "N"
   1 "Y".
VARIABLE LABELS OG_MY_MTH_MET_IMP "Did the student meet the math performance goal? (Measured by raw score, mid-year)".
EXECUTE.

***** Create variable that indicates if a student met the performance goal, in terms of performance level improvement.
*****     LIT.
COMPUTE MY_LIT_PERF_LVL_DIFF = LITAssess_MY_TRACK_NUM - LITAssess_PRE_TRACK_NUM.
IF (MY_LIT_PERF_LVL_DIFF >= OG_LIT_PERF_LVL_GOAL) OG_MY_LIT_MET_PERF_LVL = 1.
IF (MY_LIT_PERF_LVL_DIFF < OG_LIT_PERF_LVL_GOAL) OG_MY_LIT_MET_PERF_LVL = 0.
EXECUTE.
VALUE LABELS OG_MY_LIT_MET_PERF_LVL 0 "N"
   1 "Y".
VARIABLE LABELS OG_MY_LIT_MET_PERF_LVL "Did the student meet the literacy performance goal? (Measured by performance level, mid-year)".
EXECUTE.
*****     MTH.
COMPUTE MY_MTH_PERF_LVL_DIFF = MTHAssess_MY_TRACK_NUM - MTHAssess_PRE_TRACK_NUM.
IF (MY_MTH_PERF_LVL_DIFF >= OG_MTH_PERF_LVL_GOAL) OG_MY_MTH_MET_PERF_LVL = 1.
IF (MY_MTH_PERF_LVL_DIFF < OG_MTH_PERF_LVL_GOAL) OG_MY_MTH_MET_PERF_LVL = 0.
EXECUTE.
VALUE LABELS OG_MY_MTH_MET_PERF_LVL 0 "N"
   1 "Y".
VARIABLE LABELS OG_MY_MTH_MET_PERF_LVL "Did the student meet the math performance goal? (Measured by performance level, mid-year)".
EXECUTE.

*****Create variable that indicates if a student met the performance goal, in terms of other requirements as specified by grant.
*****     LIT.
*COMPUTE OG_MY_LIT_OTH_DIFF = OG_LIT_MY_OTH_SCORE - OG_LIT_PRE_OTH_SCORE.
*IF (OG_MY_LIT_OTH_DIFF >= OG_LIT_OTH_CHANGE_GOAL) OG_MY_LIT_MET_OTH = 1.
*IF (OG_MY_LIT_OTH_DIFF < OG_LIT_OTH_CHANGE_GOAL) OG_MY_LIT_MET_OTH = 0.
*EXECUTE.
*VALUE LABELS OG_MY_LIT_MET_OTH 0 "N"
   1 "Y".
*VARIABLE LABELS OG_MY_LIT_MET_OTH "Did the student meet the literacy performance goal? (Measured on other terms, mid-year)".
*EXECUTE.
*****     MTH.
*COMPUTE OG_MY_MTH_OTH_DIFF = OG_MTH_MY_OTH_SCORE - OG_MTH_PRE_OTH_SCORE.
*IF (OG_MY_MTH_OTH_DIFF >= OG_MTH_OTH_CHANGE_GOAL) OG_MY_MTH_MET_OTH = 1.
*IF (OG_MY_MTH_OTH_DIFF < OG_MTH_OTH_CHANGE_GOAL) OG_MY_MTH_MET_OTH = 0.
*EXECUTE.
*VALUE LABELS OG_MY_MTH_MET_OTH 0 "N"
   1 "Y".
*VARIABLE LABELS OG_MY_MTH_MET_OTH "Did the student meet the math performance goal? (Measured on other terms, mid-year)".
*EXECUTE.

*****Create variable indicating if a student met the growth goals.
*****     LIT.
IF (OG_MY_LIT_MET_IMP = 1 | OG_MY_LIT_MET_PERF_LVL = 1 /*| OG_MY_LIT_MET_OTH = 1*/ ) OG_MY_LIT_MET_PERF_GROWTH = 1.
VARIABLE LABELS OG_MY_LIT_MET_PERF_GROWTH "Did the student meet the site-defined performance growth target for literacy? (for operating goals)".
IF (OG_LIT_MET_IMP = 1 | OG_LIT_MET_PERF_LVL = 1 /*| OG_EOY_LIT_MET_OTH = 1*/ ) OG_EOY_LIT_MET_PERF_GROWTH = 1.
VARIABLE LABELS OG_EOY_LIT_MET_PERF_GROWTH "Did the student meet the site-defined performance growth target for literacy? (for operating goals)".
*****     MTH.
IF (OG_MY_MTH_MET_IMP = 1 | OG_MY_MTH_MET_PERF_LVL = 1 /*| OG_MY_MTH_MET_OTH = 1*/ ) OG_MY_MTH_MET_PERF_GROWTH = 1.
VARIABLE LABELS OG_MY_MTH_MET_PERF_GROWTH "Did the student meet the site-defined performance growth target for math? (for operating goals)".
IF (OG_MTH_MET_IMP = 1 | OG_MTH_MET_PERF_LVL = 1 /*| OG_EOY_MTH_MET_OTH = 1*/ ) OG_EOY_MTH_MET_PERF_GROWTH = 1.
VARIABLE LABELS OG_EOY_MTH_MET_PERF_GROWTH "Did the student meet the site-defined performance growth target for math? (for operating goals)".

******************************************************************************************************************************************************
***** Push data to SQL Server, for ImpactAnalytics.
******************************************************************************************************************************************************

***** Create copy of student-level dataset.
DATASET COPY FORSQLSERVER.
DATASET ACTIVATE FORSQLSERVER.

***** Rename variables.
RENAME VARIABLES (cysdStudentID = STUDENT_ID) (GrantSiteNum = GrantSite).

***** Convert AC grant variables to string.
STRING AC_GRANT_CATEGORY (A28) AC_GRANT_SITE (A60).
RECODE GrantCategory (1 = "National Direct") (2 = "State Commission") (3 = "School Turnaround AmeriCorps")
INTO AC_GRANT_CATEGORY.
RECODE GrantSite (1 = "Boston [ND]") (2 = "Columbus [ND]") (3 = "Denver [ND]") (4 = "Jacksonville [ND]")
(5 = "Little Rock [ND]") (6 = "Los Angeles [ND]") (7 = "Miami [ND]") (8 = "Milwaukee [ND]") (9 = "Rhode Island [ND]")
(10 = "Sacramento [ND]") (11 = "San Jose [ND]") (12 = "Seattle [ND]") /* 13 "Tulsa [ND]" - Tulsa not on ND for FY15*/ 
(14 = "Washington, DC [ND]") (15 = "Boston [State]") (16 = "Chicago [State]") (17 = "Cleveland [State]")
(18 = "Columbia [State]") (19 = "Columbus [State]") (20 = "Detroit [State]") (21 = "Los Angeles [State]")
(22 = "Louisiana (Baton Rouge) [State]") (23 = "Louisiana (New Orleans) [State]") (24 = "Miami [State Competitive]")
(25 = "Miami [State Formula]") (26 = "New Hampshire [State]") (27 = "New York (DN) [State]") (28 = "New York [State]")
(29 = "Orlando [State GMI]") (30 = "Orlando [State]") (31 = "Philadelphia [State]") (32 = "San Antonio [State]")
(33 = "Washington, DC [State]") (34 = "Chicago / Kelvyn Park High School [STA]")
(35 = "Chicago / Tilden Career Community Academy High School [STA]") (36 = "Denver / North High School [STA]")
(37 = "Denver / Trevista at Horace Mann [STA]") (38 = "Los Angeles / Clinton MS [STA]")
(39 = "Washington, DC / DC Scholars Stanton Elementary School [STA]")
(40 = "Dallas [ND]") (41 = "Orlando [ND]") (42 = "Tulsa [State]")
(43 = "Little Rock / Cloverdale Middle School [STA]") (44 = "Washington, DC / Garfield Elementary School [STA]")
INTO AC_GRANT_SITE.
EXECUTE.
DELETE VARIABLES GrantCategory GrantSite.

***** Create time stamp.
COMPUTE SPSSRunDate = $TIME.
EXECUTE.

ALTER TYPE SPSSRunDate (DATETIMEw).

SORT CASES BY STUDENT_ID (A).

***** Select only necessary variables.
MATCH FILES /FILE = FORSQLSERVER
   /KEEP STUDENT_ID cyStudentID SPSSRunDate Location School StudentGrade AC_GRANT_CATEGORY AC_GRANT_SITE ACLITMetACDoseHALF
   ACMTHMetACDoseHALF ACLITorMTHMetACDoseHALF AC_ED5_LIT_EligibleBaseHalfDose AC_ED5_MTH_EligibleBaseHalfDose
   AC_ED5_EligibleBaseUniqueHalfDose AC_ED5_LIT_DoseHALF AC_ED5_MTH_DoseHALF AC_ED5_UniqueDoseHalf 
   ACLITOfficialFL ACMTHOfficialFL ACLITorMTHOfficialFL ACLITMetACDose ACMTHMetACDose ACLITorMTHMetACDose 
   AC_ED5_LIT_EligibleBase AC_ED5_MTH_EligibleBase AC_ED5_EligibleBaseUnique AC_ED5_LIT AC_ED5_MTH AC_ED5_Unique
   ACATTOfficialFL ACBEHOfficialFL ACATTorBEHOfficialFL ACATTMet56Dose ACBEHMet56Dose ACATTorBEHMet56Dose AC_ED27_ATT_EligibleBase
   /*AC_ED27_BEH_EligibleBase*/ AC_ED27_EligibleBaseUnique AC_ED27_ATT /*AC_ED27_BEH*/ AC_ED27_Unique
   OG_MY_LIT_MET_PERF_GROWTH OG_EOY_LIT_MET_PERF_GROWTH OG_MY_MTH_MET_PERF_GROWTH OG_EOY_MTH_MET_PERF_GROWTH.
DATASET NAME FORSQLSERVER.

EXECUTE.

***** Export data to server.

SAVE TRANSLATE /TYPE=ODBC
  /CONNECT='DSN=ImpactAnalytics;UID=;Trusted_Connection=Yes;APP=IBM SPSS Products: Statistics '+
    'Common;WSID=HQSSPSS;DATABASE=ImpactAnalytics'
  /ENCRYPTED
  /MISSING=IGNORE
  /SQL='DROP TABLE [ImpactAnalytics].[dbo].[FY15_AMERICORPS_AND_GROWTH_DATA]'
  /SQL='CREATE TABLE [ImpactAnalytics].[dbo].[FY15_AMERICORPS_AND_GROWTH_DATA] ([STUDENT_ID] '+
    'float , [cyStudentID] nvarchar (9) NOT NULL, [SPSSRunDate] datetime , [Location] nvarchar '+
    '(14), [School] nvarchar (64), [StudentGrade] float , [AC_GRANT_CATEGORY] nvarchar (28), '+
    '[AC_GRANT_SITE] nvarchar (60), [ACLITMetACDoseHALF] float , [ACMTHMetACDoseHALF] float , '+
    '[ACLITorMTHMetACDoseHALF] float , [AC_ED5_LIT_EligibleBaseHalfDose] float , '+
    '[AC_ED5_MTH_EligibleBaseHalfDose] float , [AC_ED5_EligibleBaseUniqueHalfDose] float , '+
    '[AC_ED5_LIT_DoseHALF] float , [AC_ED5_MTH_DoseHALF] float , [AC_ED5_UniqueDoseHalf] float , '+
    '[ACLITOfficialFL] float , [ACMTHOfficialFL] float , [ACLITorMTHOfficialFL] float , '+
    '[ACLITMetACDose] float , [ACMTHMetACDose] float , [ACLITorMTHMetACDose] float , '+
    '[AC_ED5_LIT_EligibleBase] float , [AC_ED5_MTH_EligibleBase] float , '+
    '[AC_ED5_EligibleBaseUnique] float , [AC_ED5_LIT] float , [AC_ED5_MTH] float , [AC_ED5_Unique] '+
    'float , [ACATTOfficialFL] float , [ACBEHOfficialFL] float , [ACATTorBEHOfficialFL] float , '+
    '[ACATTMet56Dose] float , [ACBEHMet56Dose] float , [ACATTorBEHMet56Dose] float , '+
    '[AC_ED27_ATT_EligibleBase] float , [AC_ED27_EligibleBaseUnique] float , [AC_ED27_ATT] float , '+
    '[AC_ED27_Unique] float , [OG_MY_LIT_MET_PERF_GROWTH] float , [OG_EOY_LIT_MET_PERF_GROWTH] '+
    'float , [OG_MY_MTH_MET_PERF_GROWTH] float , [OG_EOY_MTH_MET_PERF_GROWTH] float , PRIMARY KEY '+
    '([cyStudentID]) )'
  /REPLACE
  /TABLE='SPSS_TEMP'
  /KEEP=STUDENT_ID, cyStudentID, SPSSRunDate, Location, School, StudentGrade, AC_GRANT_CATEGORY, 
    AC_GRANT_SITE, ACLITMetACDoseHALF, ACMTHMetACDoseHALF, ACLITorMTHMetACDoseHALF, 
    AC_ED5_LIT_EligibleBaseHalfDose, AC_ED5_MTH_EligibleBaseHalfDose, 
    AC_ED5_EligibleBaseUniqueHalfDose, AC_ED5_LIT_DoseHALF, AC_ED5_MTH_DoseHALF, AC_ED5_UniqueDoseHalf, 
    ACLITOfficialFL, ACMTHOfficialFL, ACLITorMTHOfficialFL, ACLITMetACDose, ACMTHMetACDose, 
    ACLITorMTHMetACDose, AC_ED5_LIT_EligibleBase, AC_ED5_MTH_EligibleBase, AC_ED5_EligibleBaseUnique, 
    AC_ED5_LIT, AC_ED5_MTH, AC_ED5_Unique, ACATTOfficialFL, ACBEHOfficialFL, ACATTorBEHOfficialFL, 
    ACATTMet56Dose, ACBEHMet56Dose, ACATTorBEHMet56Dose, AC_ED27_ATT_EligibleBase, 
    AC_ED27_EligibleBaseUnique, AC_ED27_ATT, AC_ED27_Unique, OG_MY_LIT_MET_PERF_GROWTH, 
    OG_EOY_LIT_MET_PERF_GROWTH, OG_MY_MTH_MET_PERF_GROWTH, OG_EOY_MTH_MET_PERF_GROWTH
  /SQL='INSERT INTO [ImpactAnalytics].[dbo].[FY15_AMERICORPS_AND_GROWTH_DATA] ([STUDENT_ID], '+
    '[cyStudentID], [SPSSRunDate], [Location], [School], [StudentGrade], [AC_GRANT_CATEGORY], '+
    '[AC_GRANT_SITE], [ACLITMetACDoseHALF], [ACMTHMetACDoseHALF], [ACLITorMTHMetACDoseHALF], '+
    '[AC_ED5_LIT_EligibleBaseHalfDose], [AC_ED5_MTH_EligibleBaseHalfDose], '+
    '[AC_ED5_EligibleBaseUniqueHalfDose], [AC_ED5_LIT_DoseHALF], [AC_ED5_MTH_DoseHALF], '+
    '[AC_ED5_UniqueDoseHalf], [ACLITOfficialFL], [ACMTHOfficialFL], [ACLITorMTHOfficialFL], '+
    '[ACLITMetACDose], [ACMTHMetACDose], [ACLITorMTHMetACDose], [AC_ED5_LIT_EligibleBase], '+
    '[AC_ED5_MTH_EligibleBase], [AC_ED5_EligibleBaseUnique], [AC_ED5_LIT], [AC_ED5_MTH], '+
    '[AC_ED5_Unique], [ACATTOfficialFL], [ACBEHOfficialFL], [ACATTorBEHOfficialFL], '+
    '[ACATTMet56Dose], [ACBEHMet56Dose], [ACATTorBEHMet56Dose], [AC_ED27_ATT_EligibleBase], '+
    '[AC_ED27_EligibleBaseUnique], [AC_ED27_ATT], [AC_ED27_Unique], [OG_MY_LIT_MET_PERF_GROWTH], '+
    '[OG_EOY_LIT_MET_PERF_GROWTH], [OG_MY_MTH_MET_PERF_GROWTH], [OG_EOY_MTH_MET_PERF_GROWTH]) '+
    'SELECT [STUDENT_ID], [cyStudentID], [SPSSRunDate], [Location], [School], [StudentGrade], '+
    '[AC_GRANT_CATEGORY], [AC_GRANT_SITE], [ACLITMetACDoseHALF], [ACMTHMetACDoseHALF], '+
    '[ACLITorMTHMetACDoseHALF], [AC_ED5_LIT_EligibleBaseHalfDose], '+
    '[AC_ED5_MTH_EligibleBaseHalfDose], [AC_ED5_EligibleBaseUniqueHalfDose], '+
    '[AC_ED5_LIT_DoseHALF], [AC_ED5_MTH_DoseHALF], [AC_ED5_UniqueDoseHalf], [ACLITOfficialFL], '+
    '[ACMTHOfficialFL], [ACLITorMTHOfficialFL], [ACLITMetACDose], [ACMTHMetACDose], '+
    '[ACLITorMTHMetACDose], [AC_ED5_LIT_EligibleBase], [AC_ED5_MTH_EligibleBase], '+
    '[AC_ED5_EligibleBaseUnique], [AC_ED5_LIT], [AC_ED5_MTH], [AC_ED5_Unique], [ACATTOfficialFL], '+
    '[ACBEHOfficialFL], [ACATTorBEHOfficialFL], [ACATTMet56Dose], [ACBEHMet56Dose], '+
    '[ACATTorBEHMet56Dose], [AC_ED27_ATT_EligibleBase], [AC_ED27_EligibleBaseUnique], '+
    '[AC_ED27_ATT], [AC_ED27_Unique], [OG_MY_LIT_MET_PERF_GROWTH], [OG_EOY_LIT_MET_PERF_GROWTH], '+
    '[OG_MY_MTH_MET_PERF_GROWTH], [OG_EOY_MTH_MET_PERF_GROWTH] FROM SPSS_TEMP'
  /SQL='DROP TABLE [SPSS_TEMP]'.

******************************************************************************************************************************************************
***** Run summary tables.
******************************************************************************************************************************************************

******************************************************************************************************************************************************
***** END OF FILE.
******************************************************************************************************************************************************