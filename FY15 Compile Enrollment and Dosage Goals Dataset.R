################################################################################
# FY15 Process RSO Enrollment and Dosage Targets.
################################################################################

################################################################################
# Set up.
################################################################################

# SPECIFY PARAMETERS.
# Date of previous files/run.
oldDate <- "2014-11-04"
# Location of current source data.
sourceFiles <- "Z:/Cross Instrument/FY15/Source Data"
# Location of archived data files (OLD FILES).
oldDataLocation <- "Z:/Cross Instrument/FY15/Source Data/OLD FILES"

# Set working directory.
setwd(sourceFiles)

# Call libraries.
library(xlsx)
library(plyr)

# List of file names.
fileNames <- c("Atlantic_FY15 Site Goals_Approved_Org Source of Record",
              "MidWest_FY15 Site Goals_Approved_Org Source of Record",
              "NorthEast_FY15 Site Goals_Approved_Org Source of Record",
              "SOUTH_FY15 Site Goals_Approved_Org Source of Record",
              "West_FY15 Site Goals_Approved_Org Source of Record",
              "Network Summary_FY15 Goals_Org Source of Record",
              "Check Data Headers",
              "FY15 School-Level Quarterly Enrollment and Monthly Dosage Targets",
              "FY15 Site-Level Quarterly Enrollment and Monthly Dosage Targets")

# Set up list of tabs: Atlantic, Midwest, Northeast, South, West.
# Each tab has the following associated information, in the following format:
# c("Site Name", Tab Number, Start Row, End Row)
Atlantic <- list(c("Philadelphia", 2, 7, 24), c("Orlando", 4, 7, 13),
                 c("Jacksonville", 6, 7, 14), c("Miami", 8, 7, 24),
                 c("Washington, DC", 10, 7, 19))
Midwest <- list(c("Chicago", 2, 7, 27), c("Cleveland", 4, 7, 12),
                c("Columbus", 6, 7, 10), c("Detroit", 8, 7, 17),
                c("Milwaukee", 10, 7, 15))
Northeast <- list(c("Boston", 2, 7, 27), c("New Hampshire", 4, 7, 12),
                  c("Rhode Island", 6, 7, 11), c("New York", 8, 7, 30))
South <- list(c("Baton Rouge", 2, 6, 11), c("Columbia", 4, 6, 8),
              c("Little Rock", 6, 6, 11), c("New Orleans", 8, 6, 10),
              c("San Antonio", 10, 6, 14), c("Tulsa", 12, 6, 11))
West <- list(c("Denver", 2, 7, 14), c("Los Angeles", 4, 7, 31),
             c("Sacramento", 6, 7, 12), c("San Jose", 8, 7, 15),
             c("Seattle", 10, 7, 14))
Regions <- list(Atlantic, Midwest, Northeast, South, West)

# Move old goals files to archive folder.
for (i in 1:length(fileNames)) {
    if (i <= 6) {
        file.rename(from = paste(sourceFiles, "/", fileNames[i], " ", oldDate, ".xlsx", sep = ""),
                    to = paste(oldDataLocation, "/", fileNames[i], " ", oldDate, ".xlsx", sep = ""))
    } else {
        file.rename(from = paste(sourceFiles, "/", fileNames[i], " ", oldDate, ".csv", sep = ""),
                    to = paste(oldDataLocation, "/", fileNames[i], " ", oldDate, ".csv", sep = ""))
    }
}

# Append current date to current goals files.
for (i in 1:(length(Regions) + 1)) {
    file.rename(from = paste(sourceFiles, "/", fileNames[i], ".xlsx", sep = ""),
                to = paste(sourceFiles, "/", fileNames[i], " ",
                           as.character(Sys.Date()), ".xlsx", sep = ""))
}

################################################################################
# Check header alignment.
################################################################################

