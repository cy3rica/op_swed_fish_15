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
*IOG =AC
TO DO: ATT, BEH
*Check Lit/Math assessments in dataset
********************************************************************************

***** BATON ROUGE: LIT.
*****     EADMS (Increase by at least 5 percentage points).
IF (Location = "Baton Rouge" & (LITAssess_PRE_DESC = "EADMS (Educator's Assessment Data Management System" |
   LITAssess_POST_DESC = "EADMS (Educator's Assessment Data Management System")) AC_LIT_SCORE_GOAL = 0.05.
EXECUTE.
***** BATON ROUGE: MTH.
*****     EADMS (Increase by at least 5 percentage points)..
IF (Location = "Baton Rouge" & (MTHAssess_PRE_DESC = "EADMS (Educator's Assessment Data Management System" |
   MTHAssess_POST_DESC = "EADMS (Educator's Assessment Data Management System")) AC_MTH_SCORE_GOAL = 0.05.
EXECUTE.
***** BATON ROUGE: ATT -- UPDATE THIS LATER, THIS IS JUST DUMMY/PLACEHOLDER SYNTAX FROM LAST YEAR.
IF (Location = "Baton Rouge" & ATT_INC_BY_2_PERC_PT = 1) AC_ATT_MET_IMP = 1.
IF (Location = "Baton Rouge" & ATT_INC_BY_2_PERC_PT = 0) AC_ATT_MET_IMP = 0.
IF (Location = "Baton Rouge" & ATT_PRE_ADA < 0.9 & ATT_POST_ADA >= 0.9) AC_ATT_MET_ON = 1.
IF (Location = "Baton Rouge" & ATT_PRE_ADA < 0.9 & ATT_POST_ADA < 0.9) AC_ATT_MET_ON = 0.
EXECUTE.
***** BATON ROUGE: BEH.


********************************************************************************
***** BOSTON. 
*IOG=AC
TO DO: 
*Check Lit/Math assessments in dataset
(ATI, Any numerical increase in the Galileo/BPS Predictive/ATI Score) 
(Rise, Any numerical increase in the RISE score)
ATT/BEH
********************************************************************************

