******************************************************************************************************************************************************
***** This syntaxs preps grade ranges for IOG reporting and dosage goals for dbo_RPT_SCHOOL_GRADE in the reporting database.
******************************************************************************************************************************************************

******************************************************************************************************************************************************
***** Pull up and define source data files -- don't forget to make sure all ID variables are identical size/format.
******************************************************************************************************************************************************

***** dbo_RPT_SCHOOL_GRADE.
GET DATA
  /TYPE=ODBC
  /CONNECT='DSN=ReportCYData;UID=;Trusted_Connection=Yes;APP=IBM SPSS Products: Statistics '+
    'Common;WSID=HQSSPSS;DATABASE=ReportCYData'
  /SQL='SELECT SCHGRD.* FROM ReportCYData.dbo.[RPT_SCHOOL_GRADE] AS SCHGRD'
  /ASSUMEDSTRWIDTH=255.
CACHE.
EXECUTE.
DATASET NAME SCHOOLGRADE.

***** dbo_RPT_SCHOOL_MAIN.
GET DATA
  /TYPE=ODBC
  /CONNECT='DSN=ReportCYData;UID=;Trusted_Connection=Yes;APP=IBM SPSS Products: Statistics '+
    'Common;WSID=HQSSPSS;DATABASE=ReportCYData'
  /SQL='SELECT SCHMAIN.* FROM ReportCYData.dbo.[RPT_SCHOOL_MAIN] AS SCHMAIN'
  /ASSUMEDSTRWIDTH=255.
CACHE.
EXECUTE.
DATASET NAME SCHOOLMAIN.

***** Team/Grade Level Goals.
GET FILE = "Z:\Cross Instrument\FY15\Source Data\TeamEnrollDosageByGrade.sav".
DATASET NAME TeamGradeGoals.

******************************************************************************************************************************************************
***** Attach cystudentdata school IDs to goals.
******************************************************************************************************************************************************

RENAME VARIABLES (StudentGrade = GRADE_ID).
SORT CASES BY cyschSchoolRefID (A).
EXECUTE.

DATASET ACTIVATE SCHOOLMAIN.
RENAME VARIABLES (CY_CHANNEL_SF_ID = cyschSchoolRefID).
SELECT IF (cyschSchoolRefID ~= "" & FISCAL_YEAR = "2014-2015").
ALTER TYPE cyschSchoolRefID (A18).
SORT CASES BY cyschSchoolRefID (A).
EXECUTE.

MATCH FILES /FILE = TeamGradeGoals
   /TABLE = SCHOOLMAIN
   /BY cyschSchoolRefID
   /KEEP cyschSchoolRefID SCHOOL_ID GRADE_ID JUN.ELA.DosageGoal.Minutes JUN.MTH.DosageGoal.Minutes
MAR.ELA.DosageGoal.Minutes MAR.MTH.DosageGoal.Minutes.
DATASET NAME TeamGradeGoals.
EXECUTE.

******************************************************************************************************************************************************
***** Restructure dataset so that each row is a unique school/grade/indicator.
******************************************************************************************************************************************************

DATASET ACTIVATE TeamGradeGoals.
DATASET COPY ELAGoals.
DATASET COPY MTHGoals.

DATASET ACTIVATE ELAGoals.

DELETE VARIABLES cyschSchoolRefID JUN.MTH.DosageGoal.Minutes MAR.MTH.DosageGoal.Minutes.
RENAME VARIABLES (JUN.ELA.DosageGoal.Minutes = EOYDosageGoal) (MAR.ELA.DosageGoal.Minutes = MYDosageGoal).
COMPUTE INDICATOR_ID = 3.
EXECUTE.

DATASET ACTIVATE MTHGoals.

DELETE VARIABLES cyschSchoolRefID JUN.ELA.DosageGoal.Minutes MAR.ELA.DosageGoal.Minutes.
RENAME VARIABLES (JUN.MTH.DosageGoal.Minutes = EOYDosageGoal) (MAR.MTH.DosageGoal.Minutes = MYDosageGoal).
COMPUTE INDICATOR_ID = 5.
EXECUTE.

ADD FILES FILE = ELAGoals
   /FILE = MTHGoals.
EXECUTE.
DATASET NAME SchoolGradeIAGoals.

******************************************************************************************************************************************************
***** Attach goals to dbo_RPT_SCHOOL_GRADE table.
******************************************************************************************************************************************************

DATASET ACTIVATE SchoolGradeIAGoals.
IF (GRADE_ID = 0) GRADE_ID = 22.
IF (GRADE_ID = -1) GRADE_ID = 21.
SORT CASES BY SCHOOL_ID (A) GRADE_ID (A) INDICATOR_ID (A).
EXECUTE.

MATCH FILES /FILE = SCHOOLGRADE
   /TABLE = SchoolGradeIAGoals
   /BY SCHOOL_ID GRADE_ID INDICATOR_ID.
DATASET NAME SCHOOLGRADE_UPDATE.
EXECUTE.

DATASET ACTIVATE SCHOOLGRADE_UPDATE.

IF (FISCAL_YEAR = "2014-2015") B_RULE_VAL1 = EOYDosageGoal.
IF (FISCAL_YEAR = "2014-2015") B_RULE_VAL2 = MYDosageGoal.
EXECUTE.

DELETE VARIABLES EOYDosageGoal MYDosageGoal.

***** Close unnecessary datasets.
DATASET CLOSE SCHOOLMAIN.
DATASET CLOSE SCHOOLGRADE.
DATASET CLOSE TeamGradeGoals.
DATASET CLOSE SchoolGradeIAGoals.
DATASET CLOSE ELAGoals.
DATASET CLOSE MTHGoals.

******************************************************************************************************************************************************
***** END OF FILE.
******************************************************************************************************************************************************