dataHeaderList <- list()
dataHeaderCheck <- data.frame()
x = 1
for (i in 1:length(Regions)) {
    for (j in 1:length(Regions[[i]])) {
        tempdata <- read.xlsx2(paste(fileNames[i], " ", as.character(Sys.Date()),
                                     ".xlsx", sep = ""),
                               sheetIndex = as.numeric(Regions[[i]][[j]][2]),
                               startRow = 1, endRow = 7, colIndex = 1:59, header = FALSE)
        dataHeaderList[[x]] <- tempdata
        dataHeaderCheck <- rbind(dataHeaderCheck, dataHeaderList[[x]])
        x = x + 1
    }
}

# Save file for examination.
write.csv(dataHeaderCheck, file=paste("Check Data Headers ",
                                      as.character(Sys.Date()), ".csv", sep = ""))

################################################################################
# Upload files into R.
################################################################################

dataList <- list()
FINALDATASET <- data.frame()
for (i in 1:length(Regions)) {
    for (j in 1:length(Regions[[i]])) {
        tempdata <- read.xlsx2(paste(fileNames[i], " ", as.character(Sys.Date()),
                                     ".xlsx", sep = ""),
                               sheetIndex = as.numeric(Regions[[i]][[j]][2]),
                               startRow = as.numeric(Regions[[i]][[j]][3]),
                               endRow = as.numeric(Regions[[i]][[j]][4]),
                               colIndex = 1:59, header = FALSE)
        colnames(tempdata) <- c("cyschSchoolRefID", "SchoolName", "SCM", "CM",
                                "SCMCMsW.FLs", "ELA.CMwFL", "ELA.Cycles", "ELA.MinFL",
                                "ELA.MaxFL", "ELA.FinalEnrollGoal", "MTH.CMwFL",
                                "MTH.Cycles", "MTH.MinFL", "MTH.MaxFL",
                                "MTH.FinalEnrollGoal", "ATT.CMwFL", "ATT.Cycles",
                                "ATT.MinFL", "ATT.MaxFL", "ATT.FinalEnrollGoal",
                                "BEH.CMwFL", "BEH.Cycles", "BEH.MinFL",
                                "BEH.MaxFL", "BEH.FinalEnrollGoal",
                                "Q1.ELA.EnrollGoalPerc", "Q1.MTH.EnrollGoalPerc",
                                "Q1.ATT.EnrollGoalPerc", "Q1.BEH.EnrollGoalPerc",
                                "Q2.ELA.EnrollGoalPerc", "Q2.MTH.EnrollGoalPerc",
                                "Q2.ATT.EnrollGoalPerc", "Q2.BEH.EnrollGoalPerc",
                                "Q3.ELA.EnrollGoalPerc", "Q3.MTH.EnrollGoalPerc",
                                "Q3.ATT.EnrollGoalPerc", "Q3.BEH.EnrollGoalPerc",
                                "AUG.ELA.DosageGoal", "SEP.ELA.DosageGoal",
                                "OCT.ELA.DosageGoal", "NOV.ELA.DosageGoal",
                                "DEC.ELA.DosageGoal", "JAN.ELA.DosageGoal",
                                "FEB.ELA.DosageGoal", "MAR.ELA.DosageGoal",
                                "APR.ELA.DosageGoal", "MAY.ELA.DosageGoal",
                                "JUN.ELA.DosageGoal", "AUG.MTH.DosageGoal",
                                "SEP.MTH.DosageGoal", "OCT.MTH.DosageGoal",
                                "NOV.MTH.DosageGoal", "DEC.MTH.DosageGoal",
                                "JAN.MTH.DosageGoal", "FEB.MTH.DosageGoal",
                                "MAR.MTH.DosageGoal", "APR.MTH.DosageGoal",
                                "MAY.MTH.DosageGoal", "JUN.MTH.DosageGoal")
        tempdata$SiteName <- Regions[[i]][[j]][1]
        dataList[[i]] <- tempdata
        FINALDATASET <- rbind(FINALDATASET, dataList[[i]])
    }
}

################################################################################
# Calculate actual quarterly enrollment targets.
# Note: 0.5 rounds to the nearest even number (minimizes bias).
################################################################################

