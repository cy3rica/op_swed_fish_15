******************************************************************************************************************************************************
***** Student Performance Data Download Syntax.
******************************************************************************************************************************************************
***** This file downloads student performance data from the Impact Analytics SQL database.
***** This file (1) first pulls up each dataset from the database, then (2) saves all datasets to your specified location on your
***** computer, then (3) closes all datasets. 
******************************************************************************************************************************************************
***** Instructions: BEFORE RUNNING SYNTAX, AT END OF FILE, UPDATE (without these updates, you may overwrite data):
*****     1.) Directory addresses,
*****     2.) File name dates, and
*****     3.) (If necessary) WSID parameter for each GET DATA command (replace HQSSPSS with your computer username).
******************************************************************************************************************************************************
***** Note: you can either run this entire file to download and save all student performance datasets, or just run portions of the file
***** for specific datasets.
******************************************************************************************************************************************************

******************************************************************************************************************************************************
***** Attendance.
******************************************************************************************************************************************************

GET DATA
  /TYPE=ODBC
  /CONNECT='DSN=ImpactAnalytics;UID=;Trusted_Connection=Yes;APP=IBM SPSS Products: Statistics '+
    'Common;WSID=HQSSPSS;DATABASE=ImpactAnalytics'
  /SQL='SELECT ATT.* FROM ImpactAnalytics.dbo.[FY15_SOY_ATT] AS ATT'
  /ASSUMEDSTRWIDTH=255.
CACHE.
EXECUTE.
DATASET NAME ATT.

******************************************************************************************************************************************************
***** Behavior Rubric.
******************************************************************************************************************************************************

GET DATA
  /TYPE=ODBC
  /CONNECT='DSN=ImpactAnalytics;UID=;Trusted_Connection=Yes;APP=IBM SPSS Products: Statistics '+
    'Common;WSID=HQSSPSS;DATABASE=ImpactAnalytics'
  /SQL='SELECT BEHRUB.* FROM ImpactAnalytics.dbo.[FY15_SOY_BEH_RUBRIC] AS BEHRUB'
  /ASSUMEDSTRWIDTH=255.
CACHE.
EXECUTE.
DATASET NAME BEHRUB.

******************************************************************************************************************************************************
***** Behavior - School-Based.
******************************************************************************************************************************************************

GET DATA
  /TYPE=ODBC
  /CONNECT='DSN=ImpactAnalytics;UID=;Trusted_Connection=Yes;APP=IBM SPSS Products: Statistics '+
    'Common;WSID=HQSSPSS;DATABASE=ImpactAnalytics'
  /SQL='SELECT BEHSCH.* FROM ImpactAnalytics.dbo.[FY15_SOY_BEH_SCHOOL_BASED] AS BEHSCH'
  /ASSUMEDSTRWIDTH=255.
CACHE.
EXECUTE.
DATASET NAME BEHSCH.

******************************************************************************************************************************************************
***** Literacy Assessments.
******************************************************************************************************************************************************

GET DATA
  /TYPE=ODBC
  /CONNECT='DSN=ImpactAnalytics;UID=;Trusted_Connection=Yes;APP=IBM SPSS Products: Statistics '+
    'Common;WSID=HQSSPSS;DATABASE=ImpactAnalytics'
  /SQL='SELECT LITASSESS.* FROM ImpactAnalytics.dbo.[FY15_SOY_LIT_ASSESS] AS LITASSESS'
  /ASSUMEDSTRWIDTH=255.
CACHE.
EXECUTE.
DATASET NAME LITASSESS.

******************************************************************************************************************************************************
***** Literacy Assessments, ELA Course Grades Combined.
******************************************************************************************************************************************************

GET DATA
  /TYPE=ODBC
  /CONNECT='DSN=ImpactAnalytics;UID=;Trusted_Connection=Yes;APP=IBM SPSS Products: Statistics '+
    'Common;WSID=HQSSPSS;DATABASE=ImpactAnalytics'
  /SQL='SELECT LITASSESSELACG.* FROM ImpactAnalytics.dbo.[FY15_SOY_LIT_ASSESS_ELA_CG] AS LITASSESSELACG'
  /ASSUMEDSTRWIDTH=255.
CACHE.
EXECUTE.
DATASET NAME LITASSESSELACG.

******************************************************************************************************************************************************
***** ELA Course Grades.
******************************************************************************************************************************************************

GET DATA
  /TYPE=ODBC
  /CONNECT='DSN=ImpactAnalytics;UID=;Trusted_Connection=Yes;APP=IBM SPSS Products: Statistics '+
    'Common;WSID=HQSSPSS;DATABASE=ImpactAnalytics'
  /SQL='SELECT ELACG.* FROM ImpactAnalytics.dbo.[FY15_SOY_ELA_CG] AS ELACG'
  /ASSUMEDSTRWIDTH=255.
CACHE.
EXECUTE.
DATASET NAME ELACG.

******************************************************************************************************************************************************
***** ELA Standards-Based Course Grades.
******************************************************************************************************************************************************

GET DATA
  /TYPE=ODBC
  /CONNECT='DSN=ImpactAnalytics;UID=;Trusted_Connection=Yes;APP=IBM SPSS Products: Statistics '+
    'Common;WSID=HQSSPSS;DATABASE=ImpactAnalytics'
  /SQL='SELECT ELASB.* FROM ImpactAnalytics.dbo.[FY15_SOY_ELA_SB] AS ELASB'
  /ASSUMEDSTRWIDTH=255.
CACHE.
EXECUTE.
DATASET NAME ELASB.

******************************************************************************************************************************************************
***** Math Assessments.
******************************************************************************************************************************************************

