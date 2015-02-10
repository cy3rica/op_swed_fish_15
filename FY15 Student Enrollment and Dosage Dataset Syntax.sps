******************************************************************************************************************************************************
***** FY15 Student Enrollment and Dosage Dataset Syntax.
******************************************************************************************************************************************************
******************************************************************************************************************************************************
***** BEFORE RUNNING:
******************************************************************************************************************************************************
******************************************************************************************************************************************************
***** Additional notes?
******************************************************************************************************************************************************

******************************************************************************************************************************************************
***** Pull up and define source data files -- don't forget to make sure all ID variables are identical size/format.
******************************************************************************************************************************************************

***** Pull up student/section enrollment data.
GET DATA /TYPE=XLSX 
  /FILE='Z:\Cross Instrument\FY15\Source Data\Total Student Dosage per IA - Mod - 2015.02.02.xlsx' 
  /SHEET=index 1
  /CELLRANGE=full 
  /READNAMES=on 
  /ASSUMEDSTRWIDTH=32767. 
EXECUTE. 
DATASET NAME StudentEnrollDosage.

***** Pull up school name to ID translation file.
GET DATA /TYPE=XLSX 
  /FILE='Z:\Cross Instrument\FY15\Source Data\cyschoolhouse FY15 Schools 2015.02.02.xlsx' 
  /SHEET=index 1
  /CELLRANGE=full 
  /READNAMES=on 
  /ASSUMEDSTRWIDTH=32767. 
EXECUTE. 
DATASET NAME SchoolIDs.

***** Pull up cyschoolhouse/cychannel school ID translation file.
GET DATA /TYPE=XLSX 
  /FILE='Z:\Cross Instrument\FY15\Source Data\FY15 cyschoolhouse cychannel School ID Translation 2014.11.05.xlsx' 
  /SHEET=index 1
  /CELLRANGE=full 
  /READNAMES=on 
  /ASSUMEDSTRWIDTH=32767. 
EXECUTE. 
DATASET NAME SchoolIDTranslation.

***** Pull up cychannel dataset for DN variable.
GET DATA /TYPE=XLSX 
  /FILE='Z:\Cross Instrument\FY15\Source Data\cychannel FY15 List of Schools 2015.01.30.xlsx' 
  /SHEET=index 1
  /CELLRANGE=full 
  /READNAMES=on 
  /ASSUMEDSTRWIDTH=32767. 
EXECUTE. 
DATASET NAME cychanSchoolInfo.

***** Pull up team-level enrollment and dosage goals.
GET DATA  /TYPE=TXT
  /FILE="Z:\Cross Instrument\FY15\Source Data\FY15 School-Level Quarterly Enrollment and Monthly Dosage Targets 2015-02-03.csv"
  /ENCODING='Locale'
  /DELCASE=LINE
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /IMPORTCASE=ALL
  /VARIABLES= V1 F3.0 cyschSchoolRefID A18 SchoolName A75 SCM F2.0 CM F3.0 SCMCMsW.FLs F3.0 ELA.CMwFL F3.0
ELA.Cycles F4.1 ELA.MinFL F4.0 ELA.MaxFL F4.0 ELA.FinalEnrollGoal F4.0 MTH.CMwFL F3.0 MTH.Cycles F4.1 MTH.MinFL F4.0
MTH.MaxFL F4.0 MTH.FinalEnrollGoal F4.0 ATT.CMwFL F3.0 ATT.Cycles F2.0 ATT.MinFL F3.0 ATT.MaxFL F4.0
ATT.FinalEnrollGoal F4.0 BEH.CMwFL F3.0 BEH.Cycles F2.0 BEH.MinFL F4.0 BEH.MaxFL F4.0 BEH.FinalEnrollGoal F4.0
Q1.ELA.EnrollGoalPerc F5.2 Q1.MTH.EnrollGoalPerc F5.2 Q1.ATT.EnrollGoalPerc F5.2 Q1.BEH.EnrollGoalPerc F5.2
Q2.ELA.EnrollGoalPerc F5.2 Q2.MTH.EnrollGoalPerc F5.2 Q2.ATT.EnrollGoalPerc F5.2 Q2.BEH.EnrollGoalPerc F5.2
Q3.ELA.EnrollGoalPerc F5.2 Q3.MTH.EnrollGoalPerc F5.2 Q3.ATT.EnrollGoalPerc F5.2 Q3.BEH.EnrollGoalPerc F5.2
AUG.ELA.DosageGoal F5.2 SEP.ELA.DosageGoal F5.2 OCT.ELA.DosageGoal F5.2 NOV.ELA.DosageGoal F5.2
DEC.ELA.DosageGoal F5.2 JAN.ELA.DosageGoal F5.2 FEB.ELA.DosageGoal F5.2 MAR.ELA.DosageGoal F5.2
APR.ELA.DosageGoal F5.2 MAY.ELA.DosageGoal F5.2 JUN.ELA.DosageGoal F5.2 AUG.MTH.DosageGoal F5.2
SEP.MTH.DosageGoal F5.2 OCT.MTH.DosageGoal F5.2 NOV.MTH.DosageGoal F5.2 DEC.MTH.DosageGoal F5.2
JAN.MTH.DosageGoal F5.2 FEB.MTH.DosageGoal F5.2 MAR.MTH.DosageGoal F5.2 APR.MTH.DosageGoal F5.2
MAY.MTH.DosageGoal F5.2 JUN.MTH.DosageGoal F5.2 SiteName A20 Q1.ELA.EnrollGoal A7 Q1.MTH.EnrollGoal A7
Q1.ATT.EnrollGoal A7 Q1.BEH.EnrollGoal A7 Q2.ELA.EnrollGoal A7 Q2.MTH.EnrollGoal A7 Q2.ATT.EnrollGoal A7
Q2.BEH.EnrollGoal A7 Q3.ELA.EnrollGoal A7 Q3.MTH.EnrollGoal A7 Q3.ATT.EnrollGoal A7 Q3.BEH.EnrollGoal A7
AUG.ELA.DosageGoal.Minutes A7 SEP.ELA.DosageGoal.Minutes A7 OCT.ELA.DosageGoal.Minutes A7
NOV.ELA.DosageGoal.Minutes A7 DEC.ELA.DosageGoal.Minutes A7 JAN.ELA.DosageGoal.Minutes A7
FEB.ELA.DosageGoal.Minutes A7 MAR.ELA.DosageGoal.Minutes A7 APR.ELA.DosageGoal.Minutes A7
MAY.ELA.DosageGoal.Minutes A7 JUN.ELA.DosageGoal.Minutes A7 AUG.MTH.DosageGoal.Minutes A7
SEP.MTH.DosageGoal.Minutes A7 OCT.MTH.DosageGoal.Minutes A7 NOV.MTH.DosageGoal.Minutes A7
DEC.MTH.DosageGoal.Minutes A7 JAN.MTH.DosageGoal.Minutes A7 FEB.MTH.DosageGoal.Minutes A7
MAR.MTH.DosageGoal.Minutes A7 APR.MTH.DosageGoal.Minutes A7 MAY.MTH.DosageGoal.Minutes A7
JUN.MTH.DosageGoal.Minutes A7.
CACHE.
EXECUTE.
DATASET NAME TeamEnrollDosage.

***** Pull up site-level enrollment and dosage goals.
GET DATA  /TYPE=TXT
  /FILE="Z:\Cross Instrument\FY15\Source Data\FY15 Site-Level Quarterly Enrollment and Monthly Dosage Targets 2015-02-03.csv"
  /ENCODING='Locale'
  /DELCASE=LINE
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /IMPORTCASE=ALL
  /VARIABLES= V1 F2.0 SiteName A14 totSchools F2.0 ELA.FinalEnrollGoal F5.0 MTH.FinalEnrollGoal F5.0
ATT.FinalEnrollGoal F5.0 BEH.FinalEnrollGoal F5.0 Q1.ELA.EnrollGoal F5.0 Q1.MTH.EnrollGoal F5.0 Q1.ATT.EnrollGoal F5.0
Q1.BEH.EnrollGoal F5.0 Q2.ELA.EnrollGoal F5.0 Q2.MTH.EnrollGoal F5.0 Q2.ATT.EnrollGoal F5.0 Q2.BEH.EnrollGoal F5.0
Q3.ELA.EnrollGoal F5.0 Q3.MTH.EnrollGoal F5.0 Q3.ATT.EnrollGoal F5.0 Q3.BEH.EnrollGoal F5.0.
CACHE.
EXECUTE.
DATASET NAME SiteEnrollDosage.

***** Pull up AmeriCorps grant ID translation file.
GET FILE = "Z:\Cross Instrument\FY15\Source Data\FY15 cyschoolhouse AmeriCorps Grant ID Translation 2015.01.15.sav".
DATASET NAME ACGrantIDs.

***** Pull up AmeriCorps grant requirements.
GET FILE = "Z:\Cross Instrument\FY15\Source Data\1. FY15 ACPM Summary for Progress Monitoring 2015.02.03.sav".
DATASET NAME ACGoals.

***** Pull up Student ID translation file.
GET FILE = "Z:\Cross Instrument\FY15\Source Data\dbo_RPT_STUDENT_MAIN 2015.02.08.sav".
DATASET NAME StPerfIDs.

***** Pull up literacy assessment performance data.
GET FILE = "Z:\Cross Instrument\FY15\Source Data\FY15 MY LIT ASSESS subtable 2015.02.08.sav".
DATASET NAME LITAssessPerf.

***** Pull up math assessment performance data.
GET FILE = "Z:\Cross Instrument\FY15\Source Data\FY15 MY MTH ASSESS subtable 2015.02.08.sav".
DATASET NAME MTHAssessPerf.

***** Pull up ELA course grade performance data.
GET FILE = "Z:\Cross Instrument\FY15\Source Data\FY15 MY ELA CG subtable 2015.02.08.sav".
DATASET NAME ELACGPerf.

***** Pull up math course grade performance data.
GET FILE = "Z:\Cross Instrument\FY15\Source Data\FY15 MY MTH CG subtable 2015.02.08.sav".
DATASET NAME MTHCGPerf.

***** Pull up attendance performance data.
GET FILE = "Z:\Cross Instrument\FY15\Source Data\FY15 MY ATT subtable 2015.02.08.sav".
DATASET NAME ATTPerf.

******************************************************************************************************************************************************
***** Activate and prep student enrollment dosage data for merge/aggregation.
******************************************************************************************************************************************************

***** Activate student enrollment/dosage dataset.
DATASET ACTIVATE StudentEnrollDosage.

******************************************************************************************************************************************************
***** For student/section level data.
******************************************************************************************************************************************************
***** Rename variables for ease of analysis.
RENAME VARIABLES (Location = Location) (Program = Program) (StudentStudentName = StudentName) (StudentGrade = StudentGrade)
(LocalStudentID = LocalStudentID) (InSchoolExtendedLearning = InSchELT) (InterventionEnrollmentStartDate = EnrollDate) (EnrollmentEndDate = ExitDate)
(StudentELALiteracy = IALIT)
(StudentMath = IAMTH) (StudentAttendance = IAATT) (StudentBehavior = IABEH) (StudentNumberofIndicatorAreas = IATOT)
(StudentSectionStudentSectionID = StudentSecID) (DosagetoDate = Dosage) (StudentSchoolName = School) (StudentStudentIDAutoNumber = cyStudentID)
(IndicatorArea = IndicatorArea).
***** Delete unnecessary variables.
DELETE VARIABLES IATOT InSchELT Program.
******************************************************************************************************************************************************

***** Reformat student grade level variable so that it is numeric.
RECODE StudentGrade ("PK" = "-1") ("K" = "0") ("UN Ungraded" = "").
ALTER TYPE StudentGrade (F2.0).

******************************************************************************************************************************************************
***** Aggregate file to IndicatorArea level.
******************************************************************************************************************************************************

SORT CASES BY Location (A) School (A) cyStudentID (A) LocalStudentID (A) IndicatorArea (A).

DATASET DECLARE StudentIAData.

AGGREGATE
   /OUTFILE = StudentIAData
   /BREAK = Location (A) School (A) cyStudentID (A) LocalStudentID (A) IndicatorArea (A)
   /StudentName = FIRST(StudentName)
   /TotalDosage = SUM(Dosage)
   /EnrollDate = MIN(EnrollDate)
   /ExitDateLatest = MAX(ExitDate)
   /ExitMissing = NUMISS(ExitDate)
   /StudentGrade = MEAN(StudentGrade)
   /IALIT = MEAN(IALIT)
   /IAMTH = MEAN(IAMTH)
   /IAATT = MEAN(IAATT)
   /IABEH = MEAN(IABEH).

DATASET ACTIVATE StudentIAData.

***** Calculate latest exit date (this calculation needs to be done in case a student has been exited from one section, but may still be enrolled in another section).
***** Note (7/21/14): for students missing exit dates, we're assuming an exit date of 7/1 (date of system close).
DO IF (ExitMissing > 0).
COMPUTE ExitDate = XDATE.DATE($TIME).
ELSE IF (ExitMissing = 0).
COMPUTE ExitDate = ExitDateLatest.
END IF.
EXECUTE.

ALTER TYPE ExitDate (ADATE10).

***** Abbreviate indicator areas.
DO IF (IndicatorArea = "Non-specific IA").
COMPUTE IndicatorArea = "OTH".
ELSE IF (IndicatorArea = "ELA/Literacy").
COMPUTE IndicatorArea = "LIT".
ELSE IF (IndicatorArea = "Math").
COMPUTE IndicatorArea = "MTH".
ELSE IF (IndicatorArea = "Attendance").
COMPUTE IndicatorArea = "ATT".
ELSE IF (IndicatorArea = "Behavior").
COMPUTE IndicatorArea = "BEH".
END IF.
EXECUTE.

***** No longer need original student enrollment and dosage dataset.
DATASET CLOSE StudentEnrollDosage.

******************************************************************************************************************************************************
***** Restructure data file so that each row is a unique student.
******************************************************************************************************************************************************

SORT CASES BY cyStudentID (A) IndicatorArea (A).
EXECUTE.

CASESTOVARS
 /ID=cyStudentID
  /FIXED = Location School LocalStudentID StudentName StudentGrade IALIT IAMTH IAATT IABEH
 /AUTOFIX = NO
 /INDEX= IndicatorArea
  /DROP = ExitDateLatest ExitMissing.

DATASET NAME FINALDATASET.

******************************************************************************************************************************************************
***** Calculate Days Enrolled variable.
******************************************************************************************************************************************************

DATASET ACTIVATE FINALDATASET.

***** Variable labels for existing variables.
VARIABLE LABELS IALIT "Indicator Area Assignment: ELA/Literacy"
   IAMTH "Indicator Area Assignment: Math"
   IAATT "Indicator Area Assignment: Attendance"
   IABEH "Indicator Area Assignment: Behavior"
   StudentGrade "Student Grade Level".
VALUE LABELS IALIT 0 "ELA/Literacy: Students Without an IA-Assignment"
   1 "ELA/Literacy: Students With an IA-Assignment".
VALUE LABELS IAMTH 0 "Math: Students Without an IA-Assignment"
   1 "Math: Students With an IA-Assignment".
VALUE LABELS IAATT 0 "Attendance: Students Without an IA-Assignment"
   1 "Attendance: Students With an IA-Assignment".
VALUE LABELS IABEH 0 "Behavior: Students Without an IA-Assignment"
   1 "Behavior: Students With an IA-Assignment".
EXECUTE.

***** Days Enrolled.
COMPUTE LITEnroll = DATEDIFF(ExitDate.LIT, EnrollDate.LIT, "days").
COMPUTE ATTEnroll = DATEDIFF(ExitDate.ATT, EnrollDate.ATT, "days").
COMPUTE MTHEnroll = DATEDIFF(ExitDate.MTH, EnrollDate.MTH, "days").
COMPUTE BEHEnroll = DATEDIFF(ExitDate.BEH, EnrollDate.BEH, "days").
COMPUTE OTHEnroll = DATEDIFF(ExitDate.OTH, EnrollDate.OTH, "days").

VARIABLE LABELS LITEnroll "Days enrolled in ELA/Literacy"
   ATTEnroll "Days enrolled in Attendance"
   MTHEnroll "Days enrolled in Math"
   BEHEnroll "Days enrolled in Behavior"
   OTHEnroll "Days enrolled in other CY programming (e.g. After School Heroes)".
EXECUTE.

******************************************************************************************************************************************************
***** Merge in cyschoolhouse school IDs.
******************************************************************************************************************************************************

***** Prep school ID file for merge.
DATASET ACTIVATE SchoolIDs.
RENAME VARIABLES (AccountName = School) (LegacyID = cyschSchoolRefID) (Location = Location).
DELETE VARIABLES AccountID ReferenceId.
SORT CASES BY Location (A) School (A).
EXECUTE.

***** Prep student enrollment/dosage file for merge.
DATASET ACTIVATE FINALDATASET.
SORT CASES BY Location (A) School (A).
EXECUTE.

MATCH FILES /FILE = FINALDATASET
   /TABLE = SchoolIDs
   /BY Location School.
DATASET NAME FINALDATASET.
EXECUTE.

***** Create a table for the output file in case we need to check and see if all school IDs merged okay.
FREQUENCIES VARIABLES = cyschSchoolRefID.

***** No longer need school ID data file.
DATASET CLOSE SchoolIDs.

******************************************************************************************************************************************************
***** Merge in cychannel school IDs.
******************************************************************************************************************************************************

***** Prep school ID file for merge.
DATASET ACTIVATE SchoolIDTranslation.
RENAME VARIABLES (Account = cychanSchoolID).
DELETE VARIABLES Location School AccountName CityYearServiceLocation.
SORT CASES BY cyschSchoolRefID (A).
EXECUTE.

***** Prep student enrollment/dosage file for merge.
DATASET ACTIVATE FINALDATASET.
SORT CASES BY cyschSchoolRefID (A).
EXECUTE.

MATCH FILES /FILE = FINALDATASET
   /TABLE = SchoolIDTranslation
   /BY cyschSchoolRefID.
DATASET NAME FINALDATASET.
EXECUTE.

***** No longer need school ID translation file.
DATASET CLOSE SchoolIDTranslation.

******************************************************************************************************************************************************
***** Merge in cychannel school info (mostly for Diplomas Now school variable).
******************************************************************************************************************************************************

***** Prep cychannel school IDs for merge.
DATASET ACTIVATE cychanSchoolInfo.
DELETE VARIABLES AccountID AccountName TotalPastPartnerships i3SchoolPartnership BillingStreet BillingCity BillingStateProvince BillingZipPostalCode
CityYearServiceLocation.
RENAME VARIABLES (Account = cychanSchoolID) (DiplomasNowSchoolPartnership = DNSchool).
VARIABLE LABELS DNSchool "Diplomas Now Schools".
VALUE LABELS DNSchool 0 "Not a Diplomas Now School"
   1 "Diplomas Now School".
SORT CASES BY cychanSchoolID (A).
EXECUTE.

***** Prep student enrollment/dosage file for merge.
DATASET ACTIVATE FINALDATASET.
SORT CASES BY cychanSchoolID (A).
EXECUTE.

MATCH FILES /FILE = FINALDATASET
   /TABLE = cychanSchoolInfo
   /BY cychanSchoolID.
DATASET NAME FINALDATASET.
EXECUTE.

***** Needed this syntax in FY14 -- hopefully won't need in FY15.
***** Create additional DN variable to account for variable DN status within a DN school. Only use this for filtering/calculation purposes. Use original variable to aggregate.
*COMPUTE DN_SCHOOL_BY_GRADE = DNSchool.
*EXECUTE.
*IF (cyschSchoolRefID = "001U0000008x3NoIAI" & StudentGrade < 9) DN_SCHOOL_BY_GRADE = 0 /*CBS-Linden STEM*/ .
*IF (cyschSchoolRefID = "001U000000O3C8PIAV" & StudentGrade < 9) DN_SCHOOL_BY_GRADE = 0 /*CBS-South HS*/ .
*IF (cyschSchoolRefID = "001U000000EJ6m5IAD" & StudentGrade > 9) DN_SCHOOL_BY_GRADE = 0 /*JAX-Andrew Jackson High School*/ .
*IF (cyschSchoolRefID = "001U000000YueJpIAJ") DN_SCHOOL_BY_GRADE = 0 /*TUL-Clinton MS*/ .
*EXECUTE.
*VARIABLE LABELS DN_SCHOOL_BY_GRADE "Diplomas Now Students (accounting for variation in school)".
*VALUE LABELS DN_SCHOOL_BY_GRADE 0 "Not a Diplomas Now Student"
   1 "Diplomas Now Student".

***** No longer need cychannel school info file.
DATASET CLOSE cychanSchoolInfo.

******************************************************************************************************************************************************
***** Merge in team-level goals.
******************************************************************************************************************************************************

***** Prep team-level enrollment and dosage goals for merge.
DATASET ACTIVATE TeamEnrollDosage.
RENAME VARIABLES (ELA.FinalEnrollGoal = TEAM.ELA.FinalEnrollGoal) (MTH.FinalEnrollGoal = TEAM.MTH.FinalEnrollGoal)
(ATT.FinalEnrollGoal = TEAM.ATT.FinalEnrollGoal) (BEH.FinalEnrollGoal = TEAM.BEH.FinalEnrollGoal)
(Q1.ELA.EnrollGoalPerc = TEAM.Q1.ELA.EnrollGoalPerc) (Q1.MTH.EnrollGoalPerc = TEAM.Q1.MTH.EnrollGoalPerc)
(Q1.ATT.EnrollGoalPerc = TEAM.Q1.ATT.EnrollGoalPerc) (Q1.BEH.EnrollGoalPerc = TEAM.Q1.BEH.EnrollGoalPerc)
(Q2.ELA.EnrollGoalPerc = TEAM.Q2.ELA.EnrollGoalPerc) (Q2.MTH.EnrollGoalPerc = TEAM.Q2.MTH.EnrollGoalPerc)
(Q2.ATT.EnrollGoalPerc = TEAM.Q2.ATT.EnrollGoalPerc) (Q2.BEH.EnrollGoalPerc = TEAM.Q2.BEH.EnrollGoalPerc)
(Q3.ELA.EnrollGoalPerc = TEAM.Q3.ELA.EnrollGoalPerc) (Q3.MTH.EnrollGoalPerc = TEAM.Q3.MTH.EnrollGoalPerc)
(Q3.ATT.EnrollGoalPerc = TEAM.Q3.ATT.EnrollGoalPerc) (Q3.BEH.EnrollGoalPerc = TEAM.Q3.BEH.EnrollGoalPerc)
(Q1.ELA.EnrollGoal = TEAM.Q1.ELA.EnrollGoal) (Q1.MTH.EnrollGoal = TEAM.Q1.MTH.EnrollGoal)
(Q1.ATT.EnrollGoal = TEAM.Q1.ATT.EnrollGoal) (Q1.BEH.EnrollGoal = TEAM.Q1.BEH.EnrollGoal)
(Q2.ELA.EnrollGoal = TEAM.Q2.ELA.EnrollGoal) (Q2.MTH.EnrollGoal = TEAM.Q2.MTH.EnrollGoal)
(Q2.ATT.EnrollGoal = TEAM.Q2.ATT.EnrollGoal) (Q2.BEH.EnrollGoal = TEAM.Q2.BEH.EnrollGoal)
(Q3.ELA.EnrollGoal = TEAM.Q3.ELA.EnrollGoal) (Q3.MTH.EnrollGoal = TEAM.Q3.MTH.EnrollGoal)
(Q3.ATT.EnrollGoal = TEAM.Q3.ATT.EnrollGoal) (Q3.BEH.EnrollGoal = TEAM.Q3.BEH.EnrollGoal).
DELETE VARIABLES V1 SchoolName SCM CM SCMCMsW.FLs ELA.CMwFL ELA.Cycles ELA.MinFL ELA.MaxFL MTH.CMwFL
MTH.Cycles MTH.MinFL MTH.MaxFL ATT.CMwFL ATT.Cycles ATT.MinFL ATT.MaxFL BEH.CMwFL BEH.Cycles BEH.MinFL
BEH.MaxFL SiteName.

***** Convert dosage variables to numeric.
ALTER TYPE TEAM.Q1.ELA.EnrollGoal TEAM.Q1.MTH.EnrollGoal TEAM.Q1.ATT.EnrollGoal TEAM.Q1.BEH.EnrollGoal
TEAM.Q2.ELA.EnrollGoal TEAM.Q2.MTH.EnrollGoal TEAM.Q2.ATT.EnrollGoal TEAM.Q2.BEH.EnrollGoal
TEAM.Q3.ELA.EnrollGoal TEAM.Q3.MTH.EnrollGoal TEAM.Q3.ATT.EnrollGoal TEAM.Q3.BEH.EnrollGoal
AUG.ELA.DosageGoal.Minutes SEP.ELA.DosageGoal.Minutes OCT.ELA.DosageGoal.Minutes NOV.ELA.DosageGoal.Minutes
DEC.ELA.DosageGoal.Minutes JAN.ELA.DosageGoal.Minutes FEB.ELA.DosageGoal.Minutes MAR.ELA.DosageGoal.Minutes
APR.ELA.DosageGoal.Minutes MAY.ELA.DosageGoal.Minutes JUN.ELA.DosageGoal.Minutes AUG.MTH.DosageGoal.Minutes
SEP.MTH.DosageGoal.Minutes OCT.MTH.DosageGoal.Minutes NOV.MTH.DosageGoal.Minutes DEC.MTH.DosageGoal.Minutes
JAN.MTH.DosageGoal.Minutes FEB.MTH.DosageGoal.Minutes MAR.MTH.DosageGoal.Minutes APR.MTH.DosageGoal.Minutes
MAY.MTH.DosageGoal.Minutes JUN.MTH.DosageGoal.Minutes (F40.0).