FINALDATASET$Q1.ELA.EnrollGoal <- round(as.numeric(as.character(FINALDATASET$Q1.ELA.EnrollGoalPerc)) *
                                            as.numeric(as.character(FINALDATASET$ELA.FinalEnrollGoal)))
FINALDATASET$Q1.MTH.EnrollGoal <- round(as.numeric(as.character(FINALDATASET$Q1.MTH.EnrollGoalPerc)) *
                                            as.numeric(as.character(FINALDATASET$MTH.FinalEnrollGoal)))
FINALDATASET$Q1.ATT.EnrollGoal <- round(as.numeric(as.character(FINALDATASET$Q1.ATT.EnrollGoalPerc)) *
                                            as.numeric(as.character(FINALDATASET$ATT.FinalEnrollGoal)))
FINALDATASET$Q1.BEH.EnrollGoal <- round(as.numeric(as.character(FINALDATASET$Q1.BEH.EnrollGoalPerc)) *
                                            as.numeric(as.character(FINALDATASET$BEH.FinalEnrollGoal)))

FINALDATASET$Q2.ELA.EnrollGoal <- round(as.numeric(as.character(FINALDATASET$Q2.ELA.EnrollGoalPerc)) *
                                            as.numeric(as.character(FINALDATASET$ELA.FinalEnrollGoal)))
FINALDATASET$Q2.MTH.EnrollGoal <- round(as.numeric(as.character(FINALDATASET$Q2.MTH.EnrollGoalPerc)) *
                                            as.numeric(as.character(FINALDATASET$MTH.FinalEnrollGoal)))
FINALDATASET$Q2.ATT.EnrollGoal <- round(as.numeric(as.character(FINALDATASET$Q2.ATT.EnrollGoalPerc)) *
                                            as.numeric(as.character(FINALDATASET$ATT.FinalEnrollGoal)))
FINALDATASET$Q2.BEH.EnrollGoal <- round(as.numeric(as.character(FINALDATASET$Q2.BEH.EnrollGoalPerc)) *
                                            as.numeric(as.character(FINALDATASET$BEH.FinalEnrollGoal)))

FINALDATASET$Q3.ELA.EnrollGoal <- round(as.numeric(as.character(FINALDATASET$Q3.ELA.EnrollGoalPerc)) *
                                            as.numeric(as.character(FINALDATASET$ELA.FinalEnrollGoal)))
FINALDATASET$Q3.MTH.EnrollGoal <- round(as.numeric(as.character(FINALDATASET$Q3.MTH.EnrollGoalPerc)) *
                                            as.numeric(as.character(FINALDATASET$MTH.FinalEnrollGoal)))
FINALDATASET$Q3.ATT.EnrollGoal <- round(as.numeric(as.character(FINALDATASET$Q3.ATT.EnrollGoalPerc)) *
                                            as.numeric(as.character(FINALDATASET$ATT.FinalEnrollGoal)))
FINALDATASET$Q3.BEH.EnrollGoal <- round(as.numeric(as.character(FINALDATASET$Q3.BEH.EnrollGoalPerc)) *
                                            as.numeric(as.character(FINALDATASET$BEH.FinalEnrollGoal)))

################################################################################
# Convert dosage goals to minutes.
################################################################################

FINALDATASET$AUG.ELA.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$AUG.ELA.DosageGoal)) * 60
FINALDATASET$SEP.ELA.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$SEP.ELA.DosageGoal)) * 60
FINALDATASET$OCT.ELA.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$OCT.ELA.DosageGoal)) * 60
FINALDATASET$NOV.ELA.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$NOV.ELA.DosageGoal)) * 60
FINALDATASET$DEC.ELA.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$DEC.ELA.DosageGoal)) * 60
FINALDATASET$JAN.ELA.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$JAN.ELA.DosageGoal)) * 60
FINALDATASET$FEB.ELA.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$FEB.ELA.DosageGoal)) * 60
FINALDATASET$MAR.ELA.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$MAR.ELA.DosageGoal)) * 60
FINALDATASET$APR.ELA.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$APR.ELA.DosageGoal)) * 60
FINALDATASET$MAY.ELA.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$MAY.ELA.DosageGoal)) * 60
FINALDATASET$JUN.ELA.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$JUN.ELA.DosageGoal)) * 60