GET DATA
  /TYPE=ODBC
  /CONNECT='DSN=ImpactAnalytics;UID=;Trusted_Connection=Yes;APP=IBM SPSS Products: Statistics '+
    'Common;WSID=HQSSPSS;DATABASE=ImpactAnalytics'
  /SQL='SELECT MTHASSESS.* FROM ImpactAnalytics.dbo.[FY15_SOY_MTH_ASSESS] AS MTHASSESS'
  /ASSUMEDSTRWIDTH=255.
CACHE.
EXECUTE.
DATASET NAME MTHASSESS.

******************************************************************************************************************************************************
***** Math Assessments, Math Course Grades Combined.
******************************************************************************************************************************************************

GET DATA
  /TYPE=ODBC
  /CONNECT='DSN=ImpactAnalytics;UID=;Trusted_Connection=Yes;APP=IBM SPSS Products: Statistics '+
    'Common;WSID=HQSSPSS;DATABASE=ImpactAnalytics'
  /SQL='SELECT MTHASSESSMTHCG.* FROM ImpactAnalytics.dbo.[FY15_SOY_MTH_ASSESS_MTH_CG] AS MTHASSESSMTHCG'
  /ASSUMEDSTRWIDTH=255.
CACHE.
EXECUTE.
DATASET NAME MTHASSESSMTHCG.

******************************************************************************************************************************************************
***** Math Course Grades.
******************************************************************************************************************************************************

GET DATA
  /TYPE=ODBC
  /CONNECT='DSN=ImpactAnalytics;UID=;Trusted_Connection=Yes;APP=IBM SPSS Products: Statistics '+
    'Common;WSID=HQSSPSS;DATABASE=ImpactAnalytics'
  /SQL='SELECT MTHCG.* FROM ImpactAnalytics.dbo.[FY15_SOY_MTH_CG] AS MTHCG'
  /ASSUMEDSTRWIDTH=255.
CACHE.
EXECUTE.
DATASET NAME MTHCG.

******************************************************************************************************************************************************
***** Math Standards-Based Course Grades.
******************************************************************************************************************************************************

GET DATA
  /TYPE=ODBC
  /CONNECT='DSN=ImpactAnalytics;UID=;Trusted_Connection=Yes;APP=IBM SPSS Products: Statistics '+
    'Common;WSID=HQSSPSS;DATABASE=ImpactAnalytics'
  /SQL='SELECT MTHSB.* FROM ImpactAnalytics.dbo.[FY15_SOY_MTH_SB] AS MTHSB'
  /ASSUMEDSTRWIDTH=255.
CACHE.
EXECUTE.
DATASET NAME MTHSB.

******************************************************************************************************************************************************
***** Save all datasets.
******************************************************************************************************************************************************

DATASET ACTIVATE ATT.
SAVE OUTFILE = "Z:\Cross Instrument\FY15\Source Data\FY15 SOY ATT 2014.12.04.sav".
DATASET ACTIVATE BEHRUB.
SAVE OUTFILE = "Z:\Cross Instrument\FY15\Source Data\FY15 SOY BEH RUBRIC 2014.12.04.sav".
DATASET ACTIVATE BEHSCH.
SAVE OUTFILE = "Z:\Cross Instrument\FY15\Source Data\FY15 SOY BEH SCHOOL BASED 2014.12.04.sav".
DATASET ACTIVATE LITASSESS.
SAVE OUTFILE = "Z:\Cross Instrument\FY15\Source Data\FY15 SOY LIT ASSESS 2014.12.04.sav".
DATASET ACTIVATE LITASSESSELACG.
SAVE OUTFILE = "Z:\Cross Instrument\FY15\Source Data\FY15 SOY LIT ASSESS ELA CG 2014.12.04.sav".
DATASET ACTIVATE ELACG.
SAVE OUTFILE = "Z:\Cross Instrument\FY15\Source Data\FY15 SOY ELA CG 2014.12.04.sav".
DATASET ACTIVATE ELASB.
SAVE OUTFILE = "Z:\Cross Instrument\FY15\Source Data\FY15 SOY ELA SB 2014.12.04.sav".
DATASET ACTIVATE MTHASSESS.
SAVE OUTFILE = "Z:\Cross Instrument\FY15\Source Data\FY15 SOY MTH ASSESS 2014.12.04.sav".
DATASET ACTIVATE MTHASSESSMTHCG.
SAVE OUTFILE = "Z:\Cross Instrument\FY15\Source Data\FY15 SOY MTH ASSESS MTH CG 2014.12.04.sav".
DATASET ACTIVATE MTHCG.
SAVE OUTFILE = "Z:\Cross Instrument\FY15\Source Data\FY15 SOY MTH CG 2014.12.04.sav".
DATASET ACTIVATE MTHSB.
SAVE OUTFILE = "Z:\Cross Instrument\FY15\Source Data\FY15 SOY MTH SB 2014.12.04.sav".

******************************************************************************************************************************************************
***** Close all datasets.
******************************************************************************************************************************************************

DATASET CLOSE ATT.
DATASET CLOSE BEHRUB.
DATASET CLOSE BEHSCH.
DATASET CLOSE LITASSESS.
DATASET CLOSE LITASSESSELACG.
DATASET CLOSE ELACG.
DATASET CLOSE ELASB.
DATASET CLOSE MTHASSESS.
DATASET CLOSE MTHASSESSMTHCG.
DATASET CLOSE MTHCG.
DATASET CLOSE MTHSB.

******************************************************************************************************************************************************
***** END OF FILE.
******************************************************************************************************************************************************