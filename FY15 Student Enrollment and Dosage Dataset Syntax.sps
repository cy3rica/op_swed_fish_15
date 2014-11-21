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
  /FILE='Z:\Cross Instrument\FY15\Source Data\Total Student Dosage per IA - Mod - 2014.11.21.xlsx' 
  /SHEET=index 1
  /CELLRANGE=full 
  /READNAMES=on 
  /ASSUMEDSTRWIDTH=32767. 
EXECUTE. 
DATASET NAME StudentEnrollDosage.

***** Pull up school name to ID translation file.
GET DATA /TYPE=XLSX 
  /FILE='Z:\Cross Instrument\FY15\Source Data\cyschoolhouse FY15 Schools 2014.11.21.xlsx' 
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
  /FILE='Z:\Cross Instrument\FY15\Source Data\cychannel FY15 List of Schools 2014.11.21.xlsx' 
  /SHEET=index 1
  /CELLRANGE=full 
  /READNAMES=on 
  /ASSUMEDSTRWIDTH=32767. 
EXECUTE. 
DATASET NAME cychanSchoolInfo.

***** Pull up team-level enrollment and dosage goals.
GET DATA  /TYPE=TXT
  /FILE="Z:\Cross Instrument\FY15\Source Data\FY15 School-Level Quarterly Enrollment and Monthly Dosage Targets 2014-11-05.csv"
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
  /FILE="Z:\Cross Instrument\FY15\Source Data\FY15 Site-Level Quarterly Enrollment and Monthly Dosage Targets 2014-11-05.csv"
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
XSAVE OUTFILE='TeamEnrollDosageByGrade'
   /KEEP ALL. 
END LOOP. 
EXECUTE. 
GET FILE 'TeamEnrollDosageByGrade'. 
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
***** Calculate Met/Not Met Enrollment and Dosage Variables.
******************************************************************************************************************************************************

***** Calculate Met/Not Met Enrollment Variables -- USE THESE FOR ANALYSIS TO COUNT/SELECT OFFICIAL FL #s.
IF (IALIT = 1 & EnrollDate.LIT >= DATE.MDY(07,1,2014) & EnrollDate.LIT <= XDATE.DATE($TIME) &
ExitDate.LIT >= DATE.MDY(07,01,2014) & ExitDate.LIT <= XDATE.DATE($TIME)) LITOfficialFL = 1.
IF (IALIT = 0 & EnrollDate.LIT >= DATE.MDY(07,1,2014) & EnrollDate.LIT <= XDATE.DATE($TIME) &
ExitDate.LIT >= DATE.MDY(07,01,2014) & ExitDate.LIT <= XDATE.DATE($TIME)) LITOfficialFL = 0.
IF (IAMTH = 1 & EnrollDate.MTH >= DATE.MDY(07,1,2014) & EnrollDate.MTH <= XDATE.DATE($TIME) &
ExitDate.MTH >= DATE.MDY(07,01,2014) & ExitDate.MTH <= XDATE.DATE($TIME)) MTHOfficialFL = 1.
IF (IAMTH = 0 & EnrollDate.MTH >= DATE.MDY(07,1,2014) & EnrollDate.MTH <= XDATE.DATE($TIME) &
ExitDate.MTH >= DATE.MDY(07,01,2014) & ExitDate.MTH <= XDATE.DATE($TIME)) MTHOfficialFL = 0.
IF (IAATT = 1 & EnrollDate.ATT >= DATE.MDY(07,1,2014) & EnrollDate.ATT <= XDATE.DATE($TIME) &
ExitDate.ATT >= DATE.MDY(07,01,2014) & ExitDate.ATT <= XDATE.DATE($TIME)) ATTOfficialFL = 1.
IF (IAATT = 0 & EnrollDate.ATT >= DATE.MDY(07,1,2014) & EnrollDate.ATT <= XDATE.DATE($TIME) &
ExitDate.ATT >= DATE.MDY(07,01,2014) & ExitDate.ATT <= XDATE.DATE($TIME)) ATTOfficialFL = 0.
IF (IABEH = 1 & EnrollDate.BEH >= DATE.MDY(07,1,2014) & EnrollDate.BEH <= XDATE.DATE($TIME) &
ExitDate.BEH >= DATE.MDY(07,01,2014) & ExitDate.BEH <= XDATE.DATE($TIME)) BEHOfficialFL = 1.
IF (IABEH = 0 & EnrollDate.BEH >= DATE.MDY(07,1,2014) & EnrollDate.BEH <= XDATE.DATE($TIME) &
ExitDate.BEH >= DATE.MDY(07,01,2014) & ExitDate.BEH <= XDATE.DATE($TIME)) BEHOfficialFL = 0.
VARIABLE LABELS LITOfficialFL "ENROLL ACTUAL\nNumber of Students Enrolled 30+ Days (ELA/Literacy, with overlap)"
   MTHOfficialFL "ENROLL ACTUAL\nNumber of Students Enrolled (Math, with overlap)"
   ATTOfficialFL "ENROLL ACTUAL\nNumber of Students Enrolled (Attendance, with overlap)"
   BEHOfficialFL "ENROLL ACTUAL\nNumber of Students Enrolled (Behavior, with overlap)".