FINALDATASET$AUG.MTH.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$AUG.MTH.DosageGoal)) * 60
FINALDATASET$SEP.MTH.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$SEP.MTH.DosageGoal)) * 60
FINALDATASET$OCT.MTH.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$OCT.MTH.DosageGoal)) * 60
FINALDATASET$NOV.MTH.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$NOV.MTH.DosageGoal)) * 60
FINALDATASET$DEC.MTH.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$DEC.MTH.DosageGoal)) * 60
FINALDATASET$JAN.MTH.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$JAN.MTH.DosageGoal)) * 60
FINALDATASET$FEB.MTH.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$FEB.MTH.DosageGoal)) * 60
FINALDATASET$MAR.MTH.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$MAR.MTH.DosageGoal)) * 60
FINALDATASET$APR.MTH.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$APR.MTH.DosageGoal)) * 60
FINALDATASET$MAY.MTH.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$MAY.MTH.DosageGoal)) * 60
FINALDATASET$JUN.MTH.DosageGoal.Minutes <- as.numeric(as.character(FINALDATASET$JUN.MTH.DosageGoal)) * 60

################################################################################
# Save final school-level dataset.
################################################################################

write.csv(FINALDATASET, file=paste("FY15 School-Level Quarterly Enrollment and Monthly Dosage Targets ",
                                   as.character(Sys.Date()), ".csv", sep = ""))

################################################################################
# Create site-level goals dataset.
################################################################################

FINALSITEDATASET <- ddply(FINALDATASET, .(SiteName), summarise,
                          totSchools = length(SiteName),
                          ELA.FinalEnrollGoal = sum(as.numeric(as.character(ELA.FinalEnrollGoal)), na.rm = TRUE),
                          MTH.FinalEnrollGoal = sum(as.numeric(as.character(MTH.FinalEnrollGoal)), na.rm = TRUE),
                          ATT.FinalEnrollGoal = sum(as.numeric(as.character(ATT.FinalEnrollGoal)), na.rm = TRUE),
                          BEH.FinalEnrollGoal = sum(as.numeric(as.character(BEH.FinalEnrollGoal)), na.rm = TRUE),
                          Q1.ELA.EnrollGoal = sum(Q1.ELA.EnrollGoal, na.rm = TRUE),
                          Q1.MTH.EnrollGoal = sum(Q1.MTH.EnrollGoal, na.rm = TRUE),
                          Q1.ATT.EnrollGoal = sum(Q1.ATT.EnrollGoal, na.rm = TRUE),
                          Q1.BEH.EnrollGoal = sum(Q1.BEH.EnrollGoal, na.rm = TRUE),
                          Q2.ELA.EnrollGoal = sum(Q2.ELA.EnrollGoal, na.rm = TRUE),
                          Q2.MTH.EnrollGoal = sum(Q2.MTH.EnrollGoal, na.rm = TRUE),
                          Q2.ATT.EnrollGoal = sum(Q2.ATT.EnrollGoal, na.rm = TRUE),
                          Q2.BEH.EnrollGoal = sum(Q2.BEH.EnrollGoal, na.rm = TRUE),
                          Q3.ELA.EnrollGoal = sum(Q3.ELA.EnrollGoal, na.rm = TRUE),
                          Q3.MTH.EnrollGoal = sum(Q3.MTH.EnrollGoal, na.rm = TRUE),
                          Q3.ATT.EnrollGoal = sum(Q3.ATT.EnrollGoal, na.rm = TRUE),
                          Q3.BEH.EnrollGoal = sum(Q3.BEH.EnrollGoal, na.rm = TRUE))

################################################################################
# Save final site-level dataset.
################################################################################

write.csv(FINALSITEDATASET, file=paste("FY15 Site-Level Quarterly Enrollment and Monthly Dosage Targets ",
                                       as.character(Sys.Date()), ".csv", sep = ""))

################################################################################
# END OF FILE.
################################################################################