***** BOSTON: LIT.
*****     ANet (Improve by at least 1 percentage point on the SOY and EOY ANet Assessment).
IF (Location = "Boston" & (LITAssess_PRE_DESC = "Achievement Network (ANet)" |
LITAssess_POST_DESC = "Achievement Network (ANet)")) AC_LIT_SCORE_GOAL = 0.01.
EXECUTE.
*****     AIMSweb (Improve by at least one point on the Aimsweb assessment word count/minute (grades 3-8).
IF (Location = "Boston" & (LITAssess_PRE_DESC = "AIMSweb" | LITAssess_POST_DESC = "AIMSweb")) AC_LIT_SCORE_GOAL = 1.
EXECUTE.
*****     BPS Predictive (Any numerical increase in the Galileo/BPS Predictive/ATI score).
IF (Location = "Boston" & (LITAssess_PRE_DESC = "BPS Predictive" | LITAssess_POST_DESC = "BPS Predictive")) AC_LIT_SCORE_GOAL = .01.
EXECUTE.
*****     DIBELS Composite (Any numerical increase in the DIBELS Next composite score).
IF (Location = "Boston" & (LITAssess_PRE_DESC = "DIBELS - Composite (DIBELS Next 7th edition only)" |
LITAssess_POST_DESC = "DIBELS - Composite (DIBELS Next 7th edition only)")) AC_LIT_SCORE_GOAL = .01.
EXECUTE.
*****     DIBELS ORF(Improve by at least 1 word per minute).
IF (Location = "Boston" & (LITAssess_PRE_DESC = "DIBELS - Oral Reading Fluency (ORF or ORF-WRC/words read correctly)" |
LITAssess_POST_DESC = "DIBELS - Oral Reading Fluency (ORF or ORF-WRC/words read correctly)")) AC_LIT_SCORE_GOAL = 1.
IF (Location = "Boston" & (LITAssess_PRE_DESC = "DIBELS - Oral Reading Fluency - Accuracy (ORF-A; DIBELS Next 7th edition only)" |
LITAssess_POST_DESC = "DIBELS - Oral Reading Fluency - Accuracy (ORF-A; DIBELS Next 7th edition only)")) AC_LIT_SCORE_GOAL = 1.
EXECUTE.
*****     DRA (Any numerical increase in the DRA/DRA2 predictive).
IF (Location = "Boston" & (LITAssess_PRE_DESC = "DRA/DRA2 (Developmental Reading Assessment)" |
LITAssess_POST_DESC = "DRA/DRA2 (Developmental Reading Assessment)")) AC_LIT_SCORE_GOAL = .01.
EXECUTE.
*****     Fountas and Pinnell (Improve by at least one alphabet letter).
IF (Location = "Boston" & (LITAssess_PRE_DESC = "Fountas and Pinnell" | LITAssess_POST_DESC = "Fountas and Pinnell")) AC_LIT_SCORE_GOAL = 1.
EXECUTE.
*****     MAP (Any numerical increase in the MAP score).
IF (Location = "Boston" & (LITAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
LITAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_LIT_SCORE_GOAL = .01.
EXECUTE.
*****     TRC (Any letter increase in TRC score).
IF (Location = "Boston" & (LITAssess_PRE_DESC = "TRC (Text Reading and Comprehension)" |
LITAssess_POST_DESC = "TRC (Text Reading and Comprehension)")) AC_LIT_SCORE_GOAL = 1.
EXECUTE.
***** BOSTON: MTH.
*****     ANet (Improve by at least 1 percentage point on the SOY and EOY ANet Assessment).
IF (Location = "Boston" & (MTHAssess_PRE_DESC = "Achievement Network (ANet)" |
MTHAssess_POST_DESC = "Achievement Network (ANet)")) AC_MTH_SCORE_GOAL = 0.01.
EXECUTE.
*****     Galileo (Any numerical increase in the Galileo/BPS Predictive/ATI score.
IF (Location = "Boston" & (MTHAssess_PRE_DESC = "Galileo" | MTHAssess_POST_DESC = "Galileo")) AC_MTH_SCORE_GOAL = .01.
EXECUTE.
*****     MAP (Any numerical increase in the MAP score).
IF (Location = "Boston" & (MTHAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
MTHAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_MTH_SCORE_GOAL = .01.
EXECUTE.
*****     SMI (Any numerical increase in SMI score).
IF (Location = "Boston" & (MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" |
MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)")) AC_MTH_SCORE_GOAL = .01.
EXECUTE.

***** BOSTON: ATT.
***** BOSTON: BEH.

********************************************************************************
***** CHICAGO.
*AC=IOG
To Do: Att/Beh
*check math/lit assess (Math-Explore. ELA- Explore) 
********************************************************************************

***** CHICAGO: LIT.
*****     Chicago: MAP (Meet or exceed growth target)
*****     This means that the numbers in the network-wide tables will reflect students who met/exceeded the perf. goal.
IF (Location = "Chicago" & (LITAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
LITAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_LIT_SCORE_GOAL = MAPELAPerfGoal.
EXECUTE.
*****     Chicago: MAP (Exceed growth target)
*****     This means that the numbers will be in a Chicago-specific table at the bottom of the output table.
IF (Location = "Chicago" & LITAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" & LITAssess_PRE_VALUE_NUM > 0) AC_LIT_PRE_OTH_SCORE = 0.
IF (Location = "Chicago" & (LITAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" | LITAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)") &
(LITAssess_POST_VALUE_NUM - LITAssess_PRE_VALUE_NUM) <= MAPELAPerfGoal) AC_LIT_POST_OTH_SCORE = 0.
IF (Location = "Chicago" & (LITAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" | LITAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)") &
(LITAssess_POST_VALUE_NUM - LITAssess_PRE_VALUE_NUM) > MAPELAPerfGoal) AC_LIT_POST_OTH_SCORE = 1.
IF (Location = "Chicago" & (LITAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
LITAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_LIT_OTH_CHANGE_GOAL = 1.
EXECUTE.
***** CHICAGO: MTH.
*****     Chicago: MAP (Meet or exceed growth target).
*****     This means that the numbers in the network-wide tables will reflect students who met/exceeded the perf. goal.
IF (Location = "Chicago" & (MTHAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
MTHAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_MTH_SCORE_GOAL = MAPMTHPerfGoal.
EXECUTE.
*****     Chicago: MAP (Exceed growth target).
*****     This means that the numbers will be in a Chicago-specific table at the bottom of the output table.
IF (Location = "Chicago" & MTHAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" & MTHAssess_PRE_VALUE_NUM > 0) AC_MTH_PRE_OTH_SCORE = 0.
IF (Location = "Chicago" & (MTHAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" | MTHAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)") &
(MTHAssess_POST_VALUE_NUM - MTHAssess_PRE_VALUE_NUM) <= MAPMTHPerfGoal) AC_MTH_POST_OTH_SCORE = 0.
IF (Location = "Chicago" & (MTHAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" | MTHAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)") &
(MTHAssess_POST_VALUE_NUM - MTHAssess_PRE_VALUE_NUM) > MAPMTHPerfGoal) AC_MTH_POST_OTH_SCORE = 1.
IF (Location = "Chicago" & (MTHAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
MTHAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_MTH_OTH_CHANGE_GOAL = 1.
EXECUTE.
***** CHICAGO: ATT.
***** CHICAGO: BEH.

********************************************************************************
***** CLEVELAND.
*AC <> IOG
*TO DO: 
*Check Math/Lit assess (ELA-Star)
BEH
ATT.
********************************************************************************

***** CLEVELAND: LIT.
*MAP/NWEA (Any improvement, could be a fraction of a point).
IF (Location = "Cleveland" & (LITAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
LITAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_LIT_SCORE_GOAL = .01.
EXECUTE.
***** CLEVELAND: MTH.
*MAP/NWEA (Any improvement, could be a fraction of a point). 
IF (Location = "Cleveland" & (MTHAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
MTHAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_MTH_SCORE_GOAL = .01.
EXECUTE.
***** CLEVELAND: ATT.
***** CLEVELAND: BEH.

********************************************************************************
***** COLUMBIA.
*AC=IOG
*TO DO: 
check lit/math
ATT/BEH
********************************************************************************

***** COLUMBIA: LIT.
**MAP (Increase by at least one point).
IF (Location = "Columbia" & (LITAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
LITAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_LIT_SCORE_GOAL = 1.
EXECUTE.
***** COLUMBIA: MTH.
**MAP (Increase by at least one point).
IF (Location = "Columbia" & (MTHAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
MTHAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_MTH_SCORE_GOAL = 1.
EXECUTE.
***** COLUMBIA: ATT.
***** COLUMBIA: BEH.

********************************************************************************
***** COLUMBUS.
*AC=IOG
*To do:
*check math/lit
STAR (Expected growth target)
BEH/ATT
********************************************************************************

***** COLUMBUS: LIT.
***** MAP (Expected growth target).
IF (Location = "Columbus" & (LITAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
LITAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_LIT_SCORE_GOAL = MAPELAPerfGoal.
EXECUTE.
*SRI (EOY 50 points from baseline).
IF (Location = "Columbus" & (LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" | LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)")) AC_LIT_SCORE_GOAL = 50.
EXECUTE.
***** COLUMBUS: MTH.
***** MAP (Expected growth target).
IF (Location = "Columbus" & (MTHAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
MTHAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_MTH_SCORE_GOAL = MAPMTHPerfGoal.
EXECUTE.
*SMI (EOY 50 points from baseline).
IF (Location = "Columbus" & (MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" |
MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)")) AC_MTH_SCORE_GOAL = 50.
EXECUTE.
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
*AC=IOG
*TO DO:
check lit/math
ATT/BEH
********************************************************************************

***** DENVER: LIT.
*****     DRA (increase by 10 points).
IF (Location = "Denver" & (LITAssess_PRE_DESC = "DRA/DRA2 (Developmental Reading Assessment)" |
LITAssess_POST_DESC = "DRA/DRA2 (Developmental Reading Assessment)")) AC_LIT_SCORE_GOAL = 10.
EXECUTE.
*****    IRLA (1 point).
IF (Location = "Denver" & (LITAssess_PRE_DESC = "Independent Reading Level Assessment (IRLA)" | 
LITAssess_POST_DESC = "Independent Reading Level Assessment (IRLA)")) AC_LIT_SCORE_GOAL = 1.
EXECUTE.
*****     STAR (Expected growth is 1.25 as measured by Instructional Reading Level). 
IF (Location = "Denver" & (LITAssess_PRE_DESC = "STAR Reading" |
LITAssess_POST_DESC = "STAR Reading")) AC_LIT_SCORE_GOAL = 1.25. 
EXECUTE.
*****     SRI.
IF (Location = "Denver" & StudentGrade = 6 & (LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" |
LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)")) AC_LIT_SCORE_GOAL = 56.
IF (Location = "Denver" & StudentGrade = 7 & (LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" |
LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)")) AC_LIT_SCORE_GOAL = 54.
IF (Location = "Denver" & StudentGrade = 8 & (LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" |
LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)")) AC_LIT_SCORE_GOAL = 52.
IF (Location = "Denver" & StudentGrade = 9 & (LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" |
LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)")) AC_LIT_SCORE_GOAL = 50.
EXECUTE.
***** DENVER: MTH.
*****     SMI.
IF (Location = "Denver" & StudentGrade = 3 & (MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" |
MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)")) AC_MTH_SCORE_GOAL = 120.
IF (Location = "Denver" & StudentGrade = 4 & (MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" |
MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)")) AC_MTH_SCORE_GOAL = 90.
IF (Location = "Denver" & StudentGrade = 5 & (MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" |
MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)")) AC_MTH_SCORE_GOAL = 60.
IF (Location = "Denver" & StudentGrade = 6 & (MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" |
MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)")) AC_MTH_SCORE_GOAL = 50.
IF (Location = "Denver" & StudentGrade = 7 & (MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" |
MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)")) AC_MTH_SCORE_GOAL = 40.
IF (Location = "Denver" & StudentGrade = 8 & (MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" |
MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)")) AC_MTH_SCORE_GOAL = 40.
IF (Location = "Denver" & StudentGrade = 9 & (MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" |
MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)")) AC_MTH_SCORE_GOAL = 40.
EXECUTE.
***** DENVER: ATT.
***** DENVER: BEH.

********************************************************************************
***** DETROIT.
*AC=IOG
TO DO:
BEH/ATT
*check math/lit
********************************************************************************

***** DETROIT: LIT.
*MAP/NWEA (any numerical growth in raw score).
IF (Location = "Detroit" & (LITAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
LITAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_LIT_SCORE_GOAL = .01.
EXECUTE.
*ScanTron (any numerical growth in raw score).
IF (Location = "Detroit" & (LITAssess_PRE_DESC = "ScanTron Performance Series" |
LITAssess_POST_DESC = "ScanTron Performance Series")) AC_LIT_SCORE_GOAL = .01. 
EXECUTE.
***** DETROIT: MTH.
*MAP/NWEA (any numerical growth in raw score).
IF (Location = "Detroit" & (MTHAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
MTHAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_MTH_SCORE_GOAL = .01.
EXECUTE.
*ScanTron (any numerical growth in raw score). 
IF (Location = "Detroit" & (MTHAssess_PRE_DESC = "ScanTron Performance Series" | 
MTHAssess_POST_DESC = "ScanTron Performance Series")) AC_MTH_SCORE_GOAL = .01.
EXECUTE.
***** DETROIT: ATT.
***** DETROIT: BEH.

********************************************************************************
***** JACKSONVILLE.
*AC=IOG
TO DO:
ATT/BEH
check math/lit
check to make sure CGA doesn't overlap
********************************************************************************

***** JACKSONVILLE: LIT.
*Achieve 3000, 20 or more lexile point increase.
IF (Location = "Jacksonville" & (LITAssess_PRE_DESC = "Achieve 3000" | LITAssess_POST_DESC = "Achieve 3000"))  AC_LIT_SCORE_GOAL = 20.
EXECUTE.
***** JACKSONVILLE: MTH.
* CGA: Increased benchmark percentage.
IF (Location = "Jacksonville" & (MTHAssess_PRE_DESC = "Curriculum Guide Assessment (CGA)" |
MTHAssess_POST_DESC = "Curriculum Guide Assessment (CGA)")) AC_MTH_SCORE_GOAL = .01. 
IF (Location = "Jacksonville" & (MTHAssess_PRE_DESC = "Curriculum Guide Assessment 1 (CGA 1)" |
MTHAssess_POST_DESC = "Curriculum Guide Assessment 1 (CGA 1)")) AC_MTH_SCORE_GOAL = .01. 
EXECUTE.
***** JACKSONVILLE: ATT.
***** JACKSONVILLE: BEH.

********************************************************************************
***** LITTLE ROCK.
*AC=IOG
*check math/lit
ATT/BEH
********************************************************************************

***** LITTLE ROCK: LIT.
*****     DIBELS.
IF (Location = "Little Rock" & (LITAssess_PRE_DESC = "DIBELS - Oral Reading Fluency (ORF or ORF-WRC/words read correctly)" |
LITAssess_POST_DESC = "DIBELS - Oral Reading Fluency (ORF or ORF-WRC/words read correctly)")) AC_LIT_SCORE_GOAL = 1.
***** STAR.
IF (Location = "Little Rock" & (LITAssess_PRE_DESC = "STAR Reading" | LITAssess_POST_DESC = "STAR Reading")) AC_LIT_SCORE_GOAL = 1.
***** SRI.
IF (Location = "Denver" & (LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" |
LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)")) AC_LIT_SCORE_GOAL = 1.
***** LITTLE ROCK: MTH.
***** SMI.
IF (Location = "Little Rock" & StudentGrade = 3 & (MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" |
MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)")) AC_MTH_SCORE_GOAL = 1.
***** LITTLE ROCK: ATT.
***** LITTLE ROCK: BEH.

********************************************************************************
***** LOS ANGELES.
*AC=IOG
ATT/BEH
check lit/math assess
********************************************************************************

***** LOS ANGELES: LIT.
*****     SRI.
IF (Location = "Los Angeles" &  LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" & LITAssess_PRE_TRACK = "FAR BELOW BASIC") AC_LIT_PRE_PERF_LVL_NUM = 1.
IF (Location = "Los Angeles" &  LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" & LITAssess_PRE_TRACK = "BELOW BASIC") AC_LIT_PRE_PERF_LVL_NUM = 2.
IF (Location = "Los Angeles" &  LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" & LITAssess_PRE_TRACK = "BASIC") AC_LIT_PRE_PERF_LVL_NUM = 3.
IF (Location = "Los Angeles" &  LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" & LITAssess_PRE_TRACK = "PROFICIENT") AC_LIT_PRE_PERF_LVL_NUM = 4.
IF (Location = "Los Angeles" &  LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" & LITAssess_PRE_TRACK = "ADVANCED") AC_LIT_PRE_PERF_LVL_NUM = 5.
EXECUTE.
IF (Location = "Los Angeles" &  LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)" & LITAssess_POST_TRACK = "FAR BELOW BASIC") AC_LIT_POST_PERF_LVL_NUM = 1.
IF (Location = "Los Angeles" &  LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)" & LITAssess_POST_TRACK = "BELOW BASIC") AC_LIT_POST_PERF_LVL_NUM = 2.
IF (Location = "Los Angeles" &  LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)" & LITAssess_POST_TRACK = "BASIC") AC_LIT_POST_PERF_LVL_NUM = 3.
IF (Location = "Los Angeles" &  LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)" & LITAssess_POST_TRACK = "PROFICIENT") AC_LIT_POST_PERF_LVL_NUM = 4.
IF (Location = "Los Angeles" &  LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)" & LITAssess_POST_TRACK = "ADVANCED") AC_LIT_POST_PERF_LVL_NUM = 5.
EXECUTE.
IF (Location = "Los Angeles" & (LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" | LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)")) AC_LIT_PERF_LVL_GOAL = 1.
EXECUTE.
***** LOS ANGELES: MTH.
*****     SMI.
IF (Location = "Los Angeles" & MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" & MTHAssess_PRE_TRACK = "FAR BELOW BASIC") AC_MTH_PRE_PERF_LVL_NUM = 1.
IF (Location = "Los Angeles" & MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" & MTHAssess_PRE_TRACK = "BELOW BASIC") AC_MTH_PRE_PERF_LVL_NUM = 2.
IF (Location = "Los Angeles" & MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" & MTHAssess_PRE_TRACK = "BASIC") AC_MTH_PRE_PERF_LVL_NUM = 3.
IF (Location = "Los Angeles" & MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" & MTHAssess_PRE_TRACK = "PROFICIENT") AC_MTH_PRE_PERF_LVL_NUM = 4.
IF (Location = "Los Angeles" & MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" & MTHAssess_PRE_TRACK = "ADVANCED") AC_MTH_PRE_PERF_LVL_NUM = 5.
EXECUTE.
IF (Location = "Los Angeles" & MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)" & MTHAssess_POST_TRACK = "FAR BELOW BASIC") AC_MTH_POST_PERF_LVL_NUM = 1.
IF (Location = "Los Angeles" & MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)" & MTHAssess_POST_TRACK = "BELOW BASIC") AC_MTH_POST_PERF_LVL_NUM = 2.
IF (Location = "Los Angeles" & MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)" & MTHAssess_POST_TRACK = "BASIC") AC_MTH_POST_PERF_LVL_NUM = 3.
IF (Location = "Los Angeles" & MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)" & MTHAssess_POST_TRACK = "PROFICIENT") AC_MTH_POST_PERF_LVL_NUM = 4.
IF (Location = "Los Angeles" & MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)" & MTHAssess_POST_TRACK = "ADVANCED") AC_MTH_POST_PERF_LVL_NUM = 5.
EXECUTE.
IF (Location = "Los Angeles" & (MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" | MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)")) AC_MTH_PERF_LVL_GOAL = 1.
EXECUTE.
***** LOS ANGELES: ATT.
***** LOS ANGELES: BEH.

********************************************************************************
***** MIAMI.
*AC=IOG
*check math/lit
iready
att/beh
********************************************************************************

***** MIAMI: LIT.
* FAIR (100 point increase in ability score).
IF (Location = "Miami" & (LITAssess_PRE_DESC = "FAIR (Florida Assessments for Instruction in Reading)" |
LITAssess_POST_DESC = "FAIR (Florida Assessments for Instruction in Reading)")) AC_LIT_SCORE_GOAL = 100.
EXECUTE.
***** MIAMI: MTH.
***** MIAMI: ATT.
***** MIAMI: BEH.

********************************************************************************
***** MILWAUKEE.
*IOG=AC
*(check lit/math)
ATT/BEH
********************************************************************************
***** MILWAUKEE: LIT.
IF (Location = "Milwaukee" & (LITAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
LITAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_LIT_SCORE_GOAL = 1.
EXECUTE.
***** MILWAUKEE: MTH.
IF (Location = "Milwaukee" & (MTHAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
MTHAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_MTH_SCORE_GOAL = 1.
EXECUTE.
***** MILWAUKEE: ATT.
***** MILWAUKEE: BEH.

********************************************************************************
***** NEW HAMPSHIRE.
*AC = IOG
*check lit/math
********************************************************************************

***** NEW HAMPSHIRE: LIT.
***** F & P.
IF (Location = "New Hampshire" & (LITAssess_PRE_DESC = "Fountas and Pinnell" | LITAssess_POST_DESC = "Fountas and Pinnell")) AC_LIT_SCORE_GOAL = 2.
EXECUTE.
***** MAP (Meet or exceed expected growth target).
IF (Location = "New Hampshire" & (LITAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
LITAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_LIT_SCORE_GOAL = MAPELAPerfGoal.
EXECUTE.
***** NEW HAMPSHIRE: MTH.
***** MAP (Meet or exceed expected growth target).
IF (Location = "New Hampshire" & (MTHAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
MTHAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_MTH_SCORE_GOAL = MAPMTHPerfGoal.
EXECUTE.
***** NEW HAMPSHIRE: ATT.
***** NEW HAMPSHIRE: BEH.

********************************************************************************
***** NEW ORLEANS.
*AC=IOG
To DO:
Beh/Att
check math/lit assess
********************************************************************************

***** NEW ORLEANS: LIT.
* MAP (Improve by at least 1 point).
IF (Location = "New Orleans" & (LITAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
LITAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_LIT_SCORE_GOAL = 1.
EXECUTE.
***** NEW ORLEANS: MTH.
* MAP (Improve by at least 1 point). 
IF (Location = "New Orleans" & (MTHAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
MTHAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_MTH_SCORE_GOAL = 1.
EXECUTE.
***** NEW ORLEANS: ATT.
***** NEW ORLEANS: BEH.

********************************************************************************
***** NEW YORK.
*IOG=AC
ATT/BEH
*Check math/lit
ELA: dra, f&p, mclass, mosl, scantron, sri, teachers college
Math: CAIU, envision, mosl, scantron, 
********************************************************************************

***** NEW YORK: LIT.
*****     DRP (move up one or more performance leves).
IF (Location = "New York" & (LITAssess_PRE_DESC = "Degrees of Reading Power (DRP)" |
   LITAssess_POST_DESC = "Degrees of Reading Power (DRP)")) AC_LIT_PERF_LVL_GOAL = 1.
EXECUTE.
*****     QRI-5 (minimum one instructional level increase).
IF (Location = "New York" & (LITAssess_PRE_DESC = "QRI-5" | LITAssess_POST_DESC = "QRI-5")) AC_LIT_SCORE_GOAL = 1.
EXECUTE.
***** NEW YORK: MTH.
*****     easyCBM (minimum one level increase in easycbm benchmarks).
IF (Location = "New York" & (MTHAssess_PRE_DESC = "easyCBM/easyCBM-2 (Curriculum Based Measurement)" |
MTHAssess_POST_DESC = "easyCBM/easyCBM-2 (Curriculum Based Measurement)")) AC_MTH_PERF_LVL_GOAL = 1.
EXECUTE.
*****     Go Math (minimum one level increase in Go Math benchmarks).
IF (Location = "New York" & MTHAssess_PRE_DESC = "Go Math" & MTHAssess_PRE_TRACK = "OFF TRACK") AC_MTH_PRE_PERF_LVL_NUM = 1.
IF (Location = "New York" & MTHAssess_PRE_DESC = "Go Math" & MTHAssess_PRE_TRACK = "SLIDING") AC_MTH_PRE_PERF_LVL_NUM = 2.
IF (Location = "New York" & MTHAssess_PRE_DESC = "Go Math" & MTHAssess_PRE_TRACK = "ON TRACK") AC_MTH_PRE_PERF_LVL_NUM = 3.
EXECUTE.
IF (Location = "New York" & MTHAssess_POST_DESC = "Go Math" & MTHAssess_POST_TRACK = "OFF TRACK") AC_MTH_POST_PERF_LVL_NUM = 1.
IF (Location = "New York" & MTHAssess_POST_DESC = "Go Math" & MTHAssess_POST_TRACK = "SLIDING") AC_MTH_POST_PERF_LVL_NUM = 2.
IF (Location = "New York" & MTHAssess_POST_DESC = "Go Math" & MTHAssess_POST_TRACK = "ON TRACK") AC_MTH_POST_PERF_LVL_NUM = 3.
EXECUTE.
IF (Location = "New York" & (MTHAssess_PRE_DESC = "Go Math" | MTHAssess_POST_DESC = "Go Math")) AC_MTH_PERF_LVL_GOAL = 1.
EXECUTE.
*****     Net Math (minimum one level increase in Net Math benchmarks).
IF (Location = "New York" & MTHAssess_PRE_DESC = "Net Math" & MTHAssess_PRE_TRACK = "OFF TRACK") AC_MTH_PRE_PERF_LVL_NUM = 1.
IF (Location = "New York" & MTHAssess_PRE_DESC = "Net Math" & MTHAssess_PRE_TRACK = "SLIDING") AC_MTH_PRE_PERF_LVL_NUM = 2.
IF (Location = "New York" & MTHAssess_PRE_DESC = "Net Math" & MTHAssess_PRE_TRACK = "ON TRACK") AC_MTH_PRE_PERF_LVL_NUM = 3.
EXECUTE.
IF (Location = "New York" & MTHAssess_POST_DESC = "Net Math" & MTHAssess_POST_TRACK = "OFF TRACK") AC_MTH_POST_PERF_LVL_NUM = 1.
IF (Location = "New York" & MTHAssess_POST_DESC = "Net Math" & MTHAssess_POST_TRACK = "SLIDING") AC_MTH_POST_PERF_LVL_NUM = 2.
IF (Location = "New York" & MTHAssess_POST_DESC = "Net Math" & MTHAssess_POST_TRACK = "ON TRACK") AC_MTH_POST_PERF_LVL_NUM = 3.
EXECUTE.
IF (Location = "New York" & (MTHAssess_PRE_DESC = "Net Math" | MTHAssess_POST_DESC = "Net Math")) AC_MTH_PERF_LVL_GOAL = 1.
EXECUTE.
***** NEW YORK: ATT.
***** NEW YORK: BEH.


********************************************************************************
***** ORLANDO.
*AC=IOG
*ATT/BEH
check lit/math assess
********************************************************************************

***** ORLANDO: LIT.
*****     Benchmark (one point).
IF (Location = "Orlando" & (LITAssess_PRE_DESC = "Orange County Public School Reading Benchmark Assessment" |
   LITAssess_POST_DESC = "Orange County Public School Reading Benchmark Assessment")) AC_LIT_SCORE_GOAL = 1.
EXECUTE.
***** ORLANDO: MTH.
*****     Benchmark (one point).
IF (Location = "Orlando" & (MTHAssess_PRE_DESC = "Orange County Public School Math Benchmark Assessment" |
   MTHAssess_POST_DESC = "Orange County Public School Math Benchmark Assessment")) AC_MTH_SCORE_GOAL = 1.
EXECUTE.
*****     Algebra 1 EOCs (1 point).
IF (Location = "Orlando" & (MTHAssess_PRE_DESC = "Orlando-Evans-Algebra Assessment" |
MTHAssess_POST_DESC = "Orlando-Evans-Algebra Assessment")) AC_MTH_SCORE_GOAL=1.
IF (Location = "Orlando" & (MTHAssess_PRE_DESC = "Orlando-Jones-Algebra Assessment" |
MTHAssess_POST_DESC = "Orlando-Jones-Algebra Assessment")) AC_MTH_SCORE_GOAL=1.
IF (Location = "Orlando" & (MTHAssess_PRE_DESC = "Orlando-Oak Ridge-Algebra Assessment" |
MTHAssess_POST_DESC = "Orlando-Oak Ridge-Algebra Assessment")) AC_MTH_SCORE_GOAL=1.
EXECUTE.
***** ORLANDO: ATT.
***** ORLANDO: BEH.

********************************************************************************
***** PHILADELPHIA.
*AC=IOG
check lit/math assess
AIMSWeb (one year of growth? growth targets?)
att/beh
********************************************************************************

***** PHILADELPHIA: LIT.
***** PHILADELPHIA: MTH.
***** PHILADELPHIA: ATT.
***** PHILADELPHIA: BEH.

********************************************************************************
***** PROVIDENCE.
*IOG
check lit/math
att/beh
********************************************************************************

***** PROVIDENCE: LIT.
*****     DIBELS ORF (20 point increase).
IF (Location = "Rhode Island" & (LITAssess_PRE_DESC = "DIBELS - Oral Reading Fluency (ORF or ORF-WRC/words read correctly)" |
LITAssess_POST_DESC = "DIBELS - Oral Reading Fluency (ORF or ORF-WRC/words read correctly)")) AC_LIT_SCORE_GOAL = 20.
EXECUTE.
*****     STAR Reading (40 point increase).
IF (Location = "Rhode Island" & (LITAssess_PRE_DESC = "STAR Reading" | LITAssess_POST_DESC = "STAR Reading")) AC_LIT_SCORE_GOAL = 40.
EXECUTE.
***** PROVIDENCE: MTH.
*****   STAR MATH (40 point increase).
IF (Location = "Rhode Island" & (MTHAssess_PRE_DESC = "STAR Math" | MTHAssess_POST_DESC = "STAR Math")) AC_MTH_SCORE_GOAL = 40.
EXECUTE.
***** PROVIDENCE: ATT.
***** PROVIDENCE: BEH.

********************************************************************************
***** SACRAMENTO.
*AC=IOG
BEH/ATT
*check math/lit
********************************************************************************

***** SACRAMENTO: LIT.
*****     DIBELS (expected growth = improve one proficiency band).
IF (Location = "Sacramento" & LITAssess_PRE_DESC = "DIBELS - Composite (DIBELS Next 7th edition only)" & 
LITAssess_PRE_TRACK = "OFF TRACK") AC_LIT_PRE_PERF_LVL_NUM=1.
IF (Location = "Sacramento" & LITAssess_PRE_DESC = "DIBELS - Composite (DIBELS Next 7th edition only)" & 
LITAssess_PRE_TRACK = "SLIDING") AC_LIT_PRE_PERF_LVL_NUM=2.
IF (Location = "Sacramento" & LITAssess_PRE_DESC = "DIBELS - Composite (DIBELS Next 7th edition only)" & 
LITAssess_PRE_TRACK = "ON TRACK") AC_LIT_PRE_PERF_LVL_NUM=3.
EXECUTE.
IF (Location = "Sacramento" & LITAssess_POST_DESC = "DIBELS - Composite (DIBELS Next 7th edition only)" & 
LITAssess_POST_TRACK = "OFF TRACK") AC_LIT_POST_PERF_LVL_NUM=1.
IF (Location = "Sacramento" & LITAssess_POST_DESC = "DIBELS - Composite (DIBELS Next 7th edition only)" & 
LITAssess_POST_TRACK = "SLIDING") AC_LIT_POST_PERF_LVL_NUM=2.
IF (Location = "Sacramento" & LITAssess_POST_DESC = "DIBELS - Composite (DIBELS Next 7th edition only)" & 
LITAssess_POST_TRACK = "ON TRACK") AC_LIT_POST_PERF_LVL_NUM=3.
EXECUTE.
IF (Location = "Sacramento" & (LITAssess_PRE_DESC = "DIBELS - Composite (DIBELS Next 7th edition only)" | 
LITAssess_POST_DESC = "DIBELS - Composite (DIBELS Next 7th edition only)")) AC_LIT_PERF_LVL_GOAL = 1.
EXECUTE.

IF (Location = "Sacramento" & LITAssess_PRE_DESC = "DIBELS - Daze (DIBELS Next 7th edition only)" & 
LITAssess_PRE_TRACK = "OFF TRACK") AC_LIT_PRE_PERF_LVL_NUM=1.
IF (Location = "Sacramento" & LITAssess_PRE_DESC = "DIBELS - Daze (DIBELS Next 7th edition only)" & 
LITAssess_PRE_TRACK = "SLIDING") AC_LIT_PRE_PERF_LVL_NUM=2.
IF (Location = "Sacramento" & LITAssess_PRE_DESC = "DIBELS - Daze (DIBELS Next 7th edition only)" & 
LITAssess_PRE_TRACK = "ON TRACK") AC_LIT_PRE_PERF_LVL_NUM=3.
EXECUTE.
IF (Location = "Sacramento" & LITAssess_POST_DESC = "DIBELS - Daze (DIBELS Next 7th edition only)" & 
LITAssess_POST_TRACK = "OFF TRACK") AC_LIT_POST_PERF_LVL_NUM=1.
IF (Location = "Sacramento" & LITAssess_POST_DESC = "DIBELS - Daze (DIBELS Next 7th edition only)" & 
LITAssess_POST_TRACK = "SLIDING") AC_LIT_POST_PERF_LVL_NUM=2.
IF (Location = "Sacramento" & LITAssess_POST_DESC = "DIBELS - Daze (DIBELS Next 7th edition only)" & 
LITAssess_POST_TRACK = "ON TRACK") AC_LIT_POST_PERF_LVL_NUM=3.
EXECUTE.
IF (Location = "Sacramento" & (LITAssess_PRE_DESC = "DIBELS - Daze (DIBELS Next 7th edition only)" | 
LITAssess_POST_DESC = "DIBELS - Daze (DIBELS Next 7th edition only)")) AC_LIT_PERF_LVL_GOAL = 1.
EXECUTE.
*****     iready (15 points).
IF (Location = "Sacramento" & (LITAssess_PRE_DESC = "iReady" | LITAssess_POST_DESC = "iReady")) AC_LIT_SCORE_GOAL=15.
EXECUTE.
*****     SRI.
IF (Location = "Sacramento" & GRADE_ID_RECODE = 3 & (LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" | 
LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)")) AC_LIT_SCORE_GOAL= 160. 
IF (Location = "Sacramento" & GRADE_ID_RECODE = 4 & (LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" | 
LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)")) AC_LIT_SCORE_GOAL= 131.
 IF (Location = "Sacramento" & GRADE_ID_RECODE = 5 & (LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" | 
LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)")) AC_LIT_SCORE_GOAL= 110. 
IF (Location = "Sacramento" & GRADE_ID_RECODE = 6 & (LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" | 
LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)")) AC_LIT_SCORE_GOAL= 65. 
IF (Location = "Sacramento" & GRADE_ID_RECODE = 7 & (LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" | 
LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)")) AC_LIT_SCORE_GOAL= 57. 
IF (Location = "Sacramento" & GRADE_ID_RECODE = 8 & (LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" | 
LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)")) AC_LIT_SCORE_GOAL= 58. 
IF (Location = "Sacramento" & GRADE_ID_RECODE = 9 & (LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" | 
LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)")) AC_LIT_SCORE_GOAL= 45. 
EXECUTE.
*****     Wonders.
IF (Location = "Sacramento" & LITAssess_PRE_DESC = "Wonders Benchmark" & LITAssess_PRE_TRACK = "FAR BELOW BASIC") AC_LIT_PRE_PERF_LVL_NUM = 1.
IF (Location = "Sacramento" & LITAssess_PRE_DESC = "Wonders Benchmark" & LITAssess_PRE_TRACK = "BELOW BASIC") AC_LIT_PRE_PERF_LVL_NUM = 2.
IF (Location = "Sacramento" & LITAssess_PRE_DESC = "Wonders Benchmark" & LITAssess_PRE_TRACK = "BASIC") AC_LIT_PRE_PERF_LVL_NUM = 3.
IF (Location = "Sacramento" & LITAssess_PRE_DESC = "Wonders Benchmark" & LITAssess_PRE_TRACK = "PROFICIENT") AC_LIT_PRE_PERF_LVL_NUM = 4.
IF (Location = "Sacramento" & LITAssess_PRE_DESC = "Wonders Benchmark" & LITAssess_PRE_TRACK = "ADVANCED") AC_LIT_PRE_PERF_LVL_NUM = 5.
EXECUTE.
IF (Location = "Sacramento" & LITAssess_POST_DESC = "Wonders Benchmark" & LITAssess_POST_TRACK = "FAR BELOW BASIC") AC_LIT_POST_PERF_LVL_NUM = 1.
IF (Location = "Sacramento" & LITAssess_POST_DESC = "Wonders Benchmark" & LITAssess_POST_TRACK = "BELOW BASIC") AC_LIT_POST_PERF_LVL_NUM = 2.
IF (Location = "Sacramento" & LITAssess_POST_DESC = "Wonders Benchmark" & LITAssess_POST_TRACK = "BASIC") AC_LIT_POST_PERF_LVL_NUM = 3.
IF (Location = "Sacramento" & LITAssess_POST_DESC = "Wonders Benchmark" & LITAssess_POST_TRACK = "PROFICIENT") AC_LIT_POST_PERF_LVL_NUM = 4.
IF (Location = "Sacramento" & LITAssess_POST_DESC = "Wonders Benchmark" & LITAssess_POST_TRACK = "ADVANCED") AC_LIT_POST_PERF_LVL_NUM = 5.
EXECUTE.
IF (Location = "Sacramento" & (LITAssess_PRE_DESC = "Wonders Benchmark" | LITAssess_POST_DESC = "Wonders Benchmark")) AC_LIT_PERF_LVL_GOAL = 1.
EXECUTE.
***** SACRAMENTO: MTH.
*****     Amplify (one proficency band).
IF (Location = "Sacramento" & MTHAssess_PRE_DESC = "Amplify" & MTHAssess_PRE_TRACK = "FAR BELOW BASIC") AC_MTH_PRE_PERF_LVL_NUM=1.
IF (Location = "Sacramento" & MTHAssess_PRE_DESC = "Amplify" & MTHAssess_PRE_TRACK = "BELOW BASIC") AC_MTH_PRE_PERF_LVL_NUM=2.
IF (Location = "Sacramento" & MTHAssess_PRE_DESC = "Amplify" & MTHAssess_PRE_TRACK = "BASIC") AC_MTH_PRE_PERF_LVL_NUM=3.
IF (Location = "Sacramento" & MTHAssess_PRE_DESC = "Amplify" & MTHAssess_PRE_TRACK = "PROFICIENT") AC_MTH_PRE_PERF_LVL_NUM=4.
IF (Location = "Sacramento" & MTHAssess_PRE_DESC = "Amplify" & MTHAssess_PRE_TRACK = "ADVANCED") AC_MTH_PRE_PERF_LVL_NUM=5.
EXECUTE.
IF (Location = "Sacramento" & MTHAssess_POST_DESC = "Amplify" & MTHAssess_PRE_TRACK = "FAR BELOW BASIC") AC_MTH_POST_PERF_LVL_NUM=1.
IF (Location = "Sacramento" & MTHAssess_POST_DESC = "Amplify" & MTHAssess_PRE_TRACK = "BELOW BASIC") AC_MTH_POST_PERF_LVL_NUM=2.
IF (Location = "Sacramento" & MTHAssess_POST_DESC = "Amplify" & MTHAssess_PRE_TRACK = "BASIC") AC_MTH_POST_PERF_LVL_NUM=3.
IF (Location = "Sacramento" & MTHAssess_POST_DESC = "Amplify" & MTHAssess_PRE_TRACK = "PROFICIENT") AC_MTH_POST_PERF_LVL_NUM=4.
IF (Location = "Sacramento" & MTHAssess_POST_DESC = "Amplify" & MTHAssess_PRE_TRACK = "ADVANCED") AC_MTH_POST_PERF_LVL_NUM=5.
EXECUTE.
IF (Location = "Sacramento" & (MTHAssess_PRE_DESC = "Amplify" | MTHAssess_POST_DESC = "Amplify")) AC_MTH_PERF_LVL_GOAL = 1.
EXECUTE.
*****     iready (13 points).
IF (Location = "Sacramento" & (MTHAssess_PRE_DESC = "iReady" | MTHAssess_POST_DESC = "iReady")) AC_MTH_SCORE_GOAL=15.
EXECUTE.
*****     SMI.
IF (Location = "Sacramento" & GRADE_ID_RECODE = 3 & (MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" | 
MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)")) AC_MTH_SCORE_GOAL= 120. 
IF (Location = "Sacramento" & GRADE_ID_RECODE = 4 & (MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" | 
MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)")) AC_MTH_SCORE_GOAL= 90.
 IF (Location = "Sacramento" & GRADE_ID_RECODE = 5 & (MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" | 
MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)")) AC_MTH_SCORE_GOAL= 60. 
IF (Location = "Sacramento" & GRADE_ID_RECODE = 6 & (MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" | 
MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)")) AC_MTH_SCORE_GOAL= 50. 
IF (Location = "Sacramento" & GRADE_ID_RECODE = 7 & (MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" | 
MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)")) AC_MTH_SCORE_GOAL= 40. 
IF (Location = "Sacramento" & GRADE_ID_RECODE = 8 & (MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" | 
MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)")) AC_MTH_SCORE_GOAL= 40. 
EXECUTE.
***** SACRAMENTO: ATT.
***** SACRAMENTO: BEH.

********************************************************************************
***** SAN ANTONIO.
*AC=IOG
beh/att
check math/lit assess
istation goal? 
easycbm name? 
aimsweb name? 
********************************************************************************

***** SAN ANTONIO: LIT.
*****     SRI (improve by at least 1 point).
IF (Location = "San Antonio" & (LITAssess_PRE_DESC = "Scholastic Reading Inventory (SRI)" | LITAssess_POST_DESC = "Scholastic Reading Inventory (SRI)")) AC_LIT_SCORE_GOAL =1. 
EXECUTE. 
***** SAN ANTONIO: MTH (improve by at least 1 point).
IF (Location = "San Antonio" & (MTHAssess_PRE_DESC = "Scholastic Math Inventory (SMI)" | MTHAssess_POST_DESC = "Scholastic Math Inventory (SMI)")) AC_MTH_SCORE_GOAL =1. 
EXECUTE. 
***** SAN ANTONIO: ATT.
***** SAN ANTONIO: BEH.

********************************************************************************
***** SAN JOSE.
*check math/lit (dibels, aimsweb)
********************************************************************************

***** SAN JOSE: LIT.
***** SAN JOSE: MTH.
***** SAN JOSE: ATT.
***** SAN JOSE: BEH.

********************************************************************************
***** SEATTLE.
IOG <> AC
beh/att
check lit/math assess
********************************************************************************

***** SEATTLE: LIT.
***** MAP (improve one rauch unit).
IF (Location = "Seattle" & (LITAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
LITAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_LIT_SCORE_GOAL = 1.
EXECUTE.
***** SEATTLE: MTH.
***** MAP (improve one rauch unit).
IF (Location = "Seattle" & (MTHAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
MTHAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_MTH_SCORE_GOAL = 1.
EXECUTE.
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
*check district unit, dibels
********************************************************************************

***** WASHINGTON, DC: LIT.
*****     ANet (Improvement of raw score by at least 1 point).
IF (Location = "Washington, DC" & (LITAssess_PRE_DESC = "Achievement Network (ANet)" |
LITAssess_POST_DESC = "Achievement Network (ANet)")) AC_LIT_SCORE_GOAL = .01.
EXECUTE.
*****     MAP (improvement of raw score by at least 1 point).
IF (Location = "Washington, DC" & (LITAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
LITAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_LIT_SCORE_GOAL = 1.
EXECUTE.

*****     TRC (improvement of raw score by at least 1 point).
IF (Location = "Washington, DC" & (LITAssess_PRE_DESC = "TRC (Text Reading and Comprehension)" |
LITAssess_POST_DESC = "TRC (Text Reading and Comprehension)")) AC_LIT_SCORE_GOAL = 1.
EXECUTE.
***** WASHINGTON, DC: MTH.
*****     MAP (improvement of raw score by at least 1 point).
IF (Location = "Washington, DC" & (MTHAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
MTHAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) AC_MTH_SCORE_GOAL = 1.
EXECUTE.
*****     ANet.
IF (Location = "Washington, DC" & (MTHAssess_PRE_DESC = "Achievement Network (ANet)" |
MTHAssess_POST_DESC = "Achievement Network (ANet)")) AC_MTH_SCORE_GOAL = .01.
EXECUTE.
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
*****     CLEVELAND.
***** MAP (Expected growth target).
IF (Location = "Cleveland" & (LITAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
LITAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) OG_LIT_SCORE_GOAL = MAPELAPerfGoal.
IF (Location = "Cleveland" & (MTHAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
MTHAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) OG_MTH_SCORE_GOAL = MAPMTHPerfGoal.
*****     SEATTLE.
IF (Location = "Seattle" & (LITAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
LITAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) OG_LIT_SCORE_GOAL = MAPELAPerfGoal.
IF (Location = "Seattle" & (MTHAssess_PRE_DESC = "MAP (Measures of Academic Progress/NWEA)" |
MTHAssess_POST_DESC = "MAP (Measures of Academic Progress/NWEA)")) OG_MTH_SCORE_GOAL = MAPMTHPerfGoal.
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