VALUE LABELS LITOfficialFL MTHOfficialFL ATTOfficialFL BEHOfficialFL 0 "Enrolled, no IA-assignment"
   1 "Official FL: Enrolled and IA-assigned".
EXECUTE.

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

******************************************************************************************************************************************************
***** Create additional variables.
******************************************************************************************************************************************************

***** Create regional variable.
RECODE Location ("Baton Rouge" = 4) ("Boston" = 3) ("Chicago" = 2) ("Cleveland" = 2) ("Columbia" = 4) ("Columbus" = 2) ("Denver" = 5) ("Detroit" = 2) ("Jacksonville" = 1)
("Little Rock" = 4) ("Los Angeles" = 5) ("Miami" = 1) ("Milwaukee" = 2) ("New Hampshire" = 3) ("New Orleans" = 4) ("New York" = 3) ("Orlando" = 1) ("Philadelphia" = 1)
("Rhode Island" = 3) ("Sacramento" = 5) ("San Antonio" = 4) ("San Jose" = 5) ("Seattle" = 5) ("Tulsa" = 4) ("Washington, DC" = 1) (ELSE = SYSMIS) INTO RegionID.
VALUE LABELS RegionID 1 "Atlantic"
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
   /ATTMet56Dose = SUM(ATTMet56Dose)
   /BEHMet56Dose = SUM(BEHMet56Dose).

DATASET ACTIVATE FINALTEAMDATASET39ONLY.

***** Calculate % met dosage variables and % met IOG.
COMPUTE LITMetOCTDosePerc = LITMetOCTDose / LITOfficialFL.
COMPUTE MTHMetOCTDosePerc = MTHMetOCTDose / MTHOfficialFL.
COMPUTE ATTMet56DosePerc = ATTMet56Dose / ATTOfficialFL.
COMPUTE BEHMet56DosePerc = BEHMet56Dose / BEHOfficialFL.
EXECUTE.

***** Add variable labels.

VALUE LABELS DNSchool 0 "Not a Diplomas Now School"
   1 "Diplomas Now School".
VALUE LABELS RegionID 1 "Atlantic"
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
   /ATTMet56Dose = SUM(ATTMet56Dose)
   /BEHMet56Dose = SUM(BEHMet56Dose).

DATASET ACTIVATE FINALSITEDATASET39ONLY.

***** Calculate % met dosage variables and % met IOG.
COMPUTE LITMetOCTDosePerc = LITMetOCTDose / LITOfficialFL.
COMPUTE MTHMetOCTDosePerc = MTHMetOCTDose / MTHOfficialFL.
COMPUTE ATTMet56DosePerc = ATTMet56Dose / ATTOfficialFL.
COMPUTE BEHMet56DosePerc = BEHMet56Dose / BEHOfficialFL.
EXECUTE.

***** Add variable labels.

VALUE LABELS RegionID 1 "Atlantic"
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