***** Add variable labels to existing variables.
VARIABLE LABELS TEAM.ELA.FinalEnrollGoal "ENROLL GOAL (EOY)\nTeam-Level FY15 ELA/Literacy Focus List"
   TEAM.MTH.FinalEnrollGoal "ENROLL GOAL (EOY)\nTeam-Level FY15 Math Focus List"
   TEAM.ATT.FinalEnrollGoal "ENROLL GOAL (EOY)\nTeam-Level FY15 Attendance Focus List"
   TEAM.BEH.FinalEnrollGoal "ENROLL GOAL (EOY)\nTeam-Level FY15 Behavior Focus List"
   TEAM.Q1.ELA.EnrollGoalPerc "Q1 Team-Level Literacy Enrollment Goal (Percentage)"
   TEAM.Q1.MTH.EnrollGoalPerc "Q1 Team-Level Math Enrollment Goal (Percentage)"
   TEAM.Q1.ATT.EnrollGoalPerc "Q1 Team-Level Attendance Enrollment Goal (Percentage)"
   TEAM.Q1.BEH.EnrollGoalPerc "Q1 Team-Level Behavior Enrollment Goal (Percentage)"
   TEAM.Q2.ELA.EnrollGoalPerc "Q2 Team-Level Literacy Enrollment Goal (Percentage)"
   TEAM.Q2.MTH.EnrollGoalPerc "Q2 Team-Level Math Enrollment Goal (Percentage)"
   TEAM.Q2.ATT.EnrollGoalPerc "Q2 Team-Level Attendance Enrollment Goal (Percentage)"
   TEAM.Q2.BEH.EnrollGoalPerc "Q2 Team-Level Behavior Enrollment Goal (Percentage)"
   TEAM.Q3.ELA.EnrollGoalPerc "Q3 Team-Level Literacy Enrollment Goal (Percentage)"
   TEAM.Q3.MTH.EnrollGoalPerc "Q3 Team-Level Math Enrollment Goal (Percentage)"
   TEAM.Q3.ATT.EnrollGoalPerc "Q3 Team-Level Attendance Enrollment Goal (Percentage)"
   TEAM.Q3.BEH.EnrollGoalPerc "Q3 Team-Level Behavior Enrollment Goal (Percentage)"
   AUG.ELA.DosageGoal "August ELA/Literacy DOSAGE GOAL\nPer-Student (hours)"
   SEP.ELA.DosageGoal "September ELA/Literacy DOSAGE GOAL\nPer-Student (hours)"
   OCT.ELA.DosageGoal "October ELA/Literacy DOSAGE GOAL\nPer-Student (hours)"
   NOV.ELA.DosageGoal "November ELA/Literacy DOSAGE GOAL\nPer-Student (hours)"
   DEC.ELA.DosageGoal "December ELA/Literacy DOSAGE GOAL\nPer-Student (hours)"
   JAN.ELA.DosageGoal "January ELA/Literacy DOSAGE GOAL\nPer-Student (hours)"
   FEB.ELA.DosageGoal "February ELA/Literacy DOSAGE GOAL\nPer-Student (hours)"
   MAR.ELA.DosageGoal "March ELA/Literacy DOSAGE GOAL\nPer-Student (hours)"
   APR.ELA.DosageGoal "April ELA/Literacy DOSAGE GOAL\nPer-Student (hours)"
   MAY.ELA.DosageGoal "May ELA/Literacy DOSAGE GOAL\nPer-Student (hours)"
   JUN.ELA.DosageGoal "June ELA/Literacy DOSAGE GOAL\nPer-Student (hours)"
   AUG.MTH.DosageGoal "August Math DOSAGE GOAL\nPer-Student (hours)"
   SEP.MTH.DosageGoal "September Math DOSAGE GOAL\nPer-Student (hours)"
   OCT.MTH.DosageGoal "October Math DOSAGE GOAL\nPer-Student (hours)"
   NOV.MTH.DosageGoal "November Math DOSAGE GOAL\nPer-Student (hours)"
   DEC.MTH.DosageGoal "December Math DOSAGE GOAL\nPer-Student (hours)"
   JAN.MTH.DosageGoal "January Math DOSAGE GOAL\nPer-Student (hours)"
   FEB.MTH.DosageGoal "February Math DOSAGE GOAL\nPer-Student (hours)"
   MAR.MTH.DosageGoal "March Math DOSAGE GOAL\nPer-Student (hours)"
   APR.MTH.DosageGoal "April Math DOSAGE GOAL\nPer-Student (hours)"
   MAY.MTH.DosageGoal "May Math DOSAGE GOAL\nPer-Student (hours)"
   JUN.MTH.DosageGoal "June Math DOSAGE GOAL\nPer-Student (hours)"
   TEAM.Q1.ELA.EnrollGoal "Q1 ELA/Literacy ENROLL GOAL"
   TEAM.Q1.MTH.EnrollGoal "Q1 Math ENROLL GOAL"
   TEAM.Q1.ATT.EnrollGoal "Q1 Attendance ENROLL GOAL"
   TEAM.Q1.BEH.EnrollGoal "Q1 Behavior ENROLL GOAL"
   TEAM.Q2.ELA.EnrollGoal "Q2 ELA/Literacy ENROLL GOAL"
   TEAM.Q2.MTH.EnrollGoal "Q2 Math ENROLL GOAL"
   TEAM.Q2.ATT.EnrollGoal "Q2 Attendance ENROLL GOAL"
   TEAM.Q2.BEH.EnrollGoal "Q2 Behavior ENROLL GOAL"
   TEAM.Q3.ELA.EnrollGoal "Q3 ELA/Literacy ENROLL GOAL"
   TEAM.Q3.MTH.EnrollGoal "Q3 Math ENROLL GOAL"
   TEAM.Q3.ATT.EnrollGoal "Q3 Attendance ENROLL GOAL"
   TEAM.Q3.BEH.EnrollGoal "Q3 Behavior ENROLL GOAL"
   AUG.ELA.DosageGoal.Minutes "August ELA/Literacy DOSAGE GOAL\nPer-Student (minutes)"
   SEP.ELA.DosageGoal.Minutes "September ELA/Literacy DOSAGE GOAL\nPer-Student (minutes)"
   OCT.ELA.DosageGoal.Minutes "October ELA/Literacy DOSAGE GOAL\nPer-Student (minutes)"
   NOV.ELA.DosageGoal.Minutes "November ELA/Literacy DOSAGE GOAL\nPer-Student (minutes)"
   DEC.ELA.DosageGoal.Minutes "December ELA/Literacy DOSAGE GOAL\nPer-Student (minutes)"
   JAN.ELA.DosageGoal.Minutes "January ELA/Literacy DOSAGE GOAL\nPer-Student (minutes)"
   FEB.ELA.DosageGoal.Minutes "February ELA/Literacy DOSAGE GOAL\nPer-Student (minutes)"
   MAR.ELA.DosageGoal.Minutes "March ELA/Literacy DOSAGE GOAL\nPer-Student (minutes)"
   APR.ELA.DosageGoal.Minutes "April ELA/Literacy DOSAGE GOAL\nPer-Student (minutes)"
   MAY.ELA.DosageGoal.Minutes "May ELA/Literacy DOSAGE GOAL\nPer-Student (minutes)"
   JUN.ELA.DosageGoal.Minutes "June ELA/Literacy DOSAGE GOAL\nPer-Student (minutes)"
   AUG.MTH.DosageGoal.Minutes "August Math DOSAGE GOAL\nPer-Student (minutes)"
   SEP.MTH.DosageGoal.Minutes "September Math DOSAGE GOAL\nPer-Student (minutes)"
   OCT.MTH.DosageGoal.Minutes "October Math DOSAGE GOAL\nPer-Student (minutes)"
   NOV.MTH.DosageGoal.Minutes "November Math DOSAGE GOAL\nPer-Student (minutes)"
   DEC.MTH.DosageGoal.Minutes "December Math DOSAGE GOAL\nPer-Student (minutes)"
   JAN.MTH.DosageGoal.Minutes "January Math DOSAGE GOAL\nPer-Student (minutes)"
   FEB.MTH.DosageGoal.Minutes "February Math DOSAGE GOAL\nPer-Student (minutes)"
   MAR.MTH.DosageGoal.Minutes "March Math DOSAGE GOAL\nPer-Student (minutes)"
   APR.MTH.DosageGoal.Minutes "April Math DOSAGE GOAL\nPer-Student (minutes)"
   MAY.MTH.DosageGoal.Minutes "May Math DOSAGE GOAL\nPer-Student (minutes)"
   JUN.MTH.DosageGoal.Minutes "June Math DOSAGE GOAL\nPer-Student (minutes)".
EXECUTE.

***** In FY14 we needed this syntax because some schools had differing dosage goals by student grade level.
***** Hopefully won't need that this year, but we'll likely still need goals in this format to push into cystudentdata.
***** Reformat file so that the file is aggregated by school and grade level.
*****     grdtemp is the number of grade levels possible.
COMPUTE grdtemp = 14.
EXECUTE.
LOOP id=1 TO 14. 
XSAVE OUTFILE='TeamEnrollDosageBygrade'
   /KEEP ALL
   /PERMISSIONS=WRITEABLE.
END LOOP. 
EXECUTE. 
GET FILE 'TeamEnrollDosageBygrade'. 
SELECT IF (id LE grdtemp). 
EXECUTE.
DATASET NAME TeamEnrollDosageByGrade.

***** Set initial grade value.
COMPUTE StudentGrade = -1.
EXECUTE.
***** Sort by cyschSchoolRefID and Student Grade.
SORT CASES BY cyschSchoolRefID (A) StudentGrade (A).
EXECUTE.
***** Create student grade variable.
DO IF (cyschSchoolRefID = LAG(cyschSchoolRefID)).
COMPUTE StudentGrade = LAG(StudentGrade) + 1.
END IF.
EXECUTE.

***** Prep student enrollment and dosage dataset for merge.
DATASET ACTIVATE FINALDATASET.
SORT CASES BY cyschSchoolRefID (A) StudentGrade (A).
EXECUTE.

***** Merge in team-level enrollment and dosage goals to student enrollment and dosage dataset.
MATCH FILES /FILE = FINALDATASET
   /TABLE = TeamEnrollDosageByGrade
   /BY cyschSchoolRefID StudentGrade.
DATASET NAME FINALDATASET.
ALTER TYPE StudentGrade (F2.0).
EXECUTE.

***** No longer need team enrollment dosage goal dataset.
DATASET CLOSE TeamEnrollDosage.

******************************************************************************************************************************************************
***** Merge in site-level goals.
******************************************************************************************************************************************************

***** Prep site-level enrollment and dosage goals for merge.
DATASET ACTIVATE SiteEnrollDosage.

RENAME VARIABLES (SiteName = Location) (totSchools = totSchoolsPerSite) (ELA.FinalEnrollGoal = SITE.ELA.FinalEnrollGoal)
(MTH.FinalEnrollGoal = SITE.MTH.FinalEnrollGoal) (ATT.FinalEnrollGoal = SITE.ATT.FinalEnrollGoal)
(BEH.FinalEnrollGoal = SITE.BEH.FinalEnrollGoal) (Q1.ELA.EnrollGoal = SITE.Q1.ELA.EnrollGoal)
(Q1.MTH.EnrollGoal = SITE.Q1.MTH.EnrollGoal) (Q1.ATT.EnrollGoal = SITE.Q1.ATT.EnrollGoal)
(Q1.BEH.EnrollGoal = SITE.Q1.BEH.EnrollGoal) (Q2.ELA.EnrollGoal = SITE.Q2.ELA.EnrollGoal)
(Q2.MTH.EnrollGoal = SITE.Q2.MTH.EnrollGoal) (Q2.ATT.EnrollGoal = SITE.Q2.ATT.EnrollGoal)
(Q2.BEH.EnrollGoal = SITE.Q2.BEH.EnrollGoal) (Q3.ELA.EnrollGoal = SITE.Q3.ELA.EnrollGoal)
(Q3.MTH.EnrollGoal = SITE.Q3.MTH.EnrollGoal) (Q3.ATT.EnrollGoal = SITE.Q3.ATT.EnrollGoal)
(Q3.BEH.EnrollGoal = SITE.Q3.BEH.EnrollGoal).

DELETE VARIABLES V1.

***** Add variable labels to existing variables.
VARIABLE LABELS totSchoolsPerSite "Total Number of Schools per Site"
   SITE.ELA.FinalEnrollGoal "ENROLL GOAL (EOY)\nSite-Level FY15 ELA/Literacy Focus List"
   SITE.MTH.FinalEnrollGoal "ENROLL GOAL (EOY)\nSite-Level FY15 Math Focus List"
   SITE.ATT.FinalEnrollGoal "ENROLL GOAL (EOY)\nSite-Level FY15 Attendance Focus List"
   SITE.BEH.FinalEnrollGoal "ENROLL GOAL (EOY)\nSite-Level FY15 Behavior Focus List"
   SITE.Q1.ELA.EnrollGoal "Q1 ENROLL GOAL\nSite-Level ELA/Literacy Focus List"
   SITE.Q1.MTH.EnrollGoal "Q1 ENROLL GOAL\nSite-Level Math Focus List"
   SITE.Q1.ATT.EnrollGoal "Q1 ENROLL GOAL\nSite-Level Attendance Focus List"
   SITE.Q1.BEH.EnrollGoal "Q1 ENROLL GOAL\nSite-Level Behavior Focus List"
   SITE.Q2.ELA.EnrollGoal "Q2 ENROLL GOAL\nSite-Level ELA/Literacy Focus List"
   SITE.Q2.MTH.EnrollGoal "Q2 ENROLL GOAL\nSite-Level Math Focus List"
   SITE.Q2.ATT.EnrollGoal "Q2 ENROLL GOAL\nSite-Level Attendance Focus List"
   SITE.Q2.BEH.EnrollGoal "Q2 ENROLL GOAL\nSite-Level Behavior Focus List"
   SITE.Q3.ELA.EnrollGoal "Q3 ENROLL GOAL\nSite-Level ELA/Literacy Focus List"
   SITE.Q3.MTH.EnrollGoal "Q3 ENROLL GOAL\nSite-Level Math Focus List"
   SITE.Q3.ATT.EnrollGoal "Q3 ENROLL GOAL\nSite-Level Attendance Focus List"
   SITE.Q3.BEH.EnrollGoal "Q3 ENROLL GOAL\nSite-Level Behavior Focus List".
EXECUTE.

SORT CASES BY Location (A).

***** Prep student enrollment and dosage dataset for merge.
DATASET ACTIVATE FINALDATASET.
SORT CASES BY Location (A).

***** Merge site-level enrollment and dosage goals to student enrollment and dosage dataset.
MATCH FILES /FILE = FINALDATASET
   /TABLE = SiteEnrollDosage
   /BY Location.
DATASET NAME FINALDATASET.
EXECUTE.

***** No longer need site enrollment dosage goal dataset.
DATASET CLOSE SiteEnrollDosage.

******************************************************************************************************************************************************
***** Merge in AC Grant IDs.
******************************************************************************************************************************************************

***** Prep grant IDs data file for merge.
DATASET ACTIVATE ACGrantIDs.
***** Delete unnecessary variables.
DELETE VARIABLES Grant SchoolTeam SchoolName GrantSite Location School.
***** Select only rows with cyschSchoolRefID (note 1/20: adding this line because Dallas does not yet have cyschSchoolRefIDs).
SELECT IF (cyschSchoolRefID ~= "").
EXECUTE.
***** Add value labels for existing variables.
VALUE LABELS GrantCategory 1 "National Direct"
   2 "State Commission"
   3 "School Turnaround AmeriCorps".
VALUE LABELS GrantSiteNum 1 "Boston [ND]"
2 "Columbus [ND]"
3 "Denver [ND]"
4 "Jacksonville [ND]"
5 "Little Rock [ND]"
6 "Los Angeles [ND]"
7 "Miami [ND]"
8 "Milwaukee [ND]"
9 "Rhode Island [ND]"
10 "Sacramento [ND]"
11 "San Jose [ND]"
12 "Seattle [ND]" /* 13 "Tulsa [ND]" - Tulsa not on ND for FY15
14 "Washington, DC [ND]"
15 "Boston [State]"
16 "Chicago [State]"
17 "Cleveland [State]"
18 "Columbia [State]"
19 "Columbus [State]"
20 "Detroit [State]"
21 "Los Angeles [State]"
22 "Louisiana (Baton Rouge) [State]"
23 "Louisiana (New Orleans) [State]"
24 "Miami [State Competitive]"
25 "Miami [State Formula]"
26 "New Hampshire [State]"
27 "New York (DN) [State]"
28 "New York [State]"
29 "Orlando [State GMI]"
30 "Orlando [State]"
31 "Philadelphia [State]"
32 "San Antonio [State]"
33 "Washington, DC [State]"
34 "Chicago / Kelvyn Park High School [STA]"
35 "Chicago / Tilden Career Community Academy High School [STA]"
36 "Denver / North High School [STA]"
37 "Denver / Trevista at Horace Mann [STA]"
38 "Los Angeles / Clinton MS [STA]"
39 "Washington, DC / DC Scholars Stanton Elementary School [STA]"
40 "Dallas [ND]"
41 "Orlando [ND]"
42 "Tulsa [State]"
43 "Little Rock / Cloverdale Middle School [STA]"
44 "Washington, DC / Garfield Elementary School [STA]".
EXECUTE.
VARIABLE LABELS GrantCategory "Grant Category"
   GrantSiteNum "Grant / Site".
EXECUTE.
SORT CASES BY cyschSchoolRefID (A).
EXECUTE.

***** Prep final dataset for merge.
DATASET ACTIVATE FINALDATASET.
SORT CASES BY cyschSchoolRefID (A).
EXECUTE.

***** Merge AC grant IDs to final dataset.
MATCH FILES /FILE = FINALDATASET
   /TABLE ACGrantIDs
   /BY cyschSchoolRefID.
DATASET NAME FINALDATASET.
EXECUTE.

******************************************************************************************************************************************************
***** Merge in AC Grant-Level Information.
******************************************************************************************************************************************************

***** Prep AC goals file for merge.
DATASET ACTIVATE ACGoals.
***** Delete unnecessary variables.
DELETE VARIABLES DELETE1 DELETE2 DELETE3 DELETE4 DELETE5 DELETE6 DELETE7 DELETE8 DELETE9 DELETE10 DELETE11 DELETE12 DELETE13
DELETE14 DELETE15 DELETE16 DELETE17 DELETE18 DELETE19 DELETE20 DELETE21 DELETE22 DELETE23 DELETE24 DELETE25 DELETE26 DELETE27
DELETE28 DELETE29 DELETE30 DELETE31 DELETE32 DELETE33 DELETE34 DELETE35 DELETE36 DELETE37 DELETE38 DELETE39 DELETE40 DELETE41
DELETE42 DELETE43 DELETE44 DELETE45 DELETE46 DELETE47 DELETE48 DELETE49 DELETE50 DELETE51 DELETE52 DELETE53 DELETE54 DELETE55
DELETE56 DELETE57 DELETE58 DELETE59 DELETE60 DELETE61 DELETE62.
***** Rename linking ID variable.
RENAME VARIABLES (EVAL_ID = GrantSiteNum).
***** Add value labels for existing variables.
VALUE LABELS ACreportLIT 0 "Not reporting on literacy for AmeriCorps"
   1 "Reporting on literacy for AmeriCorps".
VALUE LABELS ACreportMTH 0 "Not reporting on math for AmeriCorps"
   1 "Reporting on math for AmeriCorps".
VALUE LABELS ACreportATT 0 "Not reporting on attendance for AmeriCorps"
   1 "Reporting on attendance for AmeriCorps".
VALUE LABELS ACreportBEH 0 "Not reporting on behavior for AmeriCorps"
   1 "Reporting on behavior for AmeriCorps".
EXECUTE.
***** Add variable labels for existing variables.
VARIABLE LABELS ACreportLIT "Reporting on literacy for AmeriCorps? [0=No; 1=Yes]"
   ACreportMTH "Reporting on math for AmeriCorps? [0=No; 1=Yes]"
   ACreportATT "Reporting on attendance for AmeriCorps? [0=No; 1=Yes]"
   ACreportBEH "Reporting on behavior for AmeriCorps? [0=No; 1=Yes]"
   ACED1AcadGoal "GOAL ED1 Academic:\nUnique Number of Students Enrolled in Literacy or Math"
   ACED2AcadGoal "GOAL ED2 Academic:\nUnique Number of Students Who Met Dosage in Literacy or Math"
   ACED5AcadGoal "GOAL ED5 Academic:\nUnique Number of Students Who Met Performance Goal in Literacy or Math"
   ACED1StEngGoal "GOAL ED1 Student Engagement:\nUnique Number of Students Enrolled in Attendance or Behavior"
   ACED2StEngGoal "GOAL ED2 Student Engagement:\nUnique Number of Students Who Met Dosage in Attendance or Behavior"
   ACED27StEngGoal "GOAL ED27 Student Engagement:\nUnique Number of Students Who Met Performance Goal in Attendance or Behavior".
EXECUTE.
SORT CASES BY GrantSiteNum (A).
EXECUTE.

***** Prep final dataset for merge.
DATASET ACTIVATE FINALDATASET.
SORT CASES BY GrantSiteNum (A).
EXECUTE.

***** Merge AC goals to final dataset.
MATCH FILES /FILE = FINALDATASET
   /TABLE = ACGoals
   /BY GrantSiteNum.
DATASET NAME FINALDATASET.
EXECUTE.

***** No longer need AC data files.
DATASET CLOSE ACGrantIDs.
DATASET CLOSE ACGoals.

******************************************************************************************************************************************************
***** Merge in student performance ID translation file.
******************************************************************************************************************************************************

***** Prep student ID translation file for merge.
DATASET ACTIVATE StPerfIDs.
***** Delete unnecessary variables.
DELETE VARIABLES FIRST_NAME MIDDLE_NAME LAST_NAME REGION_ID REGION_NAME SITE_NAME CYCHANNEL_SCHOOL_ACCOUNT_NBR
SCHOOL_NAME DIPLOMAS_NOW_SCHOOL GENDER GRADE_ID GRADE_DESC PRIMARY_CM_ID PRIMARY_CM_NAME CYCHANNEL_ACCOUNT_NBR
Attendance_IA ELA_IA Math_IA Behavior_IA FISCAL_YEAR.
***** Rename linking ID variable.
RENAME VARIABLES (STUDENT_ID = cysdStudentID) (CYSCHOOLHOUSE_STUDENT_ID = cyStudentID) (SITE_ID = cysdSiteID) (SCHOOL_ID = cysdSchoolID).
***** Add variable labels for existing variables.
VARIABLE LABELS cysdStudentID "cystudentdata: Student ID"
   cysdSiteID "cystudentdata: Site ID"
   cysdSchoolID "cystudentdata: School ID".
EXECUTE.
ALTER TYPE cysdStudentID cysdSiteID cysdSchoolID (F40.0) cyStudentID (A9).
SORT CASES BY cyStudentID (A).
EXECUTE.

***** Prep final dataset for merge.
DATASET ACTIVATE FINALDATASET.
SORT CASES BY cyStudentID (A).
EXECUTE.

***** Merge student IDs to final dataset.
MATCH FILES /FILE = FINALDATASET
   /TABLE = StPerfIDs
   /BY cyStudentID.
DATASET NAME FINALDATASET.
EXECUTE.

***** No longer need the student ID translation file.
DATASET CLOSE StPerfIDs.

******************************************************************************************************************************************************
***** Merge in literacy assessment performance data.
******************************************************************************************************************************************************

***** Prep literacy assessment data file for merge.
DATASET ACTIVATE LITAssessPerf.
***** Delete unnecessary variables.
DELETE VARIABLES SITE_NAME SCHOOL_NAME GRADE_ID DIPLOMAS_NOW_SCHOOL SCHOOL_ID ASSESSMENT_TYPE PRE_VALUE
PRE_TRACK_NATIONAL POST_VALUE POST_TRACK_NATIONAL DOSAGE_CATEGORY TTL_TIME ENROLLED_DAYS_CATEGORIES CURRENTLY_ENROLLED
ENROLLED_DAYS LIT_ASSESS_RAWCHANGE LIT_ASSESS_PERCENTCHANGE STATUS_SITE_DOSAGE_GOAL SITE_DOSAGE_GOAL Attendance_IA
ELA_IA Math_IA Behavior_IA FISCAL_YEAR INDICATOR_ID B_RULE_VAL1 B_RULE_VAL2 B_RULE_VAL3 B_RULE_VAL4 B_RULE_VAL5 GRADE_ID_RECODE
MY_MET_MARCH_DOSAGE PROXY_DATE PROXY_DESC PROXY_VALUE_NUM PROXY_TRACK PROXY_TRACK_EVAL.
***** Rename linking ID variable.
RENAME VARIABLES (STUDENT_ID = cysdStudentID) (PRE_VALUE_DISPLAY = LITAssess_PRE_VALUE_DISPLAY)
(PRE_VALUE_NUM = LITAssess_PRE_VALUE_NUM) (PRE_DATE = LITAssess_PRE_DATE) (PRE_DESC = LITAssess_PRE_DESC)
(PRE_TRACK_NUM = LITAssess_PRE_TRACK_NUM) (PRE_TRACK = LITAssess_PRE_TRACK) (PRE_TRACK_EVAL = LITAssess_PRE_TRACK_EVAL)
(POST_VALUE_DISPLAY = LITAssess_POST_VALUE_DISPLAY) (POST_VALUE_NUM = LITAssess_POST_VALUE_NUM) (POST_DATE = LITAssess_POST_DATE)
(POST_DESC = LITAssess_POST_DESC) (POST_TRACK_NUM = LITAssess_POST_TRACK_NUM)
(POST_TRACK = LITAssess_POST_TRACK) (POST_TRACK_EVAL = LITAssess_POST_TRACK_EVAL)
(LIT_ASSESS_RAWCHANGE_DEGREE = LITAssess_RAWCHANGE_DEG) (LIT_ASSESS_PERFORMANCECHANGE_LOCAL = LITAssess_PERFCHANGE_LOCAL)
(LIT_ASSESS_PERFORMANCECHANGE_NORMALIZED = LITAssess_PERFCHANGE_NORM) (MY_PERF_DATE = LITAssess_MY_DATE)
(MY_DESC = LITAssess_MY_DESC) (MY_VALUE_NUM = LITAssess_MY_VALUE_NUM) (MY_TRACK_NUM = LITAssess_MY_TRACK_NUM)
(MY_TRACK = LITAssess_MY_TRACK) (MY_TRACK_EVAL = LITAssess_MY_TRACK_EVAL) (MY_RAWCHANGE_DEGREE = LITAssess_MY_RAWCHANGE_DEG)
(MY_PERFORMANCECHANGE_LOCAL = LITAssess_MY_PERFCHANGE_LOCAL) (MY_PERFORMANCECHANGE_NORMALIZED = LITAssess_MY_PERFCHANGE_NORM).
***** Add variable labels for existing variables.
VARIABLE LABELS LITAssess_PRE_VALUE_DISPLAY "Literacy Assessments: pre raw score (display)"
LITAssess_PRE_VALUE_NUM "Literacy Assessments: pre raw score (numeric)"
LITAssess_PRE_DATE "Literacy Assessments: pre date"
LITAssess_PRE_DESC "Literacy Assessments: pre assessment type"
LITAssess_PRE_TRACK_NUM "Literacy Assessments: pre performance level (numeric)"
LITAssess_PRE_TRACK "Literacy Assessments: pre performance level"
LITAssess_PRE_TRACK_EVAL "Literacy Assessments: pre performance level (normalized)"
LITAssess_POST_VALUE_DISPLAY "Literacy Assessments: post raw score (display)"
LITAssess_POST_VALUE_NUM "Literacy Assessments: post raw score (numeric)"
LITAssess_POST_DATE "Literacy Assessments: post date"
LITAssess_POST_DESC "Literacy Assessments: post assessment type"
LITAssess_POST_TRACK_NUM "Literacy Assessments: post performance level (numeric)"
LITAssess_POST_TRACK "Literacy Assessments: post performance level"
LITAssess_POST_TRACK_EVAL "Literacy Assessments: post performance level (normalized)"
LITAssess_RAWCHANGE_DEG "Literacy Assessments: pre to post raw score change (degree)"
LITAssess_PERFCHANGE_LOCAL "Literacy Assessments: pre to post change in performance level"
LITAssess_PERFCHANGE_NORM "Literacy Assessments: pre to post change in performance level (normalized)"
LITAssess_MY_DATE "Literacy Assessments: mid-year date"
LITAssess_MY_DESC "Literacy Assessments: mid-year assessment type"
LITAssess_MY_VALUE_NUM "Literacy Assessments: mid-year raw score (numeric)"
LITAssess_MY_TRACK_NUM "Literacy Assessments: mid-year performance level (numeric)"
LITAssess_MY_TRACK "Literacy Assessments: mid-year performance level"
LITAssess_MY_TRACK_EVAL "Literacy Assessments: mid-year performance level (normalized)"
LITAssess_MY_RAWCHANGE_DEG "Literacy Assessments: pre to mid-year raw score change (degree)"
LITAssess_MY_PERFCHANGE_LOCAL "Literacy Assessments: pre to mid-year change in performance level"
LITAssess_MY_PERFCHANGE_NORM "Literacy Assessments: pre to mid-year change in performance level (normalized)".
EXECUTE.
SORT CASES BY cysdStudentID (A).
EXECUTE.

***** Prep final dataset for merge.
DATASET ACTIVATE FINALDATASET.
SORT CASES BY cysdStudentID (A).
EXECUTE.

***** Merge student IDs to final dataset.
MATCH FILES /FILE = FINALDATASET
   /TABLE = LITAssessPerf
   /BY cysdStudentID.
DATASET NAME FINALDATASET.
EXECUTE.

***** No longer need the literacy assessment dataset.
DATASET CLOSE LITAssessPerf.

******************************************************************************************************************************************************
***** Merge in math assessment performance data.
******************************************************************************************************************************************************

***** Prep math assessment data file for merge.
DATASET ACTIVATE MTHAssessPerf.
***** Delete unnecessary variables.
DELETE VARIABLES SITE_NAME SCHOOL_NAME GRADE_ID DIPLOMAS_NOW_SCHOOL SCHOOL_ID ASSESSMENT_TYPE PRE_VALUE
PRE_TRACK_NATIONAL POST_VALUE POST_TRACK_NATIONAL DOSAGE_CATEGORY TTL_TIME ENROLLED_DAYS_CATEGORIES
CURRENTLY_ENROLLED ENROLLED_DAYS LIT_ASSESS_RAWCHANGE LIT_ASSESS_PERCENTCHANGE STATUS_SITE_DOSAGE_GOAL
SITE_DOSAGE_GOAL Attendance_IA ELA_IA Math_IA Behavior_IA FISCAL_YEAR INDICATOR_ID B_RULE_VAL1 B_RULE_VAL2
B_RULE_VAL3 B_RULE_VAL4 B_RULE_VAL5 GRADE_ID_RECODE MY_MET_MARCH_DOSAGE PROXY_DATE PROXY_DESC PROXY_VALUE_NUM
PROXY_TRACK PROXY_TRACK_EVAL.
***** Rename linking ID variable.
RENAME VARIABLES (STUDENT_ID = cysdStudentID) (PRE_VALUE_DISPLAY = MTHAssess_PRE_VALUE_DISPLAY)
(PRE_VALUE_NUM = MTHAssess_PRE_VALUE_NUM) (PRE_DATE = MTHAssess_PRE_DATE) (PRE_DESC = MTHAssess_PRE_DESC)
(PRE_TRACK_NUM = MTHAssess_PRE_TRACK_NUM) (PRE_TRACK = MTHAssess_PRE_TRACK) (PRE_TRACK_EVAL = MTHAssess_PRE_TRACK_EVAL)
(POST_VALUE_DISPLAY = MTHAssess_POST_VALUE_DISPLAY) (POST_VALUE_NUM = MTHAssess_POST_VALUE_NUM)
(POST_DATE = MTHAssess_POST_DATE) (POST_DESC = MTHAssess_POST_DESC) (POST_TRACK_NUM = MTHAssess_POST_TRACK_NUM)
(POST_TRACK = MTHAssess_POST_TRACK) (POST_TRACK_EVAL = MTHAssess_POST_TRACK_EVAL)
(LIT_ASSESS_RAWCHANGE_DEGREE = MTHAssess_RAWCHANGE_DEG) (LIT_ASSESS_PERFORMANCECHANGE_LOCAL = MTHAssess_PERFCHANGE_LOCAL)
(LIT_ASSESS_PERFORMANCECHANGE_NORMALIZED = MTHAssess_PERFCHANGE_NORM) (MY_PERF_DATE = MTHAssess_MY_DATE)
(MY_DESC = MTHAssess_MY_DESC) (MY_VALUE_NUM = MTHAssess_MY_VALUE_NUM) (MY_TRACK_NUM = MTHAssess_MY_TRACK_NUM)
(MY_TRACK = MTHAssess_MY_TRACK) (MY_TRACK_EVAL = MTHAssess_MY_TRACK_EVAL) (MY_RAWCHANGE_DEGREE = MTHAssess_MY_RAWCHANGE_DEG)
(MY_PERFORMANCECHANGE_LOCAL = MTHAssess_MY_PERFCHANGE_LOCAL) (MY_PERFORMANCECHANGE_NORMALIZED = MTHAssess_MY_PERFCHANGE_NORM).
***** Add variable labels for existing variables.
VARIABLE LABELS MTHAssess_PRE_VALUE_DISPLAY "Math Assessments: pre raw score (display)"
MTHAssess_PRE_VALUE_NUM "Math Assessments: pre raw score (numeric)"
MTHAssess_PRE_DATE "Math Assessments: pre date"
MTHAssess_PRE_DESC "Math Assessments: pre assessment type"
MTHAssess_PRE_TRACK_NUM "Math Assessments: pre performance level (numeric)"
MTHAssess_PRE_TRACK "Math Assessments: pre performance level (local)"
MTHAssess_PRE_TRACK_EVAL "Math Assessments: pre performance level (normalized)"
MTHAssess_POST_VALUE_DISPLAY "Math Assessments: post raw score (display)"
MTHAssess_POST_VALUE_NUM "Math Assessments: post raw score (numeric)"
MTHAssess_POST_DATE "Math Assessments: post date"
MTHAssess_POST_DESC "Math Assessments: post assessment type"
MTHAssess_POST_TRACK_NUM "Math Assessments: post performance level (numeric)"
MTHAssess_POST_TRACK "Math Assessments: post performance level (local)"
MTHAssess_POST_TRACK_EVAL "Math Assessments: post performance level (normalized)"
MTHAssess_RAWCHANGE_DEG "Math Assessments: pre to post change in raw score (degree)"
MTHAssess_PERFCHANGE_LOCAL "Math Assessments: pre to post change in performance level (local)"
MTHAssess_PERFCHANGE_NORM "Math Assessments: pre to post change in performance level (normalized)"
MTHAssess_MY_DATE "Math Assessments: mid-year date"
MTHAssess_MY_DESC "Math Assessments: mid-year assessment type"
MTHAssess_MY_VALUE_NUM "Math Assessments: mid-year raw score (numeric)"
MTHAssess_MY_TRACK_NUM "Math Assessments: mid-year performance level (numeric)"
MTHAssess_MY_TRACK "Math Assessments: mid-year performance level"
MTHAssess_MY_TRACK_EVAL "Math Assessments: mid-year performance level (normalized)"
MTHAssess_MY_RAWCHANGE_DEG "Math Assessments: pre to mid-year change in raw score (degree)"
MTHAssess_MY_PERFCHANGE_LOCAL "Math Assessments: pre to mid-year change in performance level"
MTHAssess_MY_PERFCHANGE_NORM "Math Assessments: pre to mid-year change in performance level (normalized)".
EXECUTE.
SORT CASES BY cysdStudentID (A).
EXECUTE.

***** Prep final dataset for merge.
DATASET ACTIVATE FINALDATASET.
SORT CASES BY cysdStudentID (A).
EXECUTE.

***** Merge student IDs to final dataset.
MATCH FILES /FILE = FINALDATASET
   /TABLE = MTHAssessPerf
   /BY cysdStudentID.
DATASET NAME FINALDATASET.
EXECUTE.

***** No longer need the math assessment dataset.
DATASET CLOSE MTHAssessPerf.

******************************************************************************************************************************************************
***** Merge in ELA CG performance data.
******************************************************************************************************************************************************

***** Prep ELA course grade data file for merge.
DATASET ACTIVATE ELACGPerf.
***** Delete unnecessary variables.
DELETE VARIABLES SITE_NAME SCHOOL_NAME GRADE_ID DIPLOMAS_NOW_SCHOOL SCHOOL_ID PRE_ELA_CG_VALUE PRE_ELA_DESC
PRE_ELA_TRACK_EVAL PRE_SCENARIO DOSAGE_CATEGORY TTL_TIME POST_ELA_CG_VALUE POST_ELA_DESC POST_ELA_TRACK_EVAL
POST_SCENARIO CG_Change Enrollment_Duration ENROLL_DAYS STATUS_SITE_DOSAGE_GOAL SITE_DOSAGE_GOAL Attendance_IA ELA_IA
Math_IA Behavior_IA FISCAL_YEAR INDICATOR_ID B_RULE_VAL1 B_RULE_VAL2 B_RULE_VAL3 B_RULE_VAL4 B_RULE_VAL5 GRADE_ID_RECODE
MY_MET_MARCH_DOSAGE PROXY_ELA_FREQ PROXY_ELA_TRACK PROXY_LETTER_VIEW PROXY_CG_LETTER_SCALE_ALL OG_PROXY_ELA_CG_NUM.
***** Rename linking ID variable.
RENAME VARIABLES (STUDENT_ID = cysdStudentID) (PRE_ELA_CG_VALUE_DISPLAY = ELACG_PRE_VALUE_DISPLAY)
(PRE_ELA_CG_VALUE_NUM = ELACG_PRE_VALUE_NUM) (PRE_ELA_FREQ = ELACG_PRE_FREQ) (PRE_ELA_TRACK = ELACG_PRE_TRACK)
(PRE_LETTER_VIEW = ELACG_PRE_LETTER_VIEW) (PRE_CG_LETTER_SCALE_ALL = ELACG_PRE_LETTER_SCALE_ALL)
(POST_ELA_CG_VALUE_DISPLAY = ELACG_POST_VALUE_DISPLAY) (POST_ELA_CG_VALUE_NUM = ELACG_POST_VALUE_NUM)
(POST_ELA_FREQ = ELACG_POST_FREQ) (POST_ELA_TRACK = ELACG_POST_TRACK) (POST_LETTER_VIEW = ELACG_POST_LETTER_VIEW)
(POST_CG_LETTER_SCALE_ALL = ELACG_POST_LETTER_SCALE_ALL) (LETTERGADE_CHANGE_ACTUAL = ELACG_LTRGRD_CHANGE_ACTUAL)
(LETTERGADE_CHANGE_GENERAL = ELACG_LTRGRD_CHANGE_GENERAL) (CG_Performance_Level_Change = ELACG_PERF_LVL_CHANGE)
(MY_ELA_FREQ = ELACG_MY_FREQ) (MY_ELA_TRACK = ELACG_MY_TRACK) (MY_LETTER_VIEW = ELACG_MY_LETTER_VIEW)
(MY_CG_LETTER_SCALE_ALL = ELACG_MY_LETTER_SCALE_ALL) (MY_LETTERGRADE_CHANGE_ACTUAL = ELACG_MY_LTRGRD_CHANGE_ACTUAL)
(MY_PERF_CHANGE = ELACG_MY_PERF_LVL_CHANGE) (OG_PRE_ELA_CG_NUM = ELACG_OG_PRE_CG_NUM) (OG_POST_ELA_CG_NUM = ELACG_OG_POST_CG_NUM)
(OG_MY_ELA_CG_NUM = ELACG_OG_MY_CG_NUM) (MY_Change = ELACG_MY_LTRGRD_CHANGE_GENERAL) (OG_MY_ELA_CG_CHANGE = ELACG_OG_MY_CHANGE)
(OG_EOY_ELA_CG_CHANGE = ELACG_OG_EOY_CHANGE).
***** Add variable labels for existing variables.
VARIABLE LABELS ELACG_PRE_VALUE_DISPLAY "ELA Course Grades: pre course grade display"
ELACG_PRE_VALUE_NUM "ELA Course Grades: pre course grade (numeric)"
ELACG_PRE_FREQ "ELA Course Grades: pre time period"
ELACG_PRE_TRACK "ELA Course Grades: pre performance level"
ELACG_PRE_LETTER_VIEW "ELA Course Grades: pre letter grade"
ELACG_PRE_LETTER_SCALE_ALL "ELA Course Grades: pre letter scale"
ELACG_POST_VALUE_DISPLAY "ELA Course Grades: post course grade display"
ELACG_POST_VALUE_NUM "ELA Course Grades: post course grade (numeric)"
ELACG_POST_FREQ "ELA Course Grades: post time period"
ELACG_POST_TRACK "ELA Course Grades: post performance level"
ELACG_POST_LETTER_VIEW "ELA Course Grades: post letter grade"
ELACG_POST_LETTER_SCALE_ALL "ELA Course Grades: post letter scale"
ELACG_LTRGRD_CHANGE_ACTUAL "ELA Course Grades: pre to post change in letter grade"
ELACG_LTRGRD_CHANGE_GENERAL "ELA Course Grades: pre to post change in letter grade (degree)"
ELACG_PERF_LVL_CHANGE "ELA Course Grades: pre to post change in performance level"
ELACG_MY_FREQ "ELA Course Grades: mid-year time period"
ELACG_MY_TRACK "ELA Course Grades: mid-year performance level"
ELACG_MY_LETTER_VIEW "ELA Course Grades: mid-year letter grade"
ELACG_MY_LETTER_SCALE_ALL "ELA Course Grades: mid-year letter scale"
ELACG_MY_LTRGRD_CHANGE_ACTUAL "ELA Course Grades: pre to mid-year change in letter grade"
ELACG_MY_LTRGRD_CHANGE_GENERAL "ELA Course Grades: pre to mid-year change in letter grade (degree)"
ELACG_MY_PERF_LVL_CHANGE "ELA Course Grades: pre to mid-year change in performance level"
ELACG_OG_PRE_CG_NUM "ELA Course Grades: pre course grade (numeric, for operating goals)"
ELACG_OG_POST_CG_NUM "ELA Course Grades: post course grade (numeric, for operating goals)"
ELACG_OG_MY_CG_NUM "ELA Course Grades: mid-year course grade (numeric, for operating goals)"
ELACG_OG_MY_CHANGE "ELA Course Grades: pre to mid-year change in course grades (operating goals)"
ELACG_OG_EOY_CHANGE "ELA Course Grades: pre to post change in course grades (operating goals)".
EXECUTE.
SORT CASES BY cysdStudentID (A).
EXECUTE.

***** Prep final dataset for merge.
DATASET ACTIVATE FINALDATASET.
SORT CASES BY cysdStudentID (A).
EXECUTE.

***** Merge student IDs to final dataset.
MATCH FILES /FILE = FINALDATASET
   /TABLE = ELACGPerf
   /BY cysdStudentID.
DATASET NAME FINALDATASET.
EXECUTE.

***** No longer need ELA course grade dataset.
DATASET CLOSE ELACGPerf.

******************************************************************************************************************************************************
***** Merge in math CG performance data.
******************************************************************************************************************************************************

***** Prep math course grade data file for merge.
DATASET ACTIVATE MTHCGPerf.
***** Delete unnecessary variables.
DELETE VARIABLES SITE_NAME SCHOOL_NAME GRADE_ID DIPLOMAS_NOW_SCHOOL SCHOOL_ID PRE_MATH_CG_VALUE PRE_MATH_DESC
PRE_MATH_TRACK_EVAL PRE_SCENARIO POST_MATH_CG_VALUE POST_MATH_DESC POST_MATH_TRACK_EVAL POST_SCENARIO
DOSAGE_CATEGORY TTL_TIME CG_Change Enrollment_Duration ENROLL_DAYS STATUS_SITE_DOSAGE_GOAL SITE_DOSAGE_GOAL
Attendance_IA ELA_IA Math_IA Behavior_IA FISCAL_YEAR INDICATOR_ID B_RULE_VAL1 B_RULE_VAL2 B_RULE_VAL3 B_RULE_VAL4 B_RULE_VAL5
GRADE_ID_RECODE MY_MET_MARCH_DOSAGE PROXY_MATH_FREQ PROXY_MATH_TRACK PROXY_LETTER_VIEW PROXY_CG_LETTER_SCALE_ALL OG_PROXY_MTH_CG_NUM.
***** Rename linking ID variable.
RENAME VARIABLES (STUDENT_ID = cysdStudentID) (PRE_MATH_CG_VALUE_DISPLAY = MTHCG_PRE_VALUE_DISPLAY)
(PRE_MATH_CG_VALUE_NUM = MTHCG_PRE_VALUE_NUM) (PRE_MATH_FREQ = MTHCG_PRE_FREQ)
(PRE_MATH_TRACK = MTHCG_PRE_TRACK) (PRE_LETTER_VIEW = MTHCG_PRE_LETTER_VIEW)
(PRE_CG_LETTER_SCALE_ALL = MTHCG_PRE_LETTER_SCALE_ALL) (POST_MATH_CG_VALUE_DISPLAY = MTHCG_POST_VALUE_DISPLAY)
(POST_MATH_CG_VALUE_NUM = MTHCG_POST_VALUE_NUM) (POST_MATH_FREQ = MTHCG_POST_FREQ)
(POST_MATH_TRACK = MTHCG_POST_TRACK) (POST_LETTER_VIEW = MTHCG_POST_LETTER_VIEW)
(POST_CG_LETTER_SCALE_ALL = MTHCG_POST_LETTER_SCALE_ALL) (LETTERGADE_CHANGE_ACTUAL = MTHCG_LTRGRD_CHANGE_ACTUAL)
(LETTERGADE_CHANGE_GENERAL = MTHCG_LTRGRD_CHANGE_GENERAL) (CG_Performance_Level_Change = MTHCG_PERF_LVL_CHANGE)
(MY_MATH_FREQ = MTHCG_MY_FREQ) (MY_MATH_TRACK = MTHCG_MY_TRACK) (MY_LETTER_VIEW = MTHCG_MY_LETTER_VIEW)
(MY_CG_LETTER_SCALE_ALL = MTHCG_MY_LETTER_SCALE_ALL) (MY_LETTERGRADE_CHANGE_ACTUAL = MTHCG_MY_LTRGRD_CHANGE_ACTUAL)
(MY_PERF_CHANGE = MTHCG_MY_PERF_LVL_CHANGE) (OG_PRE_MTH_CG_NUM = MTHCG_OG_PRE_CG_NUM) (OG_POST_MTH_CG_NUM = MTHCG_OG_POST_CG_NUM)
(OG_MY_MTH_CG_NUM = MTHCG_OG_MY_CG_NUM) (MY_Change = MTHCG_MY_LTRGRD_CHANGE_GENERAL) (OG_MY_MTH_CG_CHANGE = MTHCG_OG_MY_CHANGE)
(OG_EOY_MTH_CG_CHANGE = MTHCG_OG_EOY_CHANGE).
***** Add variable labels for existing variables.
VARIABLE LABELS MTHCG_PRE_VALUE_DISPLAY "Math Course Grades: pre course grade display"
MTHCG_PRE_VALUE_NUM "Math Course Grades: pre course grade (numeric)"
MTHCG_PRE_FREQ "Math Course Grades: pre time period"
MTHCG_PRE_TRACK "Math Course Grades: pre performance level"
MTHCG_PRE_LETTER_VIEW "Math Course Grades: pre letter grade"
MTHCG_PRE_LETTER_SCALE_ALL "Math Course Grades: pre letter scale"
MTHCG_POST_VALUE_DISPLAY "Math Course Grades: post course grade display"
MTHCG_POST_VALUE_NUM "Math Course Grades: post course grade (numeric)"
MTHCG_POST_FREQ "Math Course Grades: post time period"
MTHCG_POST_TRACK "Math Course Grades: post performance level"
MTHCG_POST_LETTER_VIEW "Math Course Grades: post letter grade"
MTHCG_POST_LETTER_SCALE_ALL "Math Course Grades: post letter scale"
MTHCG_LTRGRD_CHANGE_ACTUAL "Math Course Grades: pre to post change in letter grade"
MTHCG_LTRGRD_CHANGE_GENERAL "Math Course Grades: pre to post change in letter grade (degree)"
MTHCG_PERF_LVL_CHANGE "Math Course Grades: pre to post change in performance level"
MTHCG_MY_FREQ "Math Course Grades: mid-year time period"
MTHCG_MY_TRACK "Math Course Grades: mid-year performance level"
MTHCG_MY_LETTER_VIEW "Math Course Grades: mid-year letter grade"
MTHCG_MY_LETTER_SCALE_ALL "Math Course Grades: mid-year letter scale"
MTHCG_MY_LTRGRD_CHANGE_ACTUAL "Math Course Grades: pre to mid-year change in letter grade"
MTHCG_MY_LTRGRD_CHANGE_GENERAL "Math Course Grades: pre to mid-year change in letter grade (degree)"
MTHCG_PERF_LVL_CHANGE "Math Course Grades: pre to mid-year change in performance level"
MTHCG_OG_PRE_CG_NUM "Math Course Grades: pre course grade (numeric, for operating goals)"
MTHCG_OG_POST_CG_NUM "Math Course Grades: post course grade (numeric, for operating goals)"
MTHCG_OG_MY_CG_NUM "Math Course Grades: mid-year course grade (numeric, for operating goals)"
MTHCG_OG_MY_CHANGE "Math Course Grades: pre to mid-year change in course grades (operating goals)"
MTHCG_OG_EOY_CHANGE "Math Course Grades: pre to post change in course grades (operating goals)".
EXECUTE.
SORT CASES BY cysdStudentID (A).
EXECUTE.

***** Prep final dataset for merge.
DATASET ACTIVATE FINALDATASET.
SORT CASES BY cysdStudentID (A).
EXECUTE.

***** Merge student IDs to final dataset.
MATCH FILES /FILE = FINALDATASET
   /TABLE = MTHCGPerf
   /BY cysdStudentID.
DATASET NAME FINALDATASET.
EXECUTE.

***** No longer need the math course grade dataset.
DATASET CLOSE MTHCGPerf.

******************************************************************************************************************************************************
***** Merge in attendance performance data.
******************************************************************************************************************************************************

***** Prep attendance performance data file for merge.
DATASET ACTIVATE ATTPerf.
***** Delete unnecessary variables.
DELETE VARIABLES SITE_NAME SCHOOL_NAME GRADE_ID DIPLOMAS_NOW_SCHOOL SCHOOL_ID PRE_SKILL_DESC PRE_SCENARIO
PRE_ATT_TRACK_EVAL PRE_INVALID_ADA POST_SKILL_DESC POST_SCENARIO POST_ATT_TRACK_EVAL POST_INVALID_ADA DOSAGE_CATEGORY
TTL_TIME ENROLLED_DAYS_CATEGORIES CURRENTLY_ENROLLED ENROLLED_DAYS ATT_PERFORMANCE_CHANGE_NATIONAL
ATT_ADA_CHANGE_TYPE Attendance_IA ELA_IA Math_IA Behavior_IA FISCAL_YEAR INDICATOR_ID B_RULE_VAL1 B_RULE_VAL2 B_RULE_VAL3 B_RULE_VAL4
B_RULE_VAL5 GRADE_ID_RECODE EOY_MET_56_DAYS PROXY_ATTMP_FREQ_DESC PROXY_ATTMP_ADA PROXY_ATTMP_TRACK PROXY_ATTDJFM_ADA
PROXY_ATTDJFM_TRACK PROXY_ATTCUMUL_ADA PROXY_ATTCUMUL_TRACK.
***** Rename linking ID variable.
RENAME VARIABLES (STUDENT_ID = cysdStudentID) (PRE_FREQ_DESC = ATT_PRE_FREQ_DESC) (PRE_ATT_ADA = ATT_PRE_ADA)
(PRE_ATT_SCHOOL_OPEN = ATT_PRE_SCHOOL_OPEN) (PRE_ATT_MISSING = ATT_PRE_MISSING) (PRE_ATT_NOT_ENROLLED = ATT_PRE_NOT_ENROLLED)
(PRE_ATT_TRACK = ATT_PRE_TRACK) (POST_FREQ_DESC = ATT_POST_FREQ_DESC) (POST_ATT_ADA = ATT_POST_ADA)
(POST_ATT_SCHOOL_OPEN = ATT_POST_SCHOOL_OPEN) (POST_ATT_MISSING = ATT_POST_MISSING)
(POST_ATT_NOT_ENROLLED = ATT_POST_NOT_ENROLLED) (POST_ATT_TRACK = ATT_POST_TRACK) (ATT_ADA_CHANGE = ATT_ADA_CHANGE)
(EOY_ATT_ADA_CHANGE_TYPE = ATT_ADA_CHANGE_TYPE) (EOY_ATT_INC_BY_2_PERC_PT = ATT_INC_BY_2_PERC_PT)
(ATT_PERFORMANCE_CHANGE_LOCAL = ATT_PERF_CHANGE_LOCAL) (OG_EOY_LT_90_TO_GTE = ATT_OG_EOY_LT_90_TO_GTE)
(MY_FREQ_DESC = ATT_MY_FREQ_DESC) (MY_ADA = ATT_MY_ADA) (MY_TRACK = ATT_MY_TRACK) (MY_ADA_CHANGE = ATT_MY_ADA_CHANGE)
(MY_ATT_PERFORMANCE_CHANGE_LOCAL = ATT_MY_PERF_CHANGE_LOCAL) (OG_MY_LT_90_TO_GTE = ATT_OG_MY_LT_90_TO_GTE)
(MY_ATT_ADA_CHANGE_TYPE = ATT_MY_ADA_CHANGE_TYPE) (MY_ATT_INC_BY_2_PERC_PT = ATT_MY_INC_BY_2_PERC_PT).
***** Add value labels for existing variables.
VALUE LABELS ATT_INC_BY_2_PERC_PT 0 "Did not increase ADA by at least 2 percentage points"
   1 "Increased ADA by at least 2 percentage points".
EXECUTE.
***** Add variable labels for existing variables.
VARIABLE LABELS ATT_PRE_FREQ_DESC "Attendance: pre time period"
ATT_PRE_ADA "Attendance: pre average daily attendance"
ATT_PRE_SCHOOL_OPEN "Attendance: pre number of days school open"
ATT_PRE_MISSING "Attendance: pre number of days missed"
ATT_PRE_NOT_ENROLLED "Attendance: pre number of days not enrolled"
ATT_PRE_TRACK "Attendance: pre performance level"
ATT_POST_FREQ_DESC "Attendance: post time period"
ATT_POST_ADA "Attendance: post average daily attendance"
ATT_POST_SCHOOL_OPEN "Attendance: post number of days school open"
ATT_POST_MISSING "Attendance: post number of days missed"
ATT_POST_NOT_ENROLLED "Attendance: post number of days not enrolled"
ATT_POST_TRACK "Attendance: post performance level"
ATT_ADA_CHANGE "Attendance: pre to post change in average daily attendance"
ATT_ADA_CHANGE_TYPE "Attendance: pre to post change in average daily attendance (degree)"
ATT_INC_BY_2_PERC_PT "Attendance: pre to post increase in ADA by at least 2 percentage points?"
ATT_PERF_CHANGE_LOCAL "Attendance: pre to post change in performance level"
ATT_OG_EOY_LT_90_TO_GTE "Attendance: did the student start with <90% ADA and move to >=90% ADA?"
ATT_MY_FREQ_DESC "Attendance: mid-year time period"
ATT_MY_ADA "Attendance: mid-year average daily attendance"
ATT_MY_TRACK "Attendance: mid-year performance level"
ATT_MY_ADA_CHANGE "Attendance: pre to mid-year change in average daily attendance"
ATT_MY_ADA_CHANGE_TYPE "Attendance: pre to mid-year change in average daily attendance (degree)"
ATT_MY_INC_BY_2_PERC_PT "Attendance: pre to mid-year increase in ADA by at least 2 percentage points?"
ATT_MY_PERF_CHANGE_LOCAL "Attendance: pre to mid-year change in performance level"
ATT_OG_MY_LT_90_TO_GTE "Attendance: did the student start with <90% ADA and move to >= 90% ADA at mid-year?".
EXECUTE.
SORT CASES BY cysdStudentID (A).
EXECUTE.

***** Prep final dataset for merge.
DATASET ACTIVATE FINALDATASET.
SORT CASES BY cysdStudentID (A).
EXECUTE.

***** Merge student IDs to final dataset.
MATCH FILES /FILE = FINALDATASET
   /TABLE = ATTPerf
   /BY cysdStudentID.
DATASET NAME FINALDATASET.
EXECUTE.

***** No longer need the attendance dataset.
DATASET CLOSE ATTPerf.

******************************************************************************************************************************************************
***** Calculate Met/Not Met Enrollment and Dosage Variables.
******************************************************************************************************************************************************

***** Calculate Met/Not Met Enrollment Variables -- USE THESE FOR ANALYSIS TO COUNT/SELECT OFFICIAL FL #s.
IF (IALIT = 1 & EnrollDate.LIT >= DATE.MDY(07,1,2014) & EnrollDate.LIT <= XDATE.DATE($TIME) &
ExitDate.LIT >= DATE.MDY(07,01,2014) & ExitDate.LIT <= XDATE.DATE($TIME) & LITEnroll > 0) LITOfficialFL = 1.
IF (IALIT = 0 & EnrollDate.LIT >= DATE.MDY(07,1,2014) & EnrollDate.LIT <= XDATE.DATE($TIME) &
ExitDate.LIT >= DATE.MDY(07,01,2014) & ExitDate.LIT <= XDATE.DATE($TIME) & LITEnroll > 0) LITOfficialFL = 0.
IF (IAMTH = 1 & EnrollDate.MTH >= DATE.MDY(07,1,2014) & EnrollDate.MTH <= XDATE.DATE($TIME) &
ExitDate.MTH >= DATE.MDY(07,01,2014) & ExitDate.MTH <= XDATE.DATE($TIME) & MTHEnroll > 0) MTHOfficialFL = 1.
IF (IAMTH = 0 & EnrollDate.MTH >= DATE.MDY(07,1,2014) & EnrollDate.MTH <= XDATE.DATE($TIME) &
ExitDate.MTH >= DATE.MDY(07,01,2014) & ExitDate.MTH <= XDATE.DATE($TIME) & MTHEnroll > 0) MTHOfficialFL = 0.
IF (IAATT = 1 & EnrollDate.ATT >= DATE.MDY(07,1,2014) & EnrollDate.ATT <= XDATE.DATE($TIME) &
ExitDate.ATT >= DATE.MDY(07,01,2014) & ExitDate.ATT <= XDATE.DATE($TIME) & ATTEnroll > 0) ATTOfficialFL = 1.
IF (IAATT = 0 & EnrollDate.ATT >= DATE.MDY(07,1,2014) & EnrollDate.ATT <= XDATE.DATE($TIME) &
ExitDate.ATT >= DATE.MDY(07,01,2014) & ExitDate.ATT <= XDATE.DATE($TIME) & ATTEnroll > 0) ATTOfficialFL = 0.
IF (IABEH = 1 & EnrollDate.BEH >= DATE.MDY(07,1,2014) & EnrollDate.BEH <= XDATE.DATE($TIME) &
ExitDate.BEH >= DATE.MDY(07,01,2014) & ExitDate.BEH <= XDATE.DATE($TIME) & BEHEnroll > 0) BEHOfficialFL = 1.
IF (IABEH = 0 & EnrollDate.BEH >= DATE.MDY(07,1,2014) & EnrollDate.BEH <= XDATE.DATE($TIME) &
ExitDate.BEH >= DATE.MDY(07,01,2014) & ExitDate.BEH <= XDATE.DATE($TIME) & BEHEnroll > 0) BEHOfficialFL = 0.
VARIABLE LABELS LITOfficialFL "ENROLL ACTUAL\nNumber of Students Enrolled 30+ Days (ELA/Literacy, with overlap)"
   MTHOfficialFL "ENROLL ACTUAL\nNumber of Students Enrolled (Math, with overlap)"
   ATTOfficialFL "ENROLL ACTUAL\nNumber of Students Enrolled (Attendance, with overlap)"
   BEHOfficialFL "ENROLL ACTUAL\nNumber of Students Enrolled (Behavior, with overlap)".
VALUE LABELS LITOfficialFL MTHOfficialFL ATTOfficialFL BEHOfficialFL 0 "Enrolled, no IA-assignment"
   1 "Official FL: Enrolled and IA-assigned".
EXECUTE.

******************************************************************************************************************************************************
***** OFFICIAL FOCUS LISTS.
******************************************************************************************************************************************************
***** Calculate Met/Not Met Dosage Variables.
***** Attendance/Behavior "Dosage".
IF (ATTOfficialFL = 1 & ATTEnroll >= 56) ATTMet56Dose = 1.
IF (ATTOfficialFL = 1 & ATTEnroll < 56) ATTMet56Dose = 0.
IF (BEHOfficialFL = 1 & BEHEnroll >= 56) BEHMet56Dose = 1.
IF (BEHOfficialFL = 1 & BEHEnroll < 56) BEHMet56Dose = 0.
VARIABLE LABELS ATTMet56Dose "DOSAGE ACTUAL\nNumber of Students Enrolled 56+ Days (Attendance, with overlap)"
   BEHMet56Dose "DOSAGE ACTUAL\nNumber of Students Enrolled 56+ Days (Behavior, with overlap)".
VALUE LABELS ATTMet56Dose BEHMet56Dose 0 "Did not meet 56+ day dosage threshold"
   1 "Met 56+ day dosage threshold".
*****     RSO - October Dosage Goals.
IF (LITOfficialFL = 1 & (TotalDosage.LIT >= OCT.ELA.DosageGoal.Minutes)) LITMetOCTDose = 1.
IF (LITOfficialFL = 1 & (TotalDosage.LIT < OCT.ELA.DosageGoal.Minutes)) LITMetOCTDose = 0.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH >= OCT.MTH.DosageGoal.Minutes)) MTHMetOCTDose = 1.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH < OCT.MTH.DosageGoal.Minutes)) MTHMetOCTDose = 0.
VARIABLE LABELS LITMetOCTDose "DOSAGE ACTUAL\nNumber of Students Meeting ELA/Literacy OCTOBER Dosage Benchmark (with overlap)"
   MTHMetOCTDose "DOSAGE ACTUAL\nNumber of Students Meeting Math OCTOBER Dosage Benchmark (with overlap)".
VALUE LABELS LITMetOCTDose 0 "Did not meet OCTOBER literacy dosage goal"
   1 "Met OCTOBER literacy dosage goal".
VALUE LABELS MTHMetOCTDose 0 "Did not meet OCTOBER math dosage goal"
   1 "Met OCTOBER math dosage goal".
*****     RSO - November Dosage Goals.
IF (LITOfficialFL = 1 & (TotalDosage.LIT >= NOV.ELA.DosageGoal.Minutes)) LITMetNOVDose = 1.
IF (LITOfficialFL = 1 & (TotalDosage.LIT < NOV.ELA.DosageGoal.Minutes)) LITMetNOVDose = 0.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH >= NOV.MTH.DosageGoal.Minutes)) MTHMetNOVDose = 1.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH < NOV.MTH.DosageGoal.Minutes)) MTHMetNOVDose = 0.
VARIABLE LABELS LITMetNOVDose "DOSAGE ACTUAL\nNumber of Students Meeting ELA/Literacy NOVEMBER Dosage Benchmark (with overlap)"
   MTHMetNOVDose "DOSAGE ACTUAL\nNumber of Students Meeting Math NOVEMBER Dosage Benchmark (with overlap)".
VALUE LABELS LITMetNOVDose 0 "Did not meet NOVEMBER literacy dosage goal"
   1 "Met NOVEMBER literacy dosage goal".
VALUE LABELS MTHMetNOVDose 0 "Did not meet NOVEMBER math dosage goal"
   1 "Met NOVEMBER math dosage goal".
*****     RSO - December Dosage Goals.
IF (LITOfficialFL = 1 & (TotalDosage.LIT >= DEC.ELA.DosageGoal.Minutes)) LITMetDECDose = 1.
IF (LITOfficialFL = 1 & (TotalDosage.LIT < DEC.ELA.DosageGoal.Minutes)) LITMetDECDose = 0.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH >= DEC.MTH.DosageGoal.Minutes)) MTHMetDECDose = 1.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH < DEC.MTH.DosageGoal.Minutes)) MTHMetDECDose = 0.
VARIABLE LABELS LITMetDECDose "DOSAGE ACTUAL\nNumber of Students Meeting ELA/Literacy DECEMBER Dosage Benchmark (with overlap)"
   MTHMetDECDose "DOSAGE ACTUAL\nNumber of Students Meeting Math DECEMBER Dosage Benchmark (with overlap)".
VALUE LABELS LITMetDECDose 0 "Did not meet DECEMBER literacy dosage goal"
   1 "Met DECEMBER literacy dosage goal".
VALUE LABELS MTHMetDECDose 0 "Did not meet DECEMBER math dosage goal"
   1 "Met DECEMBER math dosage goal".
*****     RSO - January Dosage Goals.
IF (LITOfficialFL = 1 & (TotalDosage.LIT >= JAN.ELA.DosageGoal.Minutes)) LITMetJANDose = 1.
IF (LITOfficialFL = 1 & (TotalDosage.LIT < JAN.ELA.DosageGoal.Minutes)) LITMetJANDose = 0.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH >= JAN.MTH.DosageGoal.Minutes)) MTHMetJANDose = 1.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH < JAN.MTH.DosageGoal.Minutes)) MTHMetJANDose = 0.
VARIABLE LABELS LITMetJANDose "DOSAGE ACTUAL\nNumber of Students Meeting ELA/Literacy JANUARY Dosage Benchmark (with overlap)"
   MTHMetJANDose "DOSAGE ACTUAL\nNumber of Students Meeting Math JANUARY Dosage Benchmark (with overlap)".
VALUE LABELS LITMetJANDose 0 "Did not meet JANUARY literacy dosage goal"
   1 "Met JANUARY literacy dosage goal".
VALUE LABELS MTHMetJANDose 0 "Did not meet JANUARY math dosage goal"
   1 "Met JANUARY math dosage goal".
*****     RSO - February Dosage Goals.
IF (LITOfficialFL = 1 & (TotalDosage.LIT >= FEB.ELA.DosageGoal.Minutes)) LITMetFEBDose = 1.
IF (LITOfficialFL = 1 & (TotalDosage.LIT < FEB.ELA.DosageGoal.Minutes)) LITMetFEBDose = 0.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH >= FEB.MTH.DosageGoal.Minutes)) MTHMetFEBDose = 1.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH < FEB.MTH.DosageGoal.Minutes)) MTHMetFEBDose = 0.
VARIABLE LABELS LITMetFEBDose "DOSAGE ACTUAL\nNumber of Students Meeting ELA/Literacy FEBRUARY Dosage Benchmark (with overlap)"
   MTHMetFEBDose "DOSAGE ACTUAL\nNumber of Students Meeting Math FEBRUARY Dosage Benchmark (with overlap)".
VALUE LABELS LITMetFEBDose 0 "Did not meet FEBRUARY literacy dosage goal"
   1 "Met FEBRUARY literacy dosage goal".
VALUE LABELS MTHMetFEBDose 0 "Did not meet FEBRUARY math dosage goal"
   1 "Met FEBRUARY math dosage goal".
*****     RSO - March Dosage Goals.
IF (LITOfficialFL = 1 & (TotalDosage.LIT >= MAR.ELA.DosageGoal.Minutes)) LITMetMARDose = 1.
IF (LITOfficialFL = 1 & (TotalDosage.LIT < MAR.ELA.DosageGoal.Minutes)) LITMetMARDose = 0.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH >= MAR.MTH.DosageGoal.Minutes)) MTHMetMARDose = 1.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH < MAR.MTH.DosageGoal.Minutes)) MTHMetMARDose = 0.
VARIABLE LABELS LITMetMARDose "DOSAGE ACTUAL\nNumber of Students Meeting ELA/Literacy MARCH Dosage Benchmark (with overlap)"
   MTHMetMARDose "DOSAGE ACTUAL\nNumber of Students Meeting Math MARCH Dosage Benchmark (with overlap)".
VALUE LABELS LITMetMARDose 0 "Did not meet MARCH literacy dosage goal"
   1 "Met MARCH literacy dosage goal".
VALUE LABELS MTHMetMARDose 0 "Did not meet MARCH math dosage goal"
   1 "Met MARCH math dosage goal".
*****     RSO - April Dosage Goals.
IF (LITOfficialFL = 1 & (TotalDosage.LIT >= APR.ELA.DosageGoal.Minutes)) LITMetAPRDose = 1.
IF (LITOfficialFL = 1 & (TotalDosage.LIT < APR.ELA.DosageGoal.Minutes)) LITMetAPRDose = 0.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH >= APR.MTH.DosageGoal.Minutes)) MTHMetAPRDose = 1.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH < APR.MTH.DosageGoal.Minutes)) MTHMetAPRDose = 0.
VARIABLE LABELS LITMetAPRDose "DOSAGE ACTUAL\nNumber of Students Meeting ELA/Literacy APRIL Dosage Benchmark (with overlap)"
   MTHMetAPRDose "DOSAGE ACTUAL\nNumber of Students Meeting Math APRIL Dosage Benchmark (with overlap)".
VALUE LABELS LITMetAPRDose 0 "Did not meet APRIL literacy dosage goal"
   1 "Met APRIL literacy dosage goal".
VALUE LABELS MTHMetAPRDose 0 "Did not meet APRIL math dosage goal"
   1 "Met APRIL math dosage goal".
*****     RSO - May Dosage Goals.
IF (LITOfficialFL = 1 & (TotalDosage.LIT >= MAY.ELA.DosageGoal.Minutes)) LITMetMAYDose = 1.
IF (LITOfficialFL = 1 & (TotalDosage.LIT < MAY.ELA.DosageGoal.Minutes)) LITMetMAYDose = 0.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH >= MAY.MTH.DosageGoal.Minutes)) MTHMetMAYDose = 1.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH < MAY.MTH.DosageGoal.Minutes)) MTHMetMAYDose = 0.
VARIABLE LABELS LITMetMAYDose "DOSAGE ACTUAL\nNumber of Students Meeting ELA/Literacy MAY Dosage Benchmark (with overlap)"
   MTHMetMAYDose "DOSAGE ACTUAL\nNumber of Students Meeting Math MAY Dosage Benchmark (with overlap)".
VALUE LABELS LITMetMAYDose 0 "Did not meet MAY literacy dosage goal"
   1 "Met MAY literacy dosage goal".
VALUE LABELS MTHMetMAYDose 0 "Did not meet MAY math dosage goal"
   1 "Met MAY math dosage goal".
*****     RSO - June Dosage Goals.
IF (LITOfficialFL = 1 & (TotalDosage.LIT >= JUN.ELA.DosageGoal.Minutes)) LITMetJUNDose = 1.
IF (LITOfficialFL = 1 & (TotalDosage.LIT < JUN.ELA.DosageGoal.Minutes)) LITMetJUNDose = 0.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH >= JUN.MTH.DosageGoal.Minutes)) MTHMetJUNDose = 1.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH < JUN.MTH.DosageGoal.Minutes)) MTHMetJUNDose = 0.
VARIABLE LABELS LITMetJUNDose "DOSAGE ACTUAL\nNumber of Students Meeting ELA/Literacy JUNE Dosage Benchmark (with overlap)"
   MTHMetJUNDose "DOSAGE ACTUAL\nNumber of Students Meeting Math JUNE Dosage Benchmark (with overlap)".
VALUE LABELS LITMetJUNDose 0 "Did not meet JUNE literacy dosage goal"
   1 "Met JUNE literacy dosage goal".
VALUE LABELS MTHMetJUNDose 0 "Did not meet JUNE math dosage goal"
   1 "Met JUNE math dosage goal".
******************************************************************************************************************************************************
***** END OF OFFICIAL FOCUS LISTS SYNTAX BLOCK.
******************************************************************************************************************************************************

******************************************************************************************************************************************************
***** UNOFFICIAL FOCUS LISTS.
******************************************************************************************************************************************************
***** Create variable to count unofficial focus lists.
IF (LITOfficialFL = 0) LITNotOfficialFL = 1.
IF (MTHOfficialFL = 0) MTHNotOfficialFL = 1.
IF (ATTOfficialFL = 0) ATTNotOfficialFL = 1.
IF (BEHOfficialFL = 0) BEHNotOfficialFL = 1.
VARIABLE LABELS LITNotOfficialFL "ENROLL RESULT\nUNOFFICIAL FL\nNumber of Students Enrolled 30+ Days (ELA/Literacy, with overlap)"
   MTHNotOfficialFL "ENROLL RESULT\nUNOFFICIAL FL\nNumber of Students Enrolled (Math, with overlap)"
   ATTNotOfficialFL "ENROLL RESULT\nUNOFFICIAL FL\nNumber of Students Enrolled (Attendance, with overlap)"
   BEHNotOfficialFL "ENROLL RESULT\nUNOFFICIAL FL\nNumber of Students Enrolled (Behavior, with overlap)".
VALUE LABELS LITNotOfficialFL MTHNotOfficialFL ATTNotOfficialFL BEHNotOfficialFL 0 "Enrolled, no IA-assignment"
   1 "Official FL: Enrolled and IA-assigned".
EXECUTE.
***** Calculate Met/Not Met Dosage Variables.
***** Attendance/Behavior "Dosage".
IF (ATTOfficialFL = 0 & ATTEnroll >= 56) NotFLATTMet56Dose = 1.
IF (ATTOfficialFL = 0 & ATTEnroll < 56) NotFLATTMet56Dose = 0.
IF (BEHOfficialFL = 0 & BEHEnroll >= 56) NotFLBEHMet56Dose = 1.
IF (BEHOfficialFL = 0 & BEHEnroll < 56) NotFLBEHMet56Dose = 0.
VARIABLE LABELS NotFLATTMet56Dose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Enrolled 56+ Days (Attendance, with overlap)"
   NotFLBEHMet56Dose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Enrolled 56+ Days (Behavior, with overlap)".
VALUE LABELS NotFLATTMet56Dose NotFLBEHMet56Dose 0 "Did not meet 56+ day dosage threshold"
   1 "Met 56+ day dosage threshold".
*****     RSO - October Dosage Goals.
IF (LITOfficialFL = 0 & (TotalDosage.LIT >= OCT.ELA.DosageGoal.Minutes)) NotFLLITMetOCTDose = 1.
IF (LITOfficialFL = 0 & (TotalDosage.LIT < OCT.ELA.DosageGoal.Minutes)) NotFLLITMetOCTDose = 0.
IF (MTHOfficialFL = 0 & (TotalDosage.MTH >= OCT.MTH.DosageGoal.Minutes)) NotFLMTHMetOCTDose = 1.
IF (MTHOfficialFL = 0 & (TotalDosage.MTH < OCT.MTH.DosageGoal.Minutes)) NotFLMTHMetOCTDose = 0.
VARIABLE LABELS NotFLLITMetOCTDose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Meeting ELA/Literacy OCTOBER Dosage Benchmark (with overlap)"
   NotFLMTHMetOCTDose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Meeting Math OCTOBER Dosage Benchmark (with overlap)".
VALUE LABELS NotFLLITMetOCTDose 0 "Did not meet OCTOBER literacy dosage goal"
   1 "Met OCTOBER literacy dosage goal".
VALUE LABELS NotFLMTHMetOCTDose 0 "Did not meet OCTOBER math dosage goal"
   1 "Met OCTOBER math dosage goal".
*****     RSO - November Dosage Goals.
IF (LITOfficialFL = 0 & (TotalDosage.LIT >= NOV.ELA.DosageGoal.Minutes)) NotFLLITMetNOVDose = 1.
IF (LITOfficialFL = 0 & (TotalDosage.LIT < NOV.ELA.DosageGoal.Minutes)) NotFLLITMetNOVDose = 0.
IF (MTHOfficialFL = 0 & (TotalDosage.MTH >= NOV.MTH.DosageGoal.Minutes)) NotFLMTHMetNOVDose = 1.
IF (MTHOfficialFL = 0 & (TotalDosage.MTH < NOV.MTH.DosageGoal.Minutes)) NotFLMTHMetNOVDose = 0.
VARIABLE LABELS NotFLLITMetNOVDose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Meeting ELA/Literacy NOVEMBER Dosage Benchmark (with overlap)"
   NotFLMTHMetNOVDose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Meeting Math NOVEMBER Dosage Benchmark (with overlap)".
VALUE LABELS NotFLLITMetNOVDose 0 "Did not meet NOVEMBER literacy dosage goal"
   1 "Met NOVEMBER literacy dosage goal".
VALUE LABELS NotFLMTHMetNOVDose 0 "Did not meet NOVEMBER math dosage goal"
   1 "Met NOVEMBER math dosage goal".
*****     RSO - December Dosage Goals.
IF (LITOfficialFL = 0 & (TotalDosage.LIT >= DEC.ELA.DosageGoal.Minutes)) NotFLLITMetDECDose = 1.
IF (LITOfficialFL = 0 & (TotalDosage.LIT < DEC.ELA.DosageGoal.Minutes)) NotFLLITMetDECDose = 0.
IF (MTHOfficialFL = 0 & (TotalDosage.MTH >= DEC.MTH.DosageGoal.Minutes)) NotFLMTHMetDECDose = 1.
IF (MTHOfficialFL = 0 & (TotalDosage.MTH < DEC.MTH.DosageGoal.Minutes)) NotFLMTHMetDECDose = 0.
VARIABLE LABELS NotFLLITMetDECDose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Meeting ELA/Literacy DECEMBER Dosage Benchmark (with overlap)"
   NotFLMTHMetDECDose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Meeting Math DECEMBER Dosage Benchmark (with overlap)".
VALUE LABELS NotFLLITMetDECDose 0 "Did not meet DECEMBER literacy dosage goal"
   1 "Met DECEMBER literacy dosage goal".
VALUE LABELS NotFLMTHMetDECDose 0 "Did not meet DECEMBER math dosage goal"
   1 "Met DECEMBER math dosage goal".
*****     RSO - January Dosage Goals.
IF (LITOfficialFL = 0 & (TotalDosage.LIT >= JAN.ELA.DosageGoal.Minutes)) NotFLLITMetJANDose = 1.
IF (LITOfficialFL = 0 & (TotalDosage.LIT < JAN.ELA.DosageGoal.Minutes)) NotFLLITMetJANDose = 0.
IF (MTHOfficialFL = 0 & (TotalDosage.MTH >= JAN.MTH.DosageGoal.Minutes)) NotFLMTHMetJANDose = 1.
IF (MTHOfficialFL = 0 & (TotalDosage.MTH < JAN.MTH.DosageGoal.Minutes)) NotFLMTHMetJANDose = 0.
VARIABLE LABELS NotFLLITMetJANDose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Meeting ELA/Literacy JANUARY Dosage Benchmark (with overlap)"
   NotFLMTHMetJANDose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Meeting Math JANUARY Dosage Benchmark (with overlap)".
VALUE LABELS NotFLLITMetJANDose 0 "Did not meet JANUARY literacy dosage goal"
   1 "Met JANUARY literacy dosage goal".
VALUE LABELS NotFLMTHMetJANDose 0 "Did not meet JANUARY math dosage goal"
   1 "Met JANUARY math dosage goal".
*****     RSO - February Dosage Goals.
IF (LITOfficialFL = 0 & (TotalDosage.LIT >= FEB.ELA.DosageGoal.Minutes)) NotFLLITMetFEBDose = 1.
IF (LITOfficialFL = 0 & (TotalDosage.LIT < FEB.ELA.DosageGoal.Minutes)) NotFLLITMetFEBDose = 0.
IF (MTHOfficialFL = 0 & (TotalDosage.MTH >= FEB.MTH.DosageGoal.Minutes)) NotFLMTHMetFEBDose = 1.
IF (MTHOfficialFL = 0 & (TotalDosage.MTH < FEB.MTH.DosageGoal.Minutes)) NotFLMTHMetFEBDose = 0.
VARIABLE LABELS NotFLLITMetFEBDose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Meeting ELA/Literacy FEBRUARY Dosage Benchmark (with overlap)"
   NotFLMTHMetFEBDose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Meeting Math FEBRUARY Dosage Benchmark (with overlap)".
VALUE LABELS NotFLLITMetFEBDose 0 "Did not meet FEBRUARY literacy dosage goal"
   1 "Met FEBRUARY literacy dosage goal".
VALUE LABELS NotFLMTHMetFEBDose 0 "Did not meet FEBRUARY math dosage goal"
   1 "Met FEBRUARY math dosage goal".
*****     RSO - March Dosage Goals.
IF (LITOfficialFL = 0 & (TotalDosage.LIT >= MAR.ELA.DosageGoal.Minutes)) NotFLLITMetMARDose = 1.
IF (LITOfficialFL = 0 & (TotalDosage.LIT < MAR.ELA.DosageGoal.Minutes)) NotFLLITMetMARDose = 0.
IF (MTHOfficialFL = 0 & (TotalDosage.MTH >= MAR.MTH.DosageGoal.Minutes)) NotFLMTHMetMARDose = 1.
IF (MTHOfficialFL = 0 & (TotalDosage.MTH < MAR.MTH.DosageGoal.Minutes)) NotFLMTHMetMARDose = 0.
VARIABLE LABELS NotFLLITMetMARDose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Meeting ELA/Literacy MARCH Dosage Benchmark (with overlap)"
   NotFLMTHMetMARDose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Meeting Math MARCH Dosage Benchmark (with overlap)".
VALUE LABELS NotFLLITMetMARDose 0 "Did not meet MARCH literacy dosage goal"
   1 "Met MARCH literacy dosage goal".
VALUE LABELS NotFLMTHMetMARDose 0 "Did not meet MARCH math dosage goal"
   1 "Met MARCH math dosage goal".
*****     RSO - April Dosage Goals.
IF (LITOfficialFL = 0 & (TotalDosage.LIT >= APR.ELA.DosageGoal.Minutes)) NotFLLITMetAPRDose = 1.
IF (LITOfficialFL = 0 & (TotalDosage.LIT < APR.ELA.DosageGoal.Minutes)) NotFLLITMetAPRDose = 0.
IF (MTHOfficialFL = 0 & (TotalDosage.MTH >= APR.MTH.DosageGoal.Minutes)) NotFLMTHMetAPRDose = 1.
IF (MTHOfficialFL = 0 & (TotalDosage.MTH < APR.MTH.DosageGoal.Minutes)) NotFLMTHMetAPRDose = 0.
VARIABLE LABELS NotFLLITMetAPRDose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Meeting ELA/Literacy APRIL Dosage Benchmark (with overlap)"
   NotFLMTHMetAPRDose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Meeting Math APRIL Dosage Benchmark (with overlap)".
VALUE LABELS NotFLLITMetAPRDose 0 "Did not meet APRIL literacy dosage goal"
   1 "Met APRIL literacy dosage goal".
VALUE LABELS NotFLMTHMetAPRDose 0 "Did not meet APRIL math dosage goal"
   1 "Met APRIL math dosage goal".
*****     RSO - May Dosage Goals.
IF (LITOfficialFL = 0 & (TotalDosage.LIT >= MAY.ELA.DosageGoal.Minutes)) NotFLLITMetMAYDose = 1.
IF (LITOfficialFL = 0 & (TotalDosage.LIT < MAY.ELA.DosageGoal.Minutes)) NotFLLITMetMAYDose = 0.
IF (MTHOfficialFL = 0 & (TotalDosage.MTH >= MAY.MTH.DosageGoal.Minutes)) NotFLMTHMetMAYDose = 1.
IF (MTHOfficialFL = 0 & (TotalDosage.MTH < MAY.MTH.DosageGoal.Minutes)) NotFLMTHMetMAYDose = 0.
VARIABLE LABELS NotFLLITMetMAYDose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Meeting ELA/Literacy MAY Dosage Benchmark (with overlap)"
   NotFLMTHMetMAYDose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Meeting Math MAY Dosage Benchmark (with overlap)".
VALUE LABELS NotFLLITMetMAYDose 0 "Did not meet MAY literacy dosage goal"
   1 "Met MAY literacy dosage goal".
VALUE LABELS NotFLMTHMetMAYDose 0 "Did not meet MAY math dosage goal"
   1 "Met MAY math dosage goal".
*****     RSO - June Dosage Goals.
IF (LITOfficialFL = 0 & (TotalDosage.LIT >= JUN.ELA.DosageGoal.Minutes)) NotFLLITMetJUNDose = 1.
IF (LITOfficialFL = 0 & (TotalDosage.LIT < JUN.ELA.DosageGoal.Minutes)) NotFLLITMetJUNDose = 0.
IF (MTHOfficialFL = 0 & (TotalDosage.MTH >= JUN.MTH.DosageGoal.Minutes)) NotFLMTHMetJUNDose = 1.
IF (MTHOfficialFL = 0 & (TotalDosage.MTH < JUN.MTH.DosageGoal.Minutes)) NotFLMTHMetJUNDose = 0.
VARIABLE LABELS NotFLLITMetJUNDose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Meeting ELA/Literacy JUNE Dosage Benchmark (with overlap)"
   NotFLMTHMetJUNDose "DOSAGE RESULTS\nUNOFFICIAL FL\nNumber of Students Meeting Math JUNE Dosage Benchmark (with overlap)".
VALUE LABELS NotFLLITMetJUNDose 0 "Did not meet JUNE literacy dosage goal"
   1 "Met JUNE literacy dosage goal".
VALUE LABELS NotFLMTHMetJUNDose 0 "Did not meet JUNE math dosage goal"
   1 "Met JUNE math dosage goal".
******************************************************************************************************************************************************
***** END OF UNOFFICIAL FOCUS LISTS SYNTAX BLOCK.
******************************************************************************************************************************************************

******************************************************************************************************************************************************
***** Calculate additional variables -- FOR LEAD MEASURES AND OPERATING GOALS.
******************************************************************************************************************************************************

***** LEAD MEASURES.
*****     80% of students on Lit/ELA and Math Focus Lists fit the definition of off-track or sliding off-track.
*****     For 3rd-5th grade only look at assessments, for 6th-9th grade look at assessments OR course grades.
*****          ELA.
IF ((StudentGrade >= 3 & StudentGrade <= 5 & DNSchool = 0 & LITOfficialFL = 1 & (LITAssess_PRE_TRACK_EVAL = "SLIDING" | 
LITAssess_PRE_TRACK_EVAL = "OFF TRACK")) | (StudentGrade >= 6 & StudentGrade <= 9 & DNSchool = 0 & LITOfficialFL = 1 &
(LITAssess_PRE_TRACK_EVAL = "SLIDING" | LITAssess_PRE_TRACK_EVAL = "OFF TRACK" | ELACG_PRE_TRACK = "SLIDING" |
ELACG_PRE_TRACK = "OFF TRACK"))) LEAD_LIT39_SOS = 1.
EXECUTE.
IF (MISSING(LEAD_LIT39_SOS) & ((StudentGrade >= 3 & StudentGrade <= 5 & DNSchool = 0 & LITOfficialFL = 1 &
(LITAssess_PRE_TRACK_EVAL = "ON TRACK")) | (StudentGrade >= 6 & StudentGrade <= 9 & DNSchool = 0 & LITOfficialFL = 1 &
(LITAssess_PRE_TRACK_EVAL = "ON TRACK" | ELACG_PRE_TRACK = "ON TRACK")))) LEAD_LIT39_SOS = 0.
*****          MTH.
IF ((StudentGrade >= 3 & StudentGrade <= 5 & DNSchool = 0 & MTHOfficialFL = 1 & (MTHAssess_PRE_TRACK_EVAL = "SLIDING" | 
MTHAssess_PRE_TRACK_EVAL = "OFF TRACK")) | (StudentGrade >= 6 & StudentGrade <= 9 & DNSchool = 0 & MTHOfficialFL = 1 &
(MTHAssess_PRE_TRACK_EVAL = "SLIDING" | MTHAssess_PRE_TRACK_EVAL = "OFF TRACK" | MTHCG_PRE_TRACK = "SLIDING" |
MTHCG_PRE_TRACK = "OFF TRACK"))) LEAD_MTH39_SOS = 1.
EXECUTE.
IF (MISSING(LEAD_MTH39_SOS) & ((StudentGrade >= 3 & StudentGrade <= 5 & DNSchool = 0 & MTHOfficialFL = 1 &
(MTHAssess_PRE_TRACK_EVAL = "ON TRACK")) | (StudentGrade >= 6 & StudentGrade <= 9 & DNSchool = 0 & MTHOfficialFL = 1 &
(MTHAssess_PRE_TRACK_EVAL = "ON TRACK" | MTHCG_PRE_TRACK = "ON TRACK")))) LEAD_MTH39_SOS = 0.
*****     50% of students on Attendance Focus List fit the definition of off-track or sliding off-track.
IF (StudentGrade >= 6 & StudentGrade <= 9 & DNSchool = 0 & ATTOfficialFL = 1 & ATT_PRE_ADA < 0.9) LEAD_ATT69_StartLT90ADA = 1.
IF (StudentGrade >= 6 & StudentGrade <= 9 & DNSchool = 0 & ATTOfficialFL = 1 & ATT_PRE_ADA >= 0.9) LEAD_ATT69_StartLT90ADA = 0.
VARIABLE LABELS LEAD_LIT39_SOS "Lead Measure: Literacy FL Composition: Students starting off-track/sliding"
   LEAD_MTH39_SOS "Lead Measure: Math FL Composition: Students starting off-track/sliding"
   LEAD_ATT69_StartLT90ADA "Lead Measure: Attendance FL Composition: Students starting with less than 90% ADA".
EXECUTE.

***** Lead Measure breakdown (not necessary for attendance, since there's no overlap in measures).
*****     Literacy assessments.
IF (StudentGrade >= 3 & StudentGrade <= 9 & DNSchool = 0 & LITOfficialFL = 1 & LITAssess_PRE_TRACK_EVAL ~= "") LITAssess_FLComp_SampleSize = 1.
IF (StudentGrade >= 3 & StudentGrade <= 9 & DNSchool = 0 & LITOfficialFL = 1 & LITAssess_PRE_TRACK_EVAL = "") LITAssess_FLComp_SampleSize = 0.
IF (StudentGrade >= 3 & StudentGrade <= 9 & DNSchool = 0 & LITOfficialFL = 1 & (LITAssess_PRE_TRACK_EVAL = "SLIDING" |
LITAssess_PRE_TRACK_EVAL = "OFF TRACK")) LITAssess_FLComp_SOS = 1.
IF (StudentGrade >= 3 & StudentGrade <= 9 & DNSchool = 0 & LITOfficialFL = 1 & LITAssess_PRE_TRACK_EVAL = "ON TRACK") LITAssess_FLComp_SOS = 0.
*****     ELA course grades.
IF (StudentGrade >= 6 & StudentGrade <= 9 & DNSchool = 0 & LITOfficialFL = 1 & ELACG_PRE_TRACK ~= "") ELACG_FLComp_SampleSize = 1.
IF (StudentGrade >= 6 & StudentGrade <= 9 & DNSchool = 0 & LITOfficialFL = 1 & ELACG_PRE_TRACK = "") ELACG_FLComp_SampleSize = 0.
IF (StudentGrade >= 6 & StudentGrade <= 9 & DNSchool = 0 & LITOfficialFL = 1 & (ELACG_PRE_TRACK = "SLIDING" |
ELACG_PRE_TRACK = "OFF TRACK")) ELACG_FLComp_SOS = 1.
IF (StudentGrade >= 6 & StudentGrade <= 9 & DNSchool = 0 & LITOfficialFL = 1 & ELACG_PRE_TRACK = "ON TRACK") ELACG_FLComp_SOS = 0.
*****     Math assessments.
IF (StudentGrade >= 3 & StudentGrade <= 9 & DNSchool = 0 & MTHOfficialFL = 1 & MTHAssess_PRE_TRACK_EVAL ~= "") MTHAssess_FLComp_SampleSize = 1.
IF (StudentGrade >= 3 & StudentGrade <= 9 & DNSchool = 0 & MTHOfficialFL = 1 & MTHAssess_PRE_TRACK_EVAL = "") MTHAssess_FLComp_SampleSize = 0.
IF (StudentGrade >= 3 & StudentGrade <= 9 & DNSchool = 0 & MTHOfficialFL = 1 & (MTHAssess_PRE_TRACK_EVAL = "SLIDING" |
MTHAssess_PRE_TRACK_EVAL = "OFF TRACK")) MTHAssess_FLComp_SOS = 1.
IF (StudentGrade >= 3 & StudentGrade <= 9 & DNSchool = 0 & MTHOfficialFL = 1 & MTHAssess_PRE_TRACK_EVAL = "ON TRACK") MTHAssess_FLComp_SOS = 0.
*****     Math course grades.
IF (StudentGrade >= 6 & StudentGrade <= 9 & DNSchool = 0 & MTHOfficialFL = 1 & MTHCG_PRE_TRACK ~= "") MTHCG_FLComp_SampleSize = 1.
IF (StudentGrade >= 6 & StudentGrade <= 9 & DNSchool = 0 & MTHOfficialFL = 1 & MTHCG_PRE_TRACK = "") MTHCG_FLComp_SampleSize = 0.
IF (StudentGrade >= 6 & StudentGrade <= 9 & DNSchool = 0 & MTHOfficialFL = 1 & (MTHCG_PRE_TRACK = "SLIDING" |
MTHCG_PRE_TRACK = "OFF TRACK")) MTHCG_FLComp_SOS = 1.
IF (StudentGrade >= 6 & StudentGrade <= 9 & DNSchool = 0 & MTHOfficialFL = 1 & MTHCG_PRE_TRACK = "ON TRACK") MTHCG_FLComp_SOS = 0.

***** Addendum to Lead Measure Reports: Student-Level Analysis, Distance to Dosage Targets.
*****     Creating ELA Distance between Dosage Goals and Dosage Actuals.
COMPUTE JAN.ELA.GoalDistance.0t25 =0.
if  ( LITOfficialFL = 1 AND (TotalDosage.LIT <=(0.25*JAN.ELA.DosageGoal.Minutes))) JAN.ELA.GoalDistance.0t25=1.
COMPUTE JAN.ELA.GoalDistance.25t.5 =0.
if  ( LITOfficialFL = 1 AND (TotalDosage.LIT <=(0.5*JAN.ELA.DosageGoal.Minutes) & TotalDosage.LIT >(0.25*JAN.ELA.DosageGoal.Minutes))) JAN.ELA.GoalDistance.25t.5=1.
COMPUTE JAN.ELA.GoalDistance.5t.75 =0.
if  ( LITOfficialFL = 1 AND (TotalDosage.LIT <=(0.75*JAN.ELA.DosageGoal.Minutes) & TotalDosage.LIT >(0.5*JAN.ELA.DosageGoal.Minutes))) JAN.ELA.GoalDistance.5t.75=1.
COMPUTE JAN.ELA.GoalDistance.75to1 =0.
if  ( LITOfficialFL = 1 AND (TotalDosage.LIT < JAN.ELA.DosageGoal.Minutes & TotalDosage.LIT >(0.75*JAN.ELA.DosageGoal.Minutes))) JAN.ELA.GoalDistance.75to1 =1.
COMPUTE JAN.ELA.GoalDistance.1to1.25 =0.
if  ( LITOfficialFL = 1 AND (TotalDosage.LIT >=JAN.ELA.DosageGoal.Minutes & TotalDosage.LIT <(1.25*JAN.ELA.DosageGoal.Minutes))) JAN.ELA.GoalDistance.1to1.25 =1.
COMPUTE JAN.ELA.GoalDistance.1.25to1.5 =0.
if  ( LITOfficialFL = 1 AND (TotalDosage.LIT >= (1.25*JAN.ELA.DosageGoal.Minutes) & TotalDosage.LIT <(1.5*JAN.ELA.DosageGoal.Minutes))) JAN.ELA.GoalDistance.1.25to1.5 =1.
COMPUTE JAN.ELA.GoalDistance.1.5to1.75 =0.
if  ( LITOfficialFL = 1 AND (TotalDosage.LIT >= (1.5*JAN.ELA.DosageGoal.Minutes) & TotalDosage.LIT <(1.75*JAN.ELA.DosageGoal.Minutes))) JAN.ELA.GoalDistance.1.5to1.75 =1.
COMPUTE JAN.ELA.GoalDistance.1.75up=0.
if  ( LITOfficialFL = 1 AND (TotalDosage.LIT >= (1.75*JAN.ELA.DosageGoal.Minutes))) JAN.ELA.GoalDistance.1.75up=1.
*****     Create sample size variable.
COMPUTE JAN.ELA.GoalDistance.SampleSize= Sum(JAN.ELA.GoalDistance.0t25, JAN.ELA.GoalDistance.25t.5, JAN.ELA.GoalDistance.5t.75, JAN.ELA.GoalDistance.75to1,
JAN.ELA.GoalDistance.1to1.25, JAN.ELA.GoalDistance.1.25to1.5, JAN.ELA.GoalDistance.1.5to1.75, JAN.ELA.GoalDistance.1.75up).

VARIABLE LABELS JAN.ELA.GoalDistance.0t25 "Missed Dosage Goal by 75% or more"
JAN.ELA.GoalDistance.25t.5 "Missed Dosage Goal by 50% to 74.99%"
JAN.ELA.GoalDistance.5t.75 "Missed Dosage Goal by 25% to 49.99%" 
JAN.ELA.GoalDistance.75to1 "Missed Dosage Goal by 0.01% to 24.99%" 
JAN.ELA.GoalDistance.1to1.25 "Met or Exceeded Dosage Goal up to 25%"
JAN.ELA.GoalDistance.1.25to1.5 "Exceeded Dosage Goal by 25% to 49.99%" 
JAN.ELA.GoalDistance.1.5to1.75 "Exceeded Dosage Goal by 50% to 74.99%"
JAN.ELA.GoalDistance.1.75up "Exceeded Dosage Goal by 75% or more "
JAN.ELA.GoalDistance.SampleSize 'Total Number of Students with Calculated Goal Distance'.
VALUE LABELS JAN.ELA.GoalDistance.0t25 JAN.ELA.GoalDistance.25t.5 JAN.ELA.GoalDistance.5t.75 JAN.ELA.GoalDistance.75to1
JAN.ELA.GoalDistance.1to1.25 JAN.ELA.GoalDistance.1.25to1.5 JAN.ELA.GoalDistance.1.5to1.75
JAN.ELA.GoalDistance.1.75up 0 'Not in this category' 1 'In this category'.

COMPUTE JAN.ELA.RawGoalDistance= 99.
if LITOfficialFL = 1 Jan.ELA.RawGoalDistance=(TotalDosage.LIT-JAN.ELA.DosageGoal.Minutes)/60.
RECODE JAN.ELA.RawGoalDistance (99=SYSMIS).
VARIABLE LABELS JAN.ELA.RawGoalDistance 'Hours between January Dosage Actual and Goal'.

*****     Creating Math Distance between Dosage Goals and Dosage Actuals.
COMPUTE JAN.MTH.GoalDistance.0t25 =0.
if  ( MTHOfficialFL = 1 AND (TotalDosage.MTH <=(0.25*JAN.MTH.DosageGoal.Minutes))) JAN.MTH.GoalDistance.0t25=1.
COMPUTE JAN.MTH.GoalDistance.25t.5 =0.
if  ( MTHOfficialFL = 1 AND (TotalDosage.MTH <=(0.5*JAN.MTH.DosageGoal.Minutes) & TotalDosage.LIT >(0.25*JAN.MTH.DosageGoal.Minutes))) JAN.MTH.GoalDistance.25t.5=1.
COMPUTE JAN.MTH.GoalDistance.5t.75 =0.
if  ( MTHOfficialFL = 1 AND (TotalDosage.MTH <=(0.75*JAN.MTH.DosageGoal.Minutes) & TotalDosage.LIT >(0.5*JAN.MTH.DosageGoal.Minutes))) JAN.MTH.GoalDistance.5t.75=1.
COMPUTE JAN.MTH.GoalDistance.75to1 =0.
if  ( MTHOfficialFL = 1 AND (TotalDosage.MTH < JAN.MTH.DosageGoal.Minutes & TotalDosage.LIT >(0.75*JAN.MTH.DosageGoal.Minutes))) JAN.MTH.GoalDistance.75to1 =1.
COMPUTE JAN.MTH.GoalDistance.1to1.25 =0.
if  ( MTHOfficialFL = 1 AND (TotalDosage.MTH >=JAN.MTH.DosageGoal.Minutes & TotalDosage.LIT <(1.25*JAN.MTH.DosageGoal.Minutes))) JAN.MTH.GoalDistance.1to1.25 =1.
COMPUTE JAN.MTH.GoalDistance.1.25to1.5 =0.
if  ( MTHOfficialFL = 1 AND (TotalDosage.MTH>= (1.25*JAN.MTH.DosageGoal.Minutes) & TotalDosage.LIT <(1.5*JAN.MTH.DosageGoal.Minutes))) JAN.MTH.GoalDistance.1.25to1.5 =1.
COMPUTE JAN.MTH.GoalDistance.1.5to1.75 =0.
if  ( MTHOfficialFL = 1 AND (TotalDosage.MTH >= (1.5*JAN.MTH.DosageGoal.Minutes) & TotalDosage.LIT <(1.75*JAN.MTH.DosageGoal.Minutes))) JAN.MTH.GoalDistance.1.5to1.75 =1.
COMPUTE JAN.MTH.GoalDistance.1.75up=0.
if  ( MTHOfficialFL = 1 AND (TotalDosage.MTH >= (1.75*JAN.MTH.DosageGoal.Minutes))) JAN.MTH.GoalDistance.1.75up=1.
*****     Create sample size variable.
COMPUTE JAN.MTH.GoalDistance.SampleSize= Sum(JAN.MTH.GoalDistance.0t25, JAN.MTH.GoalDistance.25t.5, JAN.MTH.GoalDistance.5t.75, JAN.MTH.GoalDistance.75to1,
JAN.MTH.GoalDistance.1to1.25, JAN.MTH.GoalDistance.1.25to1.5, JAN.MTH.GoalDistance.1.5to1.75, JAN.MTH.GoalDistance.1.75up).

VARIABLE LABELS JAN.MTH.GoalDistance.0t25 "Missed Dosage Goal by 75% or more"
JAN.MTH.GoalDistance.25t.5 "Missed Dosage Goal by 50% to 74.99%"
JAN.MTH.GoalDistance.5t.75 "Missed Dosage Goal by 25% to 49.99%" 
JAN.MTH.GoalDistance.75to1 "Missed Dosage Goal by 0.01% to 24.99%" 
JAN.MTH.GoalDistance.1to1.25 "Met or Exceeded Dosage Goal up to 25%"
JAN.MTH.GoalDistance.1.25to1.5 "Exceeded Dosage Goal by 25% to 49.99%" 
JAN.MTH.GoalDistance.1.5to1.75 "Exceeded Dosage Goal by 50% to 74.99%"
JAN.MTH.GoalDistance.1.75up "Exceeded Dosage Goal by 75% or more "
JAN.MTH.GoalDistance.SampleSize 'Total Number of Students with Calculated Goal Distance'.
VALUE LABELS JAN.MTH.GoalDistance.0t25 JAN.MTH.GoalDistance.25t.5 JAN.MTH.GoalDistance.5t.75 JAN.MTH.GoalDistance.75to1  
JAN.MTH.GoalDistance.1to1.25 JAN.MTH.GoalDistance.1.25to1.5 JAN.MTH.GoalDistance.1.5to1.75
JAN.MTH.GoalDistance.1.75up 0 'Not in this category' 1 'In this category'.

COMPUTE JAN.MTH.RawGoalDistance= 99.
if LITOfficialFL = 1 Jan.MTH.RawGoalDistance=(TotalDosage.LIT-JAN.MTH.DosageGoal.Minutes)/60.
RECODE JAN.MTH.RawGoalDistance (99=SYSMIS).
VARIABLE LABELS JAN.MTH.RawGoalDistance 'Hours between January Dosage Actual and Goal'.

***** INSERT OPERATING GOALS SYNTAX HERE.

******************************************************************************************************************************************************
***** Calculate additional variables -- FOR AC REPORTING.
******************************************************************************************************************************************************

***** Create separate dosage variables for AC reporting, since we're not sure that they'll be the same as the ones for internal reporting.
*****     AmeriCorps - June Dosage Goals - FULL DOSAGE.
COMPUTE AC.ELA.DosageGoal.Minutes = JUN.ELA.DosageGoal.Minutes.
COMPUTE AC.MTH.DosageGoal.Minutes = JUN.MTH.DosageGoal.Minutes.
EXECUTE.
*****     Override goals for DN Schools to 6 hours, as stated in AC grants.
IF (DNSchool = 1) AC.ELA.DosageGoal.Minutes = 360.
IF (DNSchool = 1) AC.MTH.DosageGoal.Minutes = 360.
EXECUTE.
*****     Convert final goals to hours.
COMPUTE AC.ELA.DosageGoal.Hours = AC.ELA.DosageGoal.Minutes / 60.
COMPUTE AC.MTH.DosageGoal.Hours = AC.MTH.DosageGoal.Minutes / 60.
EXECUTE.

IF (LITOfficialFL = 1 & (TotalDosage.LIT >= AC.ELA.DosageGoal.Minutes)) LITMetACDose = 1.
IF (LITOfficialFL = 1 & (TotalDosage.LIT < AC.ELA.DosageGoal.Minutes)) LITMetACDose = 0.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH >= JUN.MTH.DosageGoal.Minutes)) MTHMetACDose = 1.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH < JUN.MTH.DosageGoal.Minutes)) MTHMetACDose = 0.
VARIABLE LABELS LITMetACDose "Number of Students Meeting ELA/Literacy AMERICORPS Dosage Benchmark (with overlap)"
   MTHMetACDose "Number of Students Meeting Math AMERICORPS Dosage Benchmark (with overlap)".
VALUE LABELS LITMetACDose 0 "Did not meet AMERICORPS literacy dosage goal"
   1 "Met AMERICORPS literacy dosage goal".
VALUE LABELS MTHMetACDose 0 "Did not meet AMERICORPS math dosage goal"
   1 "Met AMERICORPS math dosage goal".

***** Create half-dosage variables for AC purposes.
*****     AmeriCorps - June Dosage Goals - STUDENTS MEETING HALFWAY DOSAGE POINT.
IF (LITOfficialFL = 1 & (TotalDosage.LIT >= AC.ELA.DosageGoal.Minutes * 0.5)) LITMetACDoseHALF = 1.
IF (LITOfficialFL = 1 & (TotalDosage.LIT < AC.ELA.DosageGoal.Minutes * 0.5)) LITMetACDoseHALF = 0.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH >= AC.MTH.DosageGoal.Minutes * 0.5)) MTHMetACDoseHALF = 1.
IF (MTHOfficialFL = 1 & (TotalDosage.MTH < AC.MTH.DosageGoal.Minutes * 0.5)) MTHMetACDoseHALF = 0.
VARIABLE LABELS LITMetACDoseHALF "Number of Students Meeting HALF ELA/Literacy AMERICORPS Dosage Benchmark (with overlap)"
   MTHMetACDoseHALF "Number of Students Meeting HALF Math AMERICORPS Dosage Benchmark (with overlap)".
VALUE LABELS LITMetACDoseHALF 0 "Did not meet HALF AMERICORPS literacy dosage goal"
   1 "Met HALF AMERICORPS literacy dosage goal".
VALUE LABELS MTHMetACDoseHALF 0 "Did not meet HALF AMERICORPS math dosage goal"
   1 "Met HALF AMERICORPS math dosage goal".

***** Enrolled in LIT or MTH.
IF (ACreportLIT = 1) ACLITOfficialFL = LITOfficialFL.
IF (ACreportMTH = 1) ACMTHOfficialFL = MTHOfficialFL.
EXECUTE.
IF ((ACLITOfficialFL = 1) | (ACMTHOfficialFL = 1)) ACLITorMTHOfficialFL = 1.
IF ((ACLITorMTHOfficialFL ~= 1) & (ACLITOfficialFL = 0 | ACMTHOfficialFL = 0)) ACLITorMTHOfficialFL = 0.
EXECUTE.
VARIABLE LABELS ACLITOfficialFL "Non-unique number of students enrolled on official focus lists for literacy (AC reporting)"
   ACMTHOfficialFL "Non-unique number of students enrolled on official focus lists for math (AC reporting)"
   ACLITorMTHOfficialFL "ACTUAL ED1 Academic:\nUnique number of students enrolled on official focus lists for literacy and/or math".
VALUE LABELS ACLITOfficialFL 0 "AmeriCorps Reporting: Did not meet official focus list criteria for literacy"
   1 "AmeriCorps Reporting: On official focus list for literacy".
VALUE LABELS ACMTHOfficialFL 0 "AmeriCorps Reporting: Did not meet official focus list criteria for math"
   1 "AmeriCorps Reporting: On official focus list for math".
VALUE LABELS ACLITorMTHOfficialFL 0 "AmeriCorps Reporting: Did not meet official focus list criteria for literacy or math"
   1 "AmeriCorps Reporting: On official focus list for literacy and/or math".
EXECUTE.

***** Met Enroll/Dosage for LIT or MTH.
IF (ACLITOfficialFL = 1) ACLITMetACDose = LITMetACDose.
IF (ACMTHOfficialFL = 1) ACMTHMetACDose = MTHMetACDose.
EXECUTE.
IF (ACLITMetACDose = 1 | ACMTHMetACDose = 1) ACLITorMTHMetACDose = 1.
IF (ACLITorMTHMetACDose ~= 1 & (ACLITMetACDose = 0 | ACMTHMetACDose = 0)) ACLITorMTHMetACDose = 0.
EXECUTE.
VARIABLE LABELS ACLITMetACDose "Non-unique number of students on official focus lists who met dosage thresholds for literacy (AC reporting)"
   ACMTHMetACDose "Non-unique number of students on official focus lists who met dosage thresholds for math (AC reporting)"
   ACLITorMTHMetACDose "ACTUAL ED2 Academic:\nUnique number of students on official focus lists who met final dosage thresholds for literacy and/or math".
VALUE LABELS ACLITMetACDose 0 "AmeriCorps Reporting: Official focus list, did not meet dosage threshold for literacy"
   1 "AmeriCorps Reporting: Official focus list, met dosage threshold for literacy".
VALUE LABELS ACMTHMetACDose 0 "AmeriCorps Reporting: Official focus list, did not meet dosage threshold for math"
   1 "AmeriCorps Reporting: Official focus list, met dosage threshold for math".
VALUE LABELS ACLITorMTHMetACDose 0 "On official focus list for literacy and/or math, did not meet dosage threshold"
   1 "On official focus list for literacy and/or math, met dosage threshold".
EXECUTE.

***** Met Enroll/HALF DOSAGE for LIT or MTH.
IF (ACLITOfficialFL = 1) ACLITMetACDoseHALF = LITMetACDoseHALF.
IF (ACMTHOfficialFL = 1) ACMTHMetACDoseHALF = MTHMetACDoseHALF.
EXECUTE.
IF (ACLITMetACDoseHALF = 1 | ACMTHMetACDoseHALF = 1) ACLITorMTHMetACDoseHALF = 1.
IF (ACLITorMTHMetACDoseHALF ~= 1 & (ACLITMetACDoseHALF = 0 | ACMTHMetACDoseHALF = 0)) ACLITorMTHMetACDoseHALF = 0.
EXECUTE.
VARIABLE LABELS ACLITMetACDoseHALF "Non-unique number of students on official focus lists who met HALF dosage thresholds for literacy (AC reporting)"
   ACMTHMetACDoseHALF "Non-unique number of students on official focus lists who met HALF dosage thresholds for math (AC reporting)"
   ACLITorMTHMetACDoseHALF "Unique number of students on official focus lists who met HALF dosage thresholds for literacy and/or math".
VALUE LABELS ACLITMetACDoseHALF 0 "AmeriCorps Reporting: Official focus list, did not meet HALF dosage threshold for literacy"
   1 "AmeriCorps Reporting: Official focus list, met HALF dosage threshold for literacy".
VALUE LABELS ACMTHMetACDoseHALF 0 "AmeriCorps Reporting: Official focus list, did not meet HALF dosage threshold for math"
   1 "AmeriCorps Reporting: Official focus list, met HALF dosage threshold for math".
VALUE LABELS ACLITorMTHMetACDoseHALF 0 "On official focus list for literacy and/or math, did not meet HALF dosage threshold"
   1 "On official focus list for literacy and/or math, met HALF dosage threshold".
EXECUTE.

***** Enrolled in ATT or BEH.
IF (ACreportATT = 1) ACATTOfficialFL = ATTOfficialFL.
IF (ACreportBEH = 1) ACBEHOfficialFL = BEHOfficialFL.
EXECUTE.
IF (ACATTOfficialFL = 1 | ACBEHOfficialFL = 1) ACATTorBEHOfficialFL = 1.
IF ((ACATTorBEHOfficialFL ~= 1) & (ACATTOfficialFL = 0 | ACBEHOfficialFL = 0)) ACATTorBEHOfficialFL = 0.
EXECUTE.
VARIABLE LABELS ACATTOfficialFL "Non-unique number of students enrolled on official focus lists for attendance (AC reporting)"
   ACBEHOfficialFL "Non-unique number of students enrolled on official focus lists for behavior (AC reporting)"
   ACATTorBEHOfficialFL "ACTUAL ED1 Student Engagement:\nUnique number of students enrolled on official focus lists for attendance and/or behavior".
VALUE LABELS ACATTOfficialFL 0 "AmeriCorps Reporting: Did not meet official focus list criteria for attendance"
   1 "AmeriCorps Reporting: Met official focus list criteria for attendance".
VALUE LABELS ACBEHOfficialFL 0 "AmeriCorps Reporting: Did not meet official focus list criteria for behavior"
   1 "AmeriCorps Reporting: Met official focus list criteria for behavior".
VALUE LABELS ACATTorBEHOfficialFL 0 "AmeriCorps: Did not meet official focus list criteria for attendance or behavior"
   1 "AmeriCorps: On official focus list for attendance and/or behavior".
EXECUTE.

***** Met Enroll/Dosage for ATT or BEH.
IF (ACATTOfficialFL = 1) ACATTMet56Dose = ATTMet56Dose.
IF (ACBEHOfficialFL = 1) ACBEHMet56Dose = BEHMet56Dose.
EXECUTE.
IF (ACATTMet56Dose = 1 | ACBEHMet56Dose = 1) ACATTorBEHMet56Dose = 1.
IF (ACATTorBEHMet56Dose ~= 1 & (ACATTMet56Dose = 0 | ACBEHMet56Dose = 0)) ACATTorBEHMet56Dose = 0.
EXECUTE.
VARIABLE LABELS ACATTMet56Dose "Non-unique number of students on official focus lists who met dosage thresholds for attendance (AC reporting)"
   ACBEHMet56Dose "Non-unique number of students on official focus lists who met dosage thresholds for behavior (AC reporting)"
   ACATTorBEHMet56Dose "ACTUAL ED2 Student Engagement:\nUnique number of students on official focus lists who met dosage thresholds for attendance and/or behavior".
VALUE LABELS ACATTMet56Dose 0 "AmeriCorps Reporting: Official focus list, did not meet dosage threshold for attendance"
   1 "AmeriCorps Reporting: Official focus list, met dosage threshold for attendance".
VALUE LABELS ACBEHMet56Dose 0 "AmeriCorps Reporting: Official focus list, did not meet dosage threshold for behavior"
   1 "AmeriCorps Reporting: Official focus list, met dosage threshold for behavior".
VALUE LABELS ACATTorBEHMet56Dose 0 "AmeriCorps: On official focus list for attendance and/or behavior, did not meet dosage threshold"
   1 "AmeriCorps: On official focus list for attendance and/or behavior, met dosage threshold".
EXECUTE.

***** What grade levels are we reporting on for AmeriCorps?.
DO IF (ACLITorMTHOfficialFL = 1 | ACATTorBEHOfficialFL = 1).
COMPUTE ACStudentGrade = StudentGrade.
END IF.
VARIABLE LABELS ACStudentGrade "Student Grade Levels".
EXECUTE.

******************************************************************************************************************************************************
***** Create additional variables.
******************************************************************************************************************************************************

***** Create regional variable.
RECODE Location ("Baton Rouge" = 4) ("Boston" = 3) ("Chicago" = 2) ("Cleveland" = 2) ("Columbia" = 4) ("Columbus" = 2) ("Denver" = 5) ("Detroit" = 2) ("Jacksonville" = 1)
("Little Rock" = 4) ("Los Angeles" = 5) ("Miami" = 1) ("Milwaukee" = 2) ("New Hampshire" = 3) ("New Orleans" = 4) ("New York" = 3) ("Orlando" = 1) ("Philadelphia" = 3)
("Rhode Island" = 3) ("Sacramento" = 5) ("San Antonio" = 4) ("San Jose" = 5) ("Seattle" = 5) ("Tulsa" = 4) ("Washington, DC" = 3) (ELSE = SYSMIS) INTO RegionID.
VALUE LABELS RegionID 1 "Florida"
2 "Midwest"
3 "Northeast"
4 "South"
5 "West".
ALTER TYPE RegionID (F1.0).
EXECUTE.

******************************************************************************************************************************************************
***** Create team-level summary dataset.
******************************************************************************************************************************************************

DATASET DECLARE FINALTEAMDATASET39ONLY.
DATASET ACTIVATE FINALDATASET.
DATASET COPY FINALFILTERED39ONLY.
DATASET ACTIVATE FINALFILTERED39ONLY.
SELECT IF StudentGrade >= 3 & StudentGrade <= 9.
EXECUTE.

SORT CASES BY Location (A) cyschSchoolRefID (A).
EXECUTE.

AGGREGATE /OUTFILE = FINALTEAMDATASET39ONLY
   /BREAK = Location cyschSchoolRefID
   /School = FIRST(School)
   /RegionID = MEAN(RegionID)
   /cyStudentIDCount = NU(cyStudentID)
   /cychanSchoolID = FIRST(cychanSchoolID)
   /Subtype = FIRST(Subtype)
   /DNSchool = MEAN(DNSchool)
   /MinStudentGrade = MIN(StudentGrade)
   /MaxStudentGrade = MAX(StudentGrade)
   /TotIALIT = SUM(IALIT)
   /TotIAMTH = SUM(IAMTH)
   /TotIAATT = SUM(IAATT)
   /TotIABEH = SUM(IABEH)
   /TEAM.ELA.FinalEnrollGoal = MEAN(TEAM.ELA.FinalEnrollGoal)
   /TEAM.MTH.FinalEnrollGoal = MEAN(TEAM.MTH.FinalEnrollGoal)
   /TEAM.ATT.FinalEnrollGoal = MEAN(TEAM.ATT.FinalEnrollGoal)
   /TEAM.BEH.FinalEnrollGoal = MEAN(TEAM.BEH.FinalEnrollGoal)
   /TEAM.Q1.ELA.EnrollGoalPerc = MEAN(TEAM.Q1.ELA.EnrollGoalPerc)
   /TEAM.Q1.MTH.EnrollGoalPerc = MEAN(TEAM.Q1.MTH.EnrollGoalPerc)
   /TEAM.Q1.ATT.EnrollGoalPerc = MEAN(TEAM.Q1.ATT.EnrollGoalPerc)
   /TEAM.Q1.BEH.EnrollGoalPerc = MEAN(TEAM.Q1.BEH.EnrollGoalPerc)
   /TEAM.Q2.ELA.EnrollGoalPerc = MEAN(TEAM.Q2.ELA.EnrollGoalPerc)
   /TEAM.Q2.MTH.EnrollGoalPerc = MEAN(TEAM.Q2.MTH.EnrollGoalPerc)
   /TEAM.Q2.ATT.EnrollGoalPerc = MEAN(TEAM.Q2.ATT.EnrollGoalPerc)
   /TEAM.Q2.BEH.EnrollGoalPerc = MEAN(TEAM.Q2.BEH.EnrollGoalPerc)
   /TEAM.Q3.ELA.EnrollGoalPerc = MEAN(TEAM.Q3.ELA.EnrollGoalPerc)
   /TEAM.Q3.MTH.EnrollGoalPerc = MEAN(TEAM.Q3.MTH.EnrollGoalPerc)
   /TEAM.Q3.ATT.EnrollGoalPerc = MEAN(TEAM.Q3.ATT.EnrollGoalPerc)
   /TEAM.Q3.BEH.EnrollGoalPerc = MEAN(TEAM.Q3.BEH.EnrollGoalPerc)
   /AUG.ELA.DosageGoal = MEAN(AUG.ELA.DosageGoal)
   /SEP.ELA.DosageGoal = MEAN(SEP.ELA.DosageGoal)
   /OCT.ELA.DosageGoal = MEAN(OCT.ELA.DosageGoal)
   /NOV.ELA.DosageGoal = MEAN(NOV.ELA.DosageGoal)
   /DEC.ELA.DosageGoal = MEAN(DEC.ELA.DosageGoal)
   /JAN.ELA.DosageGoal = MEAN(JAN.ELA.DosageGoal)
   /FEB.ELA.DosageGoal = MEAN(FEB.ELA.DosageGoal)
   /MAR.ELA.DosageGoal = MEAN(MAR.ELA.DosageGoal)
   /APR.ELA.DosageGoal = MEAN(APR.ELA.DosageGoal)
   /MAY.ELA.DosageGoal = MEAN(MAY.ELA.DosageGoal)
   /JUN.ELA.DosageGoal = MEAN(JUN.ELA.DosageGoal)
   /AUG.MTH.DosageGoal = MEAN(AUG.MTH.DosageGoal)
   /SEP.MTH.DosageGoal = MEAN(SEP.MTH.DosageGoal)
   /OCT.MTH.DosageGoal = MEAN(OCT.MTH.DosageGoal)
   /NOV.MTH.DosageGoal = MEAN(NOV.MTH.DosageGoal)
   /DEC.MTH.DosageGoal = MEAN(DEC.MTH.DosageGoal)
   /JAN.MTH.DosageGoal = MEAN(JAN.MTH.DosageGoal)
   /FEB.MTH.DosageGoal = MEAN(FEB.MTH.DosageGoal)
   /MAR.MTH.DosageGoal = MEAN(MAR.MTH.DosageGoal)
   /APR.MTH.DosageGoal = MEAN(APR.MTH.DosageGoal)
   /MAY.MTH.DosageGoal = MEAN(MAY.MTH.DosageGoal)
   /JUN.MTH.DosageGoal = MEAN(JUN.MTH.DosageGoal)
   /TEAM.Q1.ELA.EnrollGoal = MEAN(TEAM.Q1.ELA.EnrollGoal)
   /TEAM.Q1.MTH.EnrollGoal = MEAN(TEAM.Q1.MTH.EnrollGoal)
   /TEAM.Q1.ATT.EnrollGoal = MEAN(TEAM.Q1.ATT.EnrollGoal)
   /TEAM.Q1.BEH.EnrollGoal = MEAN(TEAM.Q1.BEH.EnrollGoal)
   /TEAM.Q2.ELA.EnrollGoal = MEAN(TEAM.Q2.ELA.EnrollGoal)
   /TEAM.Q2.MTH.EnrollGoal = MEAN(TEAM.Q2.MTH.EnrollGoal)
   /TEAM.Q2.ATT.EnrollGoal = MEAN(TEAM.Q2.ATT.EnrollGoal)
   /TEAM.Q2.BEH.EnrollGoal = MEAN(TEAM.Q2.BEH.EnrollGoal)
   /TEAM.Q3.ELA.EnrollGoal = MEAN(TEAM.Q3.ELA.EnrollGoal)
   /TEAM.Q3.MTH.EnrollGoal = MEAN(TEAM.Q3.MTH.EnrollGoal)
   /TEAM.Q3.ATT.EnrollGoal = MEAN(TEAM.Q3.ATT.EnrollGoal)
   /TEAM.Q3.BEH.EnrollGoal = MEAN(TEAM.Q3.BEH.EnrollGoal)
   /AUG.ELA.DosageGoal.Minutes = MEAN(AUG.ELA.DosageGoal.Minutes)
   /SEP.ELA.DosageGoal.Minutes = MEAN(SEP.ELA.DosageGoal.Minutes)
   /OCT.ELA.DosageGoal.Minutes = MEAN(OCT.ELA.DosageGoal.Minutes)
   /NOV.ELA.DosageGoal.Minutes = MEAN(NOV.ELA.DosageGoal.Minutes)
   /DEC.ELA.DosageGoal.Minutes = MEAN(DEC.ELA.DosageGoal.Minutes)
   /JAN.ELA.DosageGoal.Minutes = MEAN(JAN.ELA.DosageGoal.Minutes)
   /FEB.ELA.DosageGoal.Minutes = MEAN(FEB.ELA.DosageGoal.Minutes)
   /MAR.ELA.DosageGoal.Minutes = MEAN(MAR.ELA.DosageGoal.Minutes)
   /APR.ELA.DosageGoal.Minutes = MEAN(APR.ELA.DosageGoal.Minutes)
   /MAY.ELA.DosageGoal.Minutes = MEAN(MAY.ELA.DosageGoal.Minutes)
   /JUN.ELA.DosageGoal.Minutes = MEAN(JUN.ELA.DosageGoal.Minutes)
   /AUG.MTH.DosageGoal.Minutes = MEAN(AUG.MTH.DosageGoal.Minutes)
   /SEP.MTH.DosageGoal.Minutes = MEAN(SEP.MTH.DosageGoal.Minutes)
   /OCT.MTH.DosageGoal.Minutes = MEAN(OCT.MTH.DosageGoal.Minutes)
   /NOV.MTH.DosageGoal.Minutes = MEAN(NOV.MTH.DosageGoal.Minutes)
   /DEC.MTH.DosageGoal.Minutes = MEAN(DEC.MTH.DosageGoal.Minutes)
   /JAN.MTH.DosageGoal.Minutes = MEAN(JAN.MTH.DosageGoal.Minutes)
   /FEB.MTH.DosageGoal.Minutes = MEAN(FEB.MTH.DosageGoal.Minutes)
   /MAR.MTH.DosageGoal.Minutes = MEAN(MAR.MTH.DosageGoal.Minutes)
   /APR.MTH.DosageGoal.Minutes = MEAN(APR.MTH.DosageGoal.Minutes)
   /MAY.MTH.DosageGoal.Minutes = MEAN(MAY.MTH.DosageGoal.Minutes)
   /JUN.MTH.DosageGoal.Minutes = MEAN(JUN.MTH.DosageGoal.Minutes)
   /SITE.ELA.FinalEnrollGoal = MEAN(SITE.ELA.FinalEnrollGoal)
   /SITE.MTH.FinalEnrollGoal = MEAN(SITE.MTH.FinalEnrollGoal)
   /SITE.ATT.FinalEnrollGoal = MEAN(SITE.ATT.FinalEnrollGoal)
   /SITE.BEH.FinalEnrollGoal = MEAN(SITE.BEH.FinalEnrollGoal)
   /SITE.Q1.ELA.EnrollGoal = MEAN(SITE.Q1.ELA.EnrollGoal)
   /SITE.Q1.MTH.EnrollGoal = MEAN(SITE.Q1.MTH.EnrollGoal)
   /SITE.Q1.ATT.EnrollGoal = MEAN(SITE.Q1.ATT.EnrollGoal)
   /SITE.Q1.BEH.EnrollGoal = MEAN(SITE.Q1.BEH.EnrollGoal)
   /SITE.Q2.ELA.EnrollGoal = MEAN(SITE.Q2.ELA.EnrollGoal)
   /SITE.Q2.MTH.EnrollGoal = MEAN(SITE.Q2.MTH.EnrollGoal)
   /SITE.Q2.ATT.EnrollGoal = MEAN(SITE.Q2.ATT.EnrollGoal)
   /SITE.Q2.BEH.EnrollGoal = MEAN(SITE.Q2.BEH.EnrollGoal)
   /SITE.Q3.ELA.EnrollGoal = MEAN(SITE.Q3.ELA.EnrollGoal)
   /SITE.Q3.MTH.EnrollGoal = MEAN(SITE.Q3.MTH.EnrollGoal)
   /SITE.Q3.ATT.EnrollGoal = MEAN(SITE.Q3.ATT.EnrollGoal)
   /SITE.Q3.BEH.EnrollGoal = MEAN(SITE.Q3.BEH.EnrollGoal)
   /LITOfficialFL = SUM(LITOfficialFL)
   /MTHOfficialFL = SUM(MTHOfficialFL)
   /ATTOfficialFL = SUM(ATTOfficialFL)
   /BEHOfficialFL = SUM(BEHOfficialFL)
   /LITMetOCTDose = SUM(LITMetOCTDose)
   /MTHMetOCTDose = SUM(MTHMetOCTDose)
   /LITMetNOVDose = SUM(LITMetNOVDose)
   /MTHMetNOVDose = SUM(MTHMetNOVDose)
   /LITMetDECDose = SUM(LITMetDECDose)
   /MTHMetDECDose = SUM(MTHMetDECDose)
   /LITMetJANDose = SUM(LITMetJANDose)
   /MTHMetJANDose = SUM(MTHMetJANDose)
   /LITMetFEBDose = SUM(LITMetFEBDose)
   /MTHMetFEBDose = SUM(MTHMetFEBDose)
   /LITMetMARDose = SUM(LITMetMARDose)
   /MTHMetMARDose = SUM(MTHMetMARDose)
   /LITMetAPRDose = SUM(LITMetAPRDose)
   /MTHMetAPRDose = SUM(MTHMetAPRDose)
   /LITMetMAYDose = SUM(LITMetMAYDose)
   /MTHMetMAYDose = SUM(MTHMetMAYDose)
   /LITMetJUNDose = SUM(LITMetJUNDose)
   /MTHMetJUNDose = SUM(MTHMetJUNDose)
   /ATTMet56Dose = SUM(ATTMet56Dose)
   /BEHMet56Dose = SUM(BEHMet56Dose)
   /LITNotOfficialFL = SUM(LITNotOfficialFL)
   /MTHNotOfficialFL = SUM(MTHNotOfficialFL)
   /ATTNotOfficialFL = SUM(ATTNotOfficialFL)
   /BEHNotOfficialFL = SUM(BEHNotOfficialFL)
   /NotFLLITMetOCTDose = SUM(NotFLLITMetOCTDose)
   /NotFLMTHMetOCTDose = SUM(NotFLMTHMetOCTDose)
   /NotFLLITMetNOVDose = SUM(NotFLLITMetNOVDose)
   /NotFLMTHMetNOVDose = SUM(NotFLMTHMetNOVDose)
   /NotFLLITMetDECDose = SUM(NotFLLITMetDECDose)
   /NotFLMTHMetDECDose = SUM(NotFLMTHMetDECDose)
   /NotFLLITMetJANDose = SUM(NotFLLITMetJANDose)
   /NotFLMTHMetJANDose = SUM(NotFLMTHMetJANDose)
   /NotFLLITMetFEBDose = SUM(NotFLLITMetFEBDose)
   /NotFLMTHMetFEBDose = SUM(NotFLMTHMetFEBDose)
   /NotFLLITMetMARDose = SUM(NotFLLITMetMARDose)
   /NotFLMTHMetMARDose = SUM(NotFLMTHMetMARDose)
   /NotFLLITMetAPRDose = SUM(NotFLLITMetAPRDose)
   /NotFLMTHMetAPRDose = SUM(NotFLMTHMetAPRDose)
   /NotFLLITMetMAYDose = SUM(NotFLLITMetMAYDose)
   /NotFLMTHMetMAYDose = SUM(NotFLMTHMetMAYDose)
   /NotFLLITMetJUNDose = SUM(NotFLLITMetJUNDose)
   /NotFLMTHMetJUNDose = SUM(NotFLMTHMetJUNDose)
   /NotFLATTMet56Dose = SUM(NotFLATTMet56Dose)
   /NotFLBEHMet56Dose = SUM(NotFLBEHMet56Dose)
   /LEAD_LIT39_SampleSize = NU(LEAD_LIT39_SOS)
   /LEAD_MTH39_SampleSize = NU(LEAD_MTH39_SOS)
   /LEAD_ATT69_SampleSize = NU(LEAD_ATT69_StartLT90ADA)
   /LEAD_LIT39_SOS = SUM(LEAD_LIT39_SOS)
   /LEAD_MTH39_SOS = SUM(LEAD_MTH39_SOS)
   /LEAD_ATT69_StartLT90ADA = SUM(LEAD_ATT69_StartLT90ADA)
   /LITAssess_FLComp_SampleSize = SUM(LITAssess_FLComp_SampleSize)
   /LITAssess_FLComp_SOS = SUM(LITAssess_FLComp_SOS)
   /ELACG_FLComp_SampleSize = SUM(ELACG_FLComp_SampleSize)
   /ELACG_FLComp_SOS = SUM(ELACG_FLComp_SOS)
   /MTHAssess_FLComp_SampleSize = SUM(MTHAssess_FLComp_SampleSize)
   /MTHAssess_FLComp_SOS = SUM(MTHAssess_FLComp_SOS)
   /MTHCG_FLComp_SampleSize = SUM(MTHCG_FLComp_SampleSize)
   /MTHCG_FLComp_SOS = SUM(MTHCG_FLComp_SOS)
   /JAN.ELA.GoalDistance.0t25 =SUM(JAN.ELA.GoalDistance.0t25)
   /JAN.ELA.GoalDistance.25t.5 =SUM(JAN.ELA.GoalDistance.25t.5 )
   /JAN.ELA.GoalDistance.5t.75 =SUM(JAN.ELA.GoalDistance.5t.75)
   /JAN.ELA.GoalDistance.75to1  =SUM(JAN.ELA.GoalDistance.75to1 )
   /JAN.ELA.GoalDistance.1to1.25 =SUM(JAN.ELA.GoalDistance.1to1.25)
   /JAN.ELA.GoalDistance.1.25to1.5 =SUM(JAN.ELA.GoalDistance.1.25to1.5)
   /JAN.ELA.GoalDistance.1.5to1.75=SUM(JAN.ELA.GoalDistance.1.5to1.75)
   /JAN.ELA.GoalDistance.1.75up=SUM(JAN.ELA.GoalDistance.1.75up)   
   /JAN.ELA.GoalDistance.SampleSize=SUM(JAN.ELA.GoalDistance.SampleSize)
   /JAN.MTH.GoalDistance.0t25 =SUM(JAN.MTH.GoalDistance.0t25)
   /JAN.MTH.GoalDistance.25t.5 =SUM(JAN.MTH.GoalDistance.25t.5 )
   /JAN.MTH.GoalDistance.5t.75 =SUM(JAN.MTH.GoalDistance.5t.75)
   /JAN.MTH.GoalDistance.75to1  =SUM(JAN.MTH.GoalDistance.75to1 )
   /JAN.MTH.GoalDistance.1to1.25 =SUM(JAN.MTH.GoalDistance.1to1.25)
   /JAN.MTH.GoalDistance.1.25to1.5 =SUM(JAN.MTH.GoalDistance.1.25to1.5)
   /JAN.MTH.GoalDistance.1.5to1.75=SUM(JAN.MTH.GoalDistance.1.5to1.75)
   /JAN.MTH.GoalDistance.1.75up=SUM(JAN.MTH.GoalDistance.1.75up)   
   /JAN.MTH.GoalDistance.SampleSize=SUM(JAN.MTH.GoalDistance.SampleSize).

DATASET ACTIVATE FINALTEAMDATASET39ONLY.

***** Calculate % met dosage variables and % met IOG.
*****    Official FL.
COMPUTE LITMetOCTDosePerc = LITMetOCTDose / LITOfficialFL.
COMPUTE MTHMetOCTDosePerc = MTHMetOCTDose / MTHOfficialFL.
COMPUTE LITMetNOVDosePerc = LITMetNOVDose / LITOfficialFL.
COMPUTE MTHMetNOVDosePerc = MTHMetNOVDose / MTHOfficialFL.
COMPUTE LITMetDECDosePerc = LITMetDECDose / LITOfficialFL.
COMPUTE MTHMetDECDosePerc = MTHMetDECDose / MTHOfficialFL.
COMPUTE LITMetJANDosePerc = LITMetJANDose / LITOfficialFL.
COMPUTE MTHMetJANDosePerc = MTHMetJANDose / MTHOfficialFL.
COMPUTE LITMetFEBDosePerc = LITMetFEBDose / LITOfficialFL.
COMPUTE MTHMetFEBDosePerc = MTHMetFEBDose / MTHOfficialFL.
COMPUTE LITMetMARDosePerc = LITMetMARDose / LITOfficialFL.
COMPUTE MTHMetMARDosePerc = MTHMetMARDose / MTHOfficialFL.
COMPUTE LITMetAPRDosePerc = LITMetAPRDose / LITOfficialFL.
COMPUTE MTHMetAPRDosePerc = MTHMetAPRDose / MTHOfficialFL.
COMPUTE LITMetMAYDosePerc = LITMetMAYDose / LITOfficialFL.
COMPUTE MTHMetMAYDosePerc = MTHMetMAYDose / MTHOfficialFL.
COMPUTE LITMetJUNDosePerc = LITMetJUNDose / LITOfficialFL.
COMPUTE MTHMetJUNDosePerc = MTHMetJUNDose / MTHOfficialFL.
COMPUTE ATTMet56DosePerc = ATTMet56Dose / ATTOfficialFL.
COMPUTE BEHMet56DosePerc = BEHMet56Dose / BEHOfficialFL.
*****    Unofficial FL.
COMPUTE NotFLLITMetOCTDosePerc = NotFLLITMetOCTDose / LITNotOfficialFL.
COMPUTE NotFLMTHMetOCTDosePerc = NotFLMTHMetOCTDose / MTHNotOfficialFL.
COMPUTE NotFLLITMetNOVDosePerc = NotFLLITMetNOVDose / LITNotOfficialFL.
COMPUTE NotFLMTHMetNOVDosePerc = NotFLMTHMetNOVDose / MTHNotOfficialFL.
COMPUTE NotFLLITMetDECDosePerc = NotFLLITMetDECDose / LITNotOfficialFL.
COMPUTE NotFLMTHMetDECDosePerc = NotFLMTHMetDECDose / MTHNotOfficialFL.
COMPUTE NotFLLITMetJANDosePerc = NotFLLITMetJANDose / LITNotOfficialFL.
COMPUTE NotFLMTHMetJANDosePerc = NotFLMTHMetJANDose / MTHNotOfficialFL.
COMPUTE NotFLLITMetFEBDosePerc = NotFLLITMetFEBDose / LITNotOfficialFL.
COMPUTE NotFLMTHMetFEBDosePerc = NotFLMTHMetFEBDose / MTHNotOfficialFL.
COMPUTE NotFLLITMetMARDosePerc = NotFLLITMetMARDose / LITNotOfficialFL.
COMPUTE NotFLMTHMetMARDosePerc = NotFLMTHMetMARDose / MTHNotOfficialFL.
COMPUTE NotFLLITMetAPRDosePerc = NotFLLITMetAPRDose / LITNotOfficialFL.
COMPUTE NotFLMTHMetAPRDosePerc = NotFLMTHMetAPRDose / MTHNotOfficialFL.
COMPUTE NotFLLITMetMAYDosePerc = NotFLLITMetMAYDose / LITNotOfficialFL.
COMPUTE NotFLMTHMetMAYDosePerc = NotFLMTHMetMAYDose / MTHNotOfficialFL.
COMPUTE NotFLLITMetJUNDosePerc = NotFLLITMetJUNDose / LITNotOfficialFL.
COMPUTE NotFLMTHMetJUNDosePerc = NotFLMTHMetJUNDose / MTHNotOfficialFL.
COMPUTE NotFLATTMet56DosePerc = NotFLATTMet56Dose / ATTNotOfficialFL.
COMPUTE NotFLBEHMet56DosePerc = NotFLBEHMet56Dose / BEHNotOfficialFL.
*****     Lead Measures.
COMPUTE LEAD_LIT39_SOSPerc = LEAD_LIT39_SOS / LEAD_LIT39_SampleSize.
COMPUTE LEAD_MTH39_SOSPerc = LEAD_MTH39_SOS / LEAD_MTH39_SampleSize.
COMPUTE LEAD_ATT69_StartLT90ADAPerc = LEAD_ATT69_StartLT90ADA / LEAD_ATT69_SampleSize.
COMPUTE LITAssess_FLComp_SOSPerc = LITAssess_FLComp_SOS / LITAssess_FLComp_SampleSize.
COMPUTE ELACG_FLComp_SOSPerc = ELACG_FLComp_SOS / ELACG_FLComp_SampleSize.
COMPUTE MTHAssess_FLComp_SOSPerc = MTHAssess_FLComp_SOS / MTHAssess_FLComp_SampleSize.
COMPUTE MTHCG_FLComp_SOSPerc = MTHCG_FLComp_SOS / MTHCG_FLComp_SampleSize.
EXECUTE.

***** Add variable and value labels.
VARIABLE LABELS LITMetOCTDosePerc "DOSAGE ACTUAL\n% of Students Meeting ELA/Literacy OCTOBER Dosage Benchmark (out of ACTUAL FL Enrollment)"
   MTHMetOCTDosePerc "DOSAGE ACTUAL\n% of Students Meeting Math OCTOBER Dosage Benchmark (out of ACTUAL FL Enrollment)"
   LITMetNOVDosePerc "DOSAGE ACTUAL\n% of Students Meeting ELA/Literacy NOVEMBER Dosage Benchmark (out of ACTUAL FL Enrollment)"
   MTHMetNOVDosePerc "DOSAGE ACTUAL\n% of Students Meeting Math NOVEMBER Dosage Benchmark (out of ACTUAL FL Enrollment)"
   LITMetDECDosePerc "DOSAGE ACTUAL\n% of Students Meeting ELA/Literacy DECEMBER Dosage Benchmark (out of ACTUAL FL Enrollment)"
   MTHMetDECDosePerc "DOSAGE ACTUAL\n% of Students Meeting Math DECEMBER Dosage Benchmark (out of ACTUAL FL Enrollment)"
   LITMetJANDosePerc "DOSAGE ACTUAL\n% of Students Meeting ELA/Literacy JANUARY Dosage Benchmark (out of ACTUAL FL Enrollment)"
   MTHMetJANDosePerc "DOSAGE ACTUAL\n% of Students Meeting Math JANUARY Dosage Benchmark (out of ACTUAL FL Enrollment)"
   LITMetFEBDosePerc "DOSAGE ACTUAL\n% of Students Meeting ELA/Literacy FEBRUARY Dosage Benchmark (out of ACTUAL FL Enrollment)"
   MTHMetFEBDosePerc "DOSAGE ACTUAL\n% of Students Meeting Math FEBRUARY Dosage Benchmark (out of ACTUAL FL Enrollment)"
   LITMetMARDosePerc "DOSAGE ACTUAL\n% of Students Meeting ELA/Literacy MARCH Dosage Benchmark (out of ACTUAL FL Enrollment)"
   MTHMetMARDosePerc "DOSAGE ACTUAL\n% of Students Meeting Math MARCH Dosage Benchmark (out of ACTUAL FL Enrollment)"
   LITMetAPRDosePerc "DOSAGE ACTUAL\n% of Students Meeting ELA/Literacy APRIL Dosage Benchmark (out of ACTUAL FL Enrollment)"
   MTHMetAPRDosePerc "DOSAGE ACTUAL\n% of Students Meeting Math APRIL Dosage Benchmark (out of ACTUAL FL Enrollment)"
   LITMetMAYDosePerc "DOSAGE ACTUAL\n% of Students Meeting ELA/Literacy MAY Dosage Benchmark (out of ACTUAL FL Enrollment)"
   MTHMetMAYDosePerc "DOSAGE ACTUAL\n% of Students Meeting Math MAY Dosage Benchmark (out of ACTUAL FL Enrollment)"
   LITMetJUNDosePerc "DOSAGE ACTUAL\n% of Students Meeting ELA/Literacy JUNE Dosage Benchmark (out of ACTUAL FL Enrollment)"
   MTHMetJUNDosePerc "DOSAGE ACTUAL\n% of Students Meeting Math JUNE Dosage Benchmark (out of ACTUAL FL Enrollment)"
   NotFLLITMetOCTDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting ELA/Literacy OCTOBER Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLMTHMetOCTDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting Math OCTOBER Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLLITMetNOVDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting ELA/Literacy NOVEMBER Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLMTHMetNOVDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting Math NOVEMBER Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLLITMetDECDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting ELA/Literacy DECEMBER Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLMTHMetDECDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting Math DECEMBER Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLLITMetJANDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting ELA/Literacy JANUARY Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLMTHMetJANDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting Math JANUARY Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLLITMetFEBDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting ELA/Literacy FEBRUARY Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLMTHMetFEBDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting Math FEBRUARY Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLLITMetMARDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting ELA/Literacy MARCH Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLMTHMetMARDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting Math MARCH Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLLITMetAPRDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting ELA/Literacy APRIL Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLMTHMetAPRDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting Math APRIL Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLLITMetMAYDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting ELA/Literacy MAY Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLMTHMetMAYDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting Math MAY Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLLITMetJUNDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting ELA/Literacy JUNE Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLMTHMetJUNDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting Math JUNE Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   LEAD_LIT39_SOSPerc "LEAD MEASURE RESULT\n% of Students Starting Off-Track/Sliding in ELA/Literacy (3rd-9th Grade)"
   LEAD_MTH39_SOSPerc "LEAD MEASURE RESULT\n% of Students Starting Off-Track/Sliding in Math (3rd-9th Grade)"
   LEAD_ATT69_StartLT90ADAPerc "LEAD MEASURE RESULT\n% of Students Starting Off-Track/Sliding in Attendance (6th-9th Grade)"
   LITAssess_FLComp_SOSPerc "% Students Starting Off-Track/Sliding in Literacy Assessments (3rd-9th Grade)"
   ELACG_FLComp_SOSPerc "% Students Starting Off-Track/Sliding in ELA Course Grades (6th-9th Grade)"
   MTHAssess_FLComp_SOSPerc "% Students Starting Off-Track/Sliding in Math Assessments (3rd-9th Grade)"
   MTHCG_FLComp_SOSPerc "% Students Starting Off-Track/Sliding in Math Course Grades (6th-9th Grade)".
VALUE LABELS DNSchool 0 "Not a Diplomas Now School"
   1 "Diplomas Now School".
VALUE LABELS RegionID 1 "Florida"
2 "Midwest"
3 "Northeast"
4 "South"
5 "West".
EXECUTE.

***** No longer need filtered dataset.
DATASET CLOSE FINALFILTERED39ONLY.

******************************************************************************************************************************************************
***** Create site-level summary dataset.
******************************************************************************************************************************************************

DATASET DECLARE FINALSITEDATASET39ONLY.
DATASET ACTIVATE FINALTEAMDATASET39ONLY.
DATASET COPY TEAMAGG.
DATASET ACTIVATE TEAMAGG.

AGGREGATE /OUTFILE = FINALSITEDATASET39ONLY
   /BREAK = Location
   /schoolCount = NU(cyschSchoolRefID)
   /RegionID = MEAN(RegionID)
   /cyStudentIDCount = SUM(cyStudentIDCount)
   /DNSchoolCount = MEAN(DNSchool)
   /MinStudentGrade = MIN(MinStudentGrade)
   /MaxStudentGrade = MAX(MaxStudentGrade)
   /TotIALIT = SUM(TotIALIT)
   /TotIAMTH = SUM(TotIAMTH)
   /TotIAATT = SUM(TotIAATT)
   /TotIABEH = SUM(TotIABEH)
   /AUG.ELA.DosageGoalMin = MIN(AUG.ELA.DosageGoal)
   /SEP.ELA.DosageGoalMin = MIN(SEP.ELA.DosageGoal)
   /OCT.ELA.DosageGoalMin = MIN(OCT.ELA.DosageGoal)
   /NOV.ELA.DosageGoalMin = MIN(NOV.ELA.DosageGoal)
   /DEC.ELA.DosageGoalMin = MIN(DEC.ELA.DosageGoal)
   /JAN.ELA.DosageGoalMin = MIN(JAN.ELA.DosageGoal)
   /FEB.ELA.DosageGoalMin = MIN(FEB.ELA.DosageGoal)
   /MAR.ELA.DosageGoalMin = MIN(MAR.ELA.DosageGoal)
   /APR.ELA.DosageGoalMin = MIN(APR.ELA.DosageGoal)
   /MAY.ELA.DosageGoalMin = MIN(MAY.ELA.DosageGoal)
   /JUN.ELA.DosageGoalMin = MIN(JUN.ELA.DosageGoal)
   /AUG.ELA.DosageGoalMax = MAX(AUG.ELA.DosageGoal)
   /SEP.ELA.DosageGoalMax = MAX(SEP.ELA.DosageGoal)
   /OCT.ELA.DosageGoalMax = MAX(OCT.ELA.DosageGoal)
   /NOV.ELA.DosageGoalMax = MAX(NOV.ELA.DosageGoal)
   /DEC.ELA.DosageGoalMax = MAX(DEC.ELA.DosageGoal)
   /JAN.ELA.DosageGoalMax = MAX(JAN.ELA.DosageGoal)
   /FEB.ELA.DosageGoalMax = MAX(FEB.ELA.DosageGoal)
   /MAR.ELA.DosageGoalMax = MAX(MAR.ELA.DosageGoal)
   /APR.ELA.DosageGoalMax = MAX(APR.ELA.DosageGoal)
   /MAY.ELA.DosageGoalMax = MAX(MAY.ELA.DosageGoal)
   /JUN.ELA.DosageGoalMax = MAX(JUN.ELA.DosageGoal)
   /AUG.MTH.DosageGoalMin = MIN(AUG.MTH.DosageGoal)
   /SEP.MTH.DosageGoalMin = MIN(SEP.MTH.DosageGoal)
   /OCT.MTH.DosageGoalMin = MIN(OCT.MTH.DosageGoal)
   /NOV.MTH.DosageGoalMin = MIN(NOV.MTH.DosageGoal)
   /DEC.MTH.DosageGoalMin = MIN(DEC.MTH.DosageGoal)
   /JAN.MTH.DosageGoalMin = MIN(JAN.MTH.DosageGoal)
   /FEB.MTH.DosageGoalMin = MIN(FEB.MTH.DosageGoal)
   /MAR.MTH.DosageGoalMin = MIN(MAR.MTH.DosageGoal)
   /APR.MTH.DosageGoalMin = MIN(APR.MTH.DosageGoal)
   /MAY.MTH.DosageGoalMin = MIN(MAY.MTH.DosageGoal)
   /JUN.MTH.DosageGoalMin = MIN(JUN.MTH.DosageGoal)
   /AUG.MTH.DosageGoalMax = MAX(AUG.MTH.DosageGoal)
   /SEP.MTH.DosageGoalMax = MAX(SEP.MTH.DosageGoal)
   /OCT.MTH.DosageGoalMax = MAX(OCT.MTH.DosageGoal)
   /NOV.MTH.DosageGoalMax = MAX(NOV.MTH.DosageGoal)
   /DEC.MTH.DosageGoalMax = MAX(DEC.MTH.DosageGoal)
   /JAN.MTH.DosageGoalMax = MAX(JAN.MTH.DosageGoal)
   /FEB.MTH.DosageGoalMax = MAX(FEB.MTH.DosageGoal)
   /MAR.MTH.DosageGoalMax = MAX(MAR.MTH.DosageGoal)
   /APR.MTH.DosageGoalMax = MAX(APR.MTH.DosageGoal)
   /MAY.MTH.DosageGoalMax = MAX(MAY.MTH.DosageGoal)
   /JUN.MTH.DosageGoalMax = MAX(JUN.MTH.DosageGoal)
   /AUG.ELA.DosageGoal.MinutesMin = MIN(AUG.ELA.DosageGoal.Minutes)
   /SEP.ELA.DosageGoal.MinutesMin = MIN(SEP.ELA.DosageGoal.Minutes)
   /OCT.ELA.DosageGoal.MinutesMin = MIN(OCT.ELA.DosageGoal.Minutes)
   /NOV.ELA.DosageGoal.MinutesMin = MIN(NOV.ELA.DosageGoal.Minutes)
   /DEC.ELA.DosageGoal.MinutesMin = MIN(DEC.ELA.DosageGoal.Minutes)
   /JAN.ELA.DosageGoal.MinutesMin = MIN(JAN.ELA.DosageGoal.Minutes)
   /FEB.ELA.DosageGoal.MinutesMin = MIN(FEB.ELA.DosageGoal.Minutes)
   /MAR.ELA.DosageGoal.MinutesMin = MIN(MAR.ELA.DosageGoal.Minutes)
   /APR.ELA.DosageGoal.MinutesMin = MIN(APR.ELA.DosageGoal.Minutes)
   /MAY.ELA.DosageGoal.MinutesMin = MIN(MAY.ELA.DosageGoal.Minutes)
   /JUN.ELA.DosageGoal.MinutesMin = MIN(JUN.ELA.DosageGoal.Minutes)
   /AUG.ELA.DosageGoal.MinutesMax = MAX(AUG.ELA.DosageGoal.Minutes)
   /SEP.ELA.DosageGoal.MinutesMax = MAX(SEP.ELA.DosageGoal.Minutes)
   /OCT.ELA.DosageGoal.MinutesMax = MAX(OCT.ELA.DosageGoal.Minutes)
   /NOV.ELA.DosageGoal.MinutesMax = MAX(NOV.ELA.DosageGoal.Minutes)
   /DEC.ELA.DosageGoal.MinutesMax = MAX(DEC.ELA.DosageGoal.Minutes)
   /JAN.ELA.DosageGoal.MinutesMax = MAX(JAN.ELA.DosageGoal.Minutes)
   /FEB.ELA.DosageGoal.MinutesMax = MAX(FEB.ELA.DosageGoal.Minutes)
   /MAR.ELA.DosageGoal.MinutesMax = MAX(MAR.ELA.DosageGoal.Minutes)
   /APR.ELA.DosageGoal.MinutesMax = MAX(APR.ELA.DosageGoal.Minutes)
   /MAY.ELA.DosageGoal.MinutesMax = MAX(MAY.ELA.DosageGoal.Minutes)
   /JUN.ELA.DosageGoal.MinutesMax = MAX(JUN.ELA.DosageGoal.Minutes)
   /AUG.MTH.DosageGoal.MinutesMin = MIN(AUG.MTH.DosageGoal.Minutes)
   /SEP.MTH.DosageGoal.MinutesMin = MIN(SEP.MTH.DosageGoal.Minutes)
   /OCT.MTH.DosageGoal.MinutesMin = MIN(OCT.MTH.DosageGoal.Minutes)
   /NOV.MTH.DosageGoal.MinutesMin = MIN(NOV.MTH.DosageGoal.Minutes)
   /DEC.MTH.DosageGoal.MinutesMin = MIN(DEC.MTH.DosageGoal.Minutes)
   /JAN.MTH.DosageGoal.MinutesMin = MIN(JAN.MTH.DosageGoal.Minutes)
   /FEB.MTH.DosageGoal.MinutesMin = MIN(FEB.MTH.DosageGoal.Minutes)
   /MAR.MTH.DosageGoal.MinutesMin = MIN(MAR.MTH.DosageGoal.Minutes)
   /APR.MTH.DosageGoal.MinutesMin = MIN(APR.MTH.DosageGoal.Minutes)
   /MAY.MTH.DosageGoal.MinutesMin = MIN(MAY.MTH.DosageGoal.Minutes)
   /JUN.MTH.DosageGoal.MinutesMin = MIN(JUN.MTH.DosageGoal.Minutes)
   /AUG.MTH.DosageGoal.MinutesMax = MAX(AUG.MTH.DosageGoal.Minutes)
   /SEP.MTH.DosageGoal.MinutesMax = MAX(SEP.MTH.DosageGoal.Minutes)
   /OCT.MTH.DosageGoal.MinutesMax = MAX(OCT.MTH.DosageGoal.Minutes)
   /NOV.MTH.DosageGoal.MinutesMax = MAX(NOV.MTH.DosageGoal.Minutes)
   /DEC.MTH.DosageGoal.MinutesMax = MAX(DEC.MTH.DosageGoal.Minutes)
   /JAN.MTH.DosageGoal.MinutesMax = MAX(JAN.MTH.DosageGoal.Minutes)
   /FEB.MTH.DosageGoal.MinutesMax = MAX(FEB.MTH.DosageGoal.Minutes)
   /MAR.MTH.DosageGoal.MinutesMax = MAX(MAR.MTH.DosageGoal.Minutes)
   /APR.MTH.DosageGoal.MinutesMax = MAX(APR.MTH.DosageGoal.Minutes)
   /MAY.MTH.DosageGoal.MinutesMax = MAX(MAY.MTH.DosageGoal.Minutes)
   /JUN.MTH.DosageGoal.MinutesMax = MAX(JUN.MTH.DosageGoal.Minutes)
   /SITE.ELA.FinalEnrollGoal = MEAN(SITE.ELA.FinalEnrollGoal)
   /SITE.MTH.FinalEnrollGoal = MEAN(SITE.MTH.FinalEnrollGoal)
   /SITE.ATT.FinalEnrollGoal = MEAN(SITE.ATT.FinalEnrollGoal)
   /SITE.BEH.FinalEnrollGoal = MEAN(SITE.BEH.FinalEnrollGoal)
   /SITE.Q1.ELA.EnrollGoal = MEAN(SITE.Q1.ELA.EnrollGoal)
   /SITE.Q1.MTH.EnrollGoal = MEAN(SITE.Q1.MTH.EnrollGoal)
   /SITE.Q1.ATT.EnrollGoal = MEAN(SITE.Q1.ATT.EnrollGoal)
   /SITE.Q1.BEH.EnrollGoal = MEAN(SITE.Q1.BEH.EnrollGoal)
   /SITE.Q2.ELA.EnrollGoal = MEAN(SITE.Q2.ELA.EnrollGoal)
   /SITE.Q2.MTH.EnrollGoal = MEAN(SITE.Q2.MTH.EnrollGoal)
   /SITE.Q2.ATT.EnrollGoal = MEAN(SITE.Q2.ATT.EnrollGoal)
   /SITE.Q2.BEH.EnrollGoal = MEAN(SITE.Q2.BEH.EnrollGoal)
   /SITE.Q3.ELA.EnrollGoal = MEAN(SITE.Q3.ELA.EnrollGoal)
   /SITE.Q3.MTH.EnrollGoal = MEAN(SITE.Q3.MTH.EnrollGoal)
   /SITE.Q3.ATT.EnrollGoal = MEAN(SITE.Q3.ATT.EnrollGoal)
   /SITE.Q3.BEH.EnrollGoal = MEAN(SITE.Q3.BEH.EnrollGoal)
   /LITOfficialFL = SUM(LITOfficialFL)
   /MTHOfficialFL = SUM(MTHOfficialFL)
   /ATTOfficialFL = SUM(ATTOfficialFL)
   /BEHOfficialFL = SUM(BEHOfficialFL)
   /LITMetOCTDose = SUM(LITMetOCTDose)
   /MTHMetOCTDose = SUM(MTHMetOCTDose)
   /LITMetNOVDose = SUM(LITMetNOVDose)
   /MTHMetNOVDose = SUM(MTHMetNOVDose)
   /LITMetDECDose = SUM(LITMetDECDose)
   /MTHMetDECDose = SUM(MTHMetDECDose)
   /LITMetJANDose = SUM(LITMetJANDose)
   /MTHMetJANDose = SUM(MTHMetJANDose)
   /LITMetFEBDose = SUM(LITMetFEBDose)
   /MTHMetFEBDose = SUM(MTHMetFEBDose)
   /LITMetMARDose = SUM(LITMetMARDose)
   /MTHMetMARDose = SUM(MTHMetMARDose)
   /LITMetAPRDose = SUM(LITMetAPRDose)
   /MTHMetAPRDose = SUM(MTHMetAPRDose)
   /LITMetMAYDose = SUM(LITMetMAYDose)
   /MTHMetMAYDose = SUM(MTHMetMAYDose)
   /LITMetJUNDose = SUM(LITMetJUNDose)
   /MTHMetJUNDose = SUM(MTHMetJUNDose)
   /ATTMet56Dose = SUM(ATTMet56Dose)
   /BEHMet56Dose = SUM(BEHMet56Dose)
   /LITNotOfficialFL = SUM(LITNotOfficialFL)
   /MTHNotOfficialFL = SUM(MTHNotOfficialFL)
   /ATTNotOfficialFL = SUM(ATTNotOfficialFL)
   /BEHNotOfficialFL = SUM(BEHNotOfficialFL)
   /NotFLLITMetOCTDose = SUM(NotFLLITMetOCTDose)
   /NotFLMTHMetOCTDose = SUM(NotFLMTHMetOCTDose)
   /NotFLLITMetNOVDose = SUM(NotFLLITMetNOVDose)
   /NotFLMTHMetNOVDose = SUM(NotFLMTHMetNOVDose)
   /NotFLLITMetDECDose = SUM(NotFLLITMetDECDose)
   /NotFLMTHMetDECDose = SUM(NotFLMTHMetDECDose)
   /NotFLLITMetJANDose = SUM(NotFLLITMetJANDose)
   /NotFLMTHMetJANDose = SUM(NotFLMTHMetJANDose)
   /NotFLLITMetFEBDose = SUM(NotFLLITMetFEBDose)
   /NotFLMTHMetFEBDose = SUM(NotFLMTHMetFEBDose)
   /NotFLLITMetMARDose = SUM(NotFLLITMetMARDose)
   /NotFLMTHMetMARDose = SUM(NotFLMTHMetMARDose)
   /NotFLLITMetAPRDose = SUM(NotFLLITMetAPRDose)
   /NotFLMTHMetAPRDose = SUM(NotFLMTHMetAPRDose)
   /NotFLLITMetMAYDose = SUM(NotFLLITMetMAYDose)
   /NotFLMTHMetMAYDose = SUM(NotFLMTHMetMAYDose)
   /NotFLLITMetJUNDose = SUM(NotFLLITMetJUNDose)
   /NotFLMTHMetJUNDose = SUM(NotFLMTHMetJUNDose)
   /NotFLATTMet56Dose = SUM(NotFLATTMet56Dose)
   /NotFLBEHMet56Dose = SUM(NotFLBEHMet56Dose)
   /LEAD_LIT39_SampleSize = SUM(LEAD_LIT39_SampleSize)
   /LEAD_MTH39_SampleSize = SUM(LEAD_MTH39_SampleSize)
   /LEAD_ATT69_SampleSize = SUM(LEAD_ATT69_SampleSize)
   /LEAD_LIT39_SOS = SUM(LEAD_LIT39_SOS)
   /LEAD_MTH39_SOS = SUM(LEAD_MTH39_SOS)
   /LEAD_ATT69_StartLT90ADA = SUM(LEAD_ATT69_StartLT90ADA)
   /LITAssess_FLComp_SampleSize = SUM(LITAssess_FLComp_SampleSize)
   /LITAssess_FLComp_SOS = SUM(LITAssess_FLComp_SOS)
   /ELACG_FLComp_SampleSize = SUM(ELACG_FLComp_SampleSize)
   /ELACG_FLComp_SOS = SUM(ELACG_FLComp_SOS)
   /MTHAssess_FLComp_SampleSize = SUM(MTHAssess_FLComp_SampleSize)
   /MTHAssess_FLComp_SOS = SUM(MTHAssess_FLComp_SOS)
   /MTHCG_FLComp_SampleSize = SUM(MTHCG_FLComp_SampleSize)
   /MTHCG_FLComp_SOS = SUM(MTHCG_FLComp_SOS)
   /JAN.ELA.GoalDistance.0t25 =SUM(JAN.ELA.GoalDistance.0t25)
   /JAN.ELA.GoalDistance.25t.5 =SUM(JAN.ELA.GoalDistance.25t.5 )
   /JAN.ELA.GoalDistance.5t.75 =SUM(JAN.ELA.GoalDistance.5t.75)
   /JAN.ELA.GoalDistance.75to1  =SUM(JAN.ELA.GoalDistance.75to1 )
   /JAN.ELA.GoalDistance.1to1.25 =SUM(JAN.ELA.GoalDistance.1to1.25)
   /JAN.ELA.GoalDistance.1.25to1.5 =SUM(JAN.ELA.GoalDistance.1.25to1.5)
   /JAN.ELA.GoalDistance.1.5to1.75=SUM(JAN.ELA.GoalDistance.1.5to1.75)
   /JAN.ELA.GoalDistance.1.75up=SUM(JAN.ELA.GoalDistance.1.75up)
   /JAN.ELA.GoalDistance.SampleSize=SUM(JAN.ELA.GoalDistance.SampleSize)
   /JAN.MTH.GoalDistance.0t25 =SUM(JAN.MTH.GoalDistance.0t25)
   /JAN.MTH.GoalDistance.25t.5 =SUM(JAN.MTH.GoalDistance.25t.5 )
   /JAN.MTH.GoalDistance.5t.75 =SUM(JAN.MTH.GoalDistance.5t.75)
   /JAN.MTH.GoalDistance.75to1  =SUM(JAN.MTH.GoalDistance.75to1 )
   /JAN.MTH.GoalDistance.1to1.25 =SUM(JAN.MTH.GoalDistance.1to1.25)
   /JAN.MTH.GoalDistance.1.25to1.5 =SUM(JAN.MTH.GoalDistance.1.25to1.5)
   /JAN.MTH.GoalDistance.1.5to1.75=SUM(JAN.MTH.GoalDistance.1.5to1.75)
   /JAN.MTH.GoalDistance.1.75up=SUM(JAN.MTH.GoalDistance.1.75up)
   /JAN.MTH.GoalDistance.SampleSize=SUM(JAN.MTH.GoalDistance.SampleSize).

DATASET ACTIVATE FINALSITEDATASET39ONLY.

***** Calculate % met dosage variables and % met IOG.
*****    Official FL.
COMPUTE LITMetOCTDosePerc = LITMetOCTDose / LITOfficialFL.
COMPUTE MTHMetOCTDosePerc = MTHMetOCTDose / MTHOfficialFL.
COMPUTE LITMetNOVDosePerc = LITMetNOVDose / LITOfficialFL.
COMPUTE MTHMetNOVDosePerc = MTHMetNOVDose / MTHOfficialFL.
COMPUTE LITMetDECDosePerc = LITMetDECDose / LITOfficialFL.
COMPUTE MTHMetDECDosePerc = MTHMetDECDose / MTHOfficialFL.
COMPUTE LITMetJANDosePerc = LITMetJANDose / LITOfficialFL.
COMPUTE MTHMetJANDosePerc = MTHMetJANDose / MTHOfficialFL.
COMPUTE LITMetFEBDosePerc = LITMetFEBDose / LITOfficialFL.
COMPUTE MTHMetFEBDosePerc = MTHMetFEBDose / MTHOfficialFL.
COMPUTE LITMetMARDosePerc = LITMetMARDose / LITOfficialFL.
COMPUTE MTHMetMARDosePerc = MTHMetMARDose / MTHOfficialFL.
COMPUTE LITMetAPRDosePerc = LITMetAPRDose / LITOfficialFL.
COMPUTE MTHMetAPRDosePerc = MTHMetAPRDose / MTHOfficialFL.
COMPUTE LITMetMAYDosePerc = LITMetMAYDose / LITOfficialFL.
COMPUTE MTHMetMAYDosePerc = MTHMetMAYDose / MTHOfficialFL.
COMPUTE LITMetJUNDosePerc = LITMetJUNDose / LITOfficialFL.
COMPUTE MTHMetJUNDosePerc = MTHMetJUNDose / MTHOfficialFL.
COMPUTE ATTMet56DosePerc = ATTMet56Dose / ATTOfficialFL.
COMPUTE BEHMet56DosePerc = BEHMet56Dose / BEHOfficialFL.
*****    Unofficial FL.
COMPUTE NotFLLITMetOCTDosePerc = NotFLLITMetOCTDose / LITNotOfficialFL.
COMPUTE NotFLMTHMetOCTDosePerc = NotFLMTHMetOCTDose / MTHNotOfficialFL.
COMPUTE NotFLLITMetNOVDosePerc = NotFLLITMetNOVDose / LITNotOfficialFL.
COMPUTE NotFLMTHMetNOVDosePerc = NotFLMTHMetNOVDose / MTHNotOfficialFL.
COMPUTE NotFLLITMetDECDosePerc = NotFLLITMetDECDose / LITNotOfficialFL.
COMPUTE NotFLMTHMetDECDosePerc = NotFLMTHMetDECDose / MTHNotOfficialFL.
COMPUTE NotFLLITMetJANDosePerc = NotFLLITMetJANDose / LITNotOfficialFL.
COMPUTE NotFLMTHMetJANDosePerc = NotFLMTHMetJANDose / MTHNotOfficialFL.
COMPUTE NotFLLITMetFEBDosePerc = NotFLLITMetFEBDose / LITNotOfficialFL.
COMPUTE NotFLMTHMetFEBDosePerc = NotFLMTHMetFEBDose / MTHNotOfficialFL.
COMPUTE NotFLLITMetMARDosePerc = NotFLLITMetMARDose / LITNotOfficialFL.
COMPUTE NotFLMTHMetMARDosePerc = NotFLMTHMetMARDose / MTHNotOfficialFL.
COMPUTE NotFLLITMetAPRDosePerc = NotFLLITMetAPRDose / LITNotOfficialFL.
COMPUTE NotFLMTHMetAPRDosePerc = NotFLMTHMetAPRDose / MTHNotOfficialFL.
COMPUTE NotFLLITMetMAYDosePerc = NotFLLITMetMAYDose / LITNotOfficialFL.
COMPUTE NotFLMTHMetMAYDosePerc = NotFLMTHMetMAYDose / MTHNotOfficialFL.
COMPUTE NotFLLITMetJUNDosePerc = NotFLLITMetJUNDose / LITNotOfficialFL.
COMPUTE NotFLMTHMetJUNDosePerc = NotFLMTHMetJUNDose / MTHNotOfficialFL.
COMPUTE NotFLATTMet56DosePerc = NotFLATTMet56Dose / ATTNotOfficialFL.
COMPUTE NotFLBEHMet56DosePerc = NotFLBEHMet56Dose / BEHNotOfficialFL.
*****     Lead Measures.
COMPUTE LEAD_LIT39_SOSPerc = LEAD_LIT39_SOS / LEAD_LIT39_SampleSize.
COMPUTE LEAD_MTH39_SOSPerc = LEAD_MTH39_SOS / LEAD_MTH39_SampleSize.
COMPUTE LEAD_ATT69_StartLT90ADAPerc = LEAD_ATT69_StartLT90ADA / LEAD_ATT69_SampleSize.
COMPUTE LITAssess_FLComp_SOSPerc = LITAssess_FLComp_SOS / LITAssess_FLComp_SampleSize.
COMPUTE ELACG_FLComp_SOSPerc = ELACG_FLComp_SOS / ELACG_FLComp_SampleSize.
COMPUTE MTHAssess_FLComp_SOSPerc = MTHAssess_FLComp_SOS / MTHAssess_FLComp_SampleSize.
COMPUTE MTHCG_FLComp_SOSPerc = MTHCG_FLComp_SOS / MTHCG_FLComp_SampleSize.
*****     Calculate % in each ELA goal distance category.
COMPUTE JAN.ELA.GoalDistance.0t25perc =JAN.ELA.GoalDistance.0t25/JAN.ELA.GoalDistance.SampleSize.
COMPUTE JAN.ELA.GoalDistance.25t.5perc =JAN.ELA.GoalDistance.25t.5/JAN.ELA.GoalDistance.SampleSize.
COMPUTE JAN.ELA.GoalDistance.5t.75perc =JAN.ELA.GoalDistance.5t.75/JAN.ELA.GoalDistance.SampleSize.
COMPUTE JAN.ELA.GoalDistance.75to1perc  =JAN.ELA.GoalDistance.75to1/JAN.ELA.GoalDistance.SampleSize.
COMPUTE JAN.ELA.GoalDistance.1to1.25perc =JAN.ELA.GoalDistance.1to1.25/JAN.ELA.GoalDistance.SampleSize.
COMPUTE JAN.ELA.GoalDistance.1.25to1.5perc =JAN.ELA.GoalDistance.1.25to1.5/JAN.ELA.GoalDistance.SampleSize.
COMPUTE JAN.ELA.GoalDistance.1.5to1.75perc=JAN.ELA.GoalDistance.1.5to1.75/JAN.ELA.GoalDistance.SampleSize.
COMPUTE JAN.ELA.GoalDistance.1.75upperc=JAN.ELA.GoalDistance.1.75up/JAN.ELA.GoalDistance.SampleSize.
*****     Calculate % in each MTH goal distance category.
COMPUTE JAN.MTH.GoalDistance.0t25perc =JAN.MTH.GoalDistance.0t25/JAN.MTH.GoalDistance.SampleSize.
COMPUTE JAN.MTH.GoalDistance.25t.5perc =JAN.MTH.GoalDistance.25t.5/JAN.MTH.GoalDistance.SampleSize.
COMPUTE JAN.MTH.GoalDistance.5t.75perc =JAN.MTH.GoalDistance.5t.75/JAN.MTH.GoalDistance.SampleSize.
COMPUTE JAN.MTH.GoalDistance.75to1perc  =JAN.MTH.GoalDistance.75to1/JAN.MTH.GoalDistance.SampleSize.
COMPUTE JAN.MTH.GoalDistance.1to1.25perc =JAN.MTH.GoalDistance.1to1.25/JAN.MTH.GoalDistance.SampleSize.
COMPUTE JAN.MTH.GoalDistance.1.25to1.5perc =JAN.MTH.GoalDistance.1.25to1.5/JAN.MTH.GoalDistance.SampleSize.
COMPUTE JAN.MTH.GoalDistance.1.5to1.75perc=JAN.MTH.GoalDistance.1.5to1.75/JAN.MTH.GoalDistance.SampleSize.
COMPUTE JAN.MTH.GoalDistance.1.75upperc=JAN.MTH.GoalDistance.1.75up/JAN.MTH.GoalDistance.SampleSize.
EXECUTE.

***** Add variable and value labels.
VARIABLE LABELS LITMetOCTDosePerc "DOSAGE ACTUAL\n% of Students Meeting ELA/Literacy OCTOBER Dosage Benchmark (out of ACTUAL FL Enrollment)"
   MTHMetOCTDosePerc "DOSAGE ACTUAL\n% of Students Meeting Math OCTOBER Dosage Benchmark (out of ACTUAL FL Enrollment)"
   LITMetNOVDosePerc "DOSAGE ACTUAL\n% of Students Meeting ELA/Literacy NOVEMBER Dosage Benchmark (out of ACTUAL FL Enrollment)"
   MTHMetNOVDosePerc "DOSAGE ACTUAL\n% of Students Meeting Math NOVEMBER Dosage Benchmark (out of ACTUAL FL Enrollment)"
   LITMetDECDosePerc "DOSAGE ACTUAL\n% of Students Meeting ELA/Literacy DECEMBER Dosage Benchmark (out of ACTUAL FL Enrollment)"
   MTHMetDECDosePerc "DOSAGE ACTUAL\n% of Students Meeting Math DECEMBER Dosage Benchmark (out of ACTUAL FL Enrollment)"
   LITMetJANDosePerc "DOSAGE ACTUAL\n% of Students Meeting ELA/Literacy JANUARY Dosage Benchmark (out of ACTUAL FL Enrollment)"
   MTHMetJANDosePerc "DOSAGE ACTUAL\n% of Students Meeting Math JANUARY Dosage Benchmark (out of ACTUAL FL Enrollment)"
   LITMetFEBDosePerc "DOSAGE ACTUAL\n% of Students Meeting ELA/Literacy FEBRUARY Dosage Benchmark (out of ACTUAL FL Enrollment)"
   MTHMetFEBDosePerc "DOSAGE ACTUAL\n% of Students Meeting Math FEBRUARY Dosage Benchmark (out of ACTUAL FL Enrollment)"
   LITMetMARDosePerc "DOSAGE ACTUAL\n% of Students Meeting ELA/Literacy MARCH Dosage Benchmark (out of ACTUAL FL Enrollment)"
   MTHMetMARDosePerc "DOSAGE ACTUAL\n% of Students Meeting Math MARCH Dosage Benchmark (out of ACTUAL FL Enrollment)"
   LITMetAPRDosePerc "DOSAGE ACTUAL\n% of Students Meeting ELA/Literacy APRIL Dosage Benchmark (out of ACTUAL FL Enrollment)"
   MTHMetAPRDosePerc "DOSAGE ACTUAL\n% of Students Meeting Math APRIL Dosage Benchmark (out of ACTUAL FL Enrollment)"
   LITMetMAYDosePerc "DOSAGE ACTUAL\n% of Students Meeting ELA/Literacy MAY Dosage Benchmark (out of ACTUAL FL Enrollment)"
   MTHMetMAYDosePerc "DOSAGE ACTUAL\n% of Students Meeting Math MAY Dosage Benchmark (out of ACTUAL FL Enrollment)"
   LITMetJUNDosePerc "DOSAGE ACTUAL\n% of Students Meeting ELA/Literacy JUNE Dosage Benchmark (out of ACTUAL FL Enrollment)"
   MTHMetJUNDosePerc "DOSAGE ACTUAL\n% of Students Meeting Math JUNE Dosage Benchmark (out of ACTUAL FL Enrollment)"
   NotFLLITMetOCTDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting ELA/Literacy OCTOBER Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLMTHMetOCTDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting Math OCTOBER Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLLITMetNOVDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting ELA/Literacy NOVEMBER Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLMTHMetNOVDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting Math NOVEMBER Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLLITMetDECDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting ELA/Literacy DECEMBER Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLMTHMetDECDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting Math DECEMBER Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLLITMetJANDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting ELA/Literacy JANUARY Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLMTHMetJANDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting Math JANUARY Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLLITMetFEBDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting ELA/Literacy FEBRUARY Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLMTHMetFEBDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting Math FEBRUARY Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLLITMetMARDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting ELA/Literacy MARCH Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLMTHMetMARDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting Math MARCH Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLLITMetAPRDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting ELA/Literacy APRIL Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLMTHMetAPRDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting Math APRIL Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLLITMetMAYDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting ELA/Literacy MAY Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLMTHMetMAYDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting Math MAY Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLLITMetJUNDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting ELA/Literacy JUNE Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   NotFLMTHMetJUNDosePerc "DOSAGE RESULT\nUNOFFICIAL FL\n% of Students Meeting Math JUNE Dosage Benchmark (out of UNOFFICIAL FL Enrollment)"
   LEAD_LIT39_SOSPerc "LEAD MEASURE RESULT\n% of Students Starting Off-Track/Sliding in ELA/Literacy (3rd-9th Grade)"
   LEAD_MTH39_SOSPerc "LEAD MEASURE RESULT\n% of Students Starting Off-Track/Sliding in Math (3rd-9th Grade)"
   LEAD_ATT69_StartLT90ADAPerc "LEAD MEASURE RESULT\n% of Students Starting Off-Track/Sliding in Attendance (6th-9th Grade)"
   LITAssess_FLComp_SOSPerc "% Students Starting Off-Track/Sliding in Literacy Assessments (3rd-9th Grade)"
   ELACG_FLComp_SOSPerc "% Students Starting Off-Track/Sliding in ELA Course Grades (6th-9th Grade)"
   MTHAssess_FLComp_SOSPerc "% Students Starting Off-Track/Sliding in Math Assessments (3rd-9th Grade)"
   MTHCG_FLComp_SOSPerc "% Students Starting Off-Track/Sliding in Math Course Grades (6th-9th Grade)"
   JAN.ELA.GoalDistance.0t25perc "% of Students Missed Dosage Goal by 75% or more%" 
   JAN.ELA.GoalDistance.25t.5perc  "% of Students Missed Dosage Goal by 50% to 74.99%" 
   JAN.ELA.GoalDistance.5t.75perc  "% of Students Missed Dosage Goal by 25% to 49.99%"
   JAN.ELA.GoalDistance.75to1perc   "% of Students Missed Dosage Goal by 0.01% to 24.99%" 
   JAN.ELA.GoalDistance.1to1.25perc  "% of Students Met or Exceeded Dosage Goal up to 25%"
   JAN.ELA.GoalDistance.1.25to1.5perc  "% of Students Exceeded Dosage Goal by 25% to 49.99%" 
   JAN.ELA.GoalDistance.1.5to1.75perc  "% of Students Exceeded Dosage Goal by 50% to 74.99%"
   JAN.ELA.GoalDistance.1.75upperc  "% of Students Exceeded Dosage Goal by 75% or more"
   JAN.MTH.GoalDistance.0t25perc "% of Students Missed Dosage Goal by 75% or more%" 
   JAN.MTH.GoalDistance.25t.5perc  "% of Students Missed Dosage Goal by 50% to 74.99%" 
   JAN.MTH.GoalDistance.5t.75perc  "% of Students Missed Dosage Goal by 25% to 49.99%"
   JAN.MTH.GoalDistance.75to1perc   "% of Students Missed Dosage Goal by 0.01% to 24.99%" 
   JAN.MTH.GoalDistance.1to1.25perc  "% of Students Met or Exceeded Dosage Goal up to 25%"
   JAN.MTH.GoalDistance.1.25to1.5perc  "% of Students Exceeded Dosage Goal by 25% to 49.99%" 
   JAN.MTH.GoalDistance.1.5to1.75perc  "% of Students Exceeded Dosage Goal by 50% to 74.99%"
   JAN.MTH.GoalDistance.1.75upperc  "% of Students Exceeded Dosage Goal by 75% or more".
VALUE LABELS RegionID 1 "Florida"
2 "Midwest"
3 "Northeast"
4 "South"
5 "West".
EXECUTE.

***** No longer need TEAMAGG dataset.
DATASET CLOSE TEAMAGG.

******************************************************************************************************************************************************
***** END OF FILE.
******************************************************************************************************************************************************