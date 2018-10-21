###### The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.
#One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
    
#######    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#Here are the data for the project:
    
#######    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#You should create one R script called run_analysis.R that does the following.

#  STEP 1 - Read and merge datasets: 
#Merges the training and the test sets to create one data set

## First set up the data and environment
if(!file.exists("./data")){dir.create("./data")}
fURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fURL,destfile="./data/Dataset.zip",method="curl")
unzip(zipfile="./data/Dataset.zip",exdir="./data")
fPath <- file.path("./data" , "UCI HAR Dataset")                             # change path_rf to fPath

## Now read in the data
dfActivityTest  <- read.table(file.path(fPath, "test" , "Y_test.txt" ),header = FALSE)
dfActivityTrain <- read.table(file.path(fPath, "train", "Y_train.txt"),header = FALSE)

dfSubjectTrain <- read.table(file.path(fPath, "train", "subject_train.txt"),header = FALSE)
dfSubjectTest  <- read.table(file.path(fPath, "test" , "subject_test.txt"),header = FALSE)

dfFeatureTest  <- read.table(file.path(fPath, "test" , "X_test.txt" ),header = FALSE)
dfFeatureTrain <- read.table(file.path(fPath, "train", "X_train.txt"),header = FALSE)

## Merge the datasets
dfSubjectMerged <- rbind(dfSubjectTrain, dfSubjectTest)
dfActivityMerged<- rbind(dfActivityTrain, dfActivityTest)
dfFeatureMerged<- rbind(dfFeatureTrain, dfFeatureTest)

## Set names
names(dfSubjectMerged)<-c("subject")
names(dfActivityMerged)<- c("activity")
featureNames <- read.table(file.path(fPath, "features.txt"),head=FALSE)
names(dfFeatureMerged)<- featureNames$V2

## Finally create a singe dataset from the three components
dfTemp <- cbind(dfSubjectMerged, dfActivityMerged)
dfAccelerometer <- cbind(dfFeatureMerged, dfTemp)

## tidy up
rm(dfActivityTest)
rm(dfActivityTrain)
rm(dfSubjectTrain)
rm(dfSubjectTest)
rm(dfFeatureTest)
rm(dfFeatureTrain)
rm(dfSubjectMerged)
rm(dfActivityMerged)
rm(dfFeatureMerged)
rm(dfTemp)

#  STEP 2 - Extract mean and SD measurements
#Extracts only the measurements on the mean and standard deviation for each measurement.

# first extract out the relevant column names
selectNames<-featureNames$V2[grep("mean\\(\\)|std\\(\\)", featureNames$V2)]
# add names for subject and activity
selectedNames<-c(as.character(selectNames), "subject", "activity" )
# create final dataset by subsetting the full accelerometer dataset
dfAccelero<-subset(dfAccelerometer,select=selectedNames)

#  STEP 3 - RENAME ACTIVITIES WITH DESCRIPTIVE NAMES
###### Uses descriptive activity names to name the activities in the data set

## read in the activity names
activityNames <- read.table(file.path(fPath, "activity_labels.txt"),header = FALSE)
dfAccelero<-merge(dfAccelero,activityNames, by.x = "activity", by.y = "V1")
dfAccelero$activity <- NULL
names(dfAccelero)[names(dfAccelero) == "V2"] <- "activity"

#  STEP 4 - RENAME VARIABLES WITH DESCRIPTIVE NAMES
## Appropriately labels the data set with descriptive variable names.

names(dfAccelero)<-gsub("Acc", ".Accelerometer", names(dfAccelero))
names(dfAccelero)<-gsub("BodyBody", ".Body", names(dfAccelero))
names(dfAccelero)<-gsub("^f", "Frequency.", names(dfAccelero))
names(dfAccelero)<-gsub("Gyro", ".Gyroscope", names(dfAccelero))
names(dfAccelero)<-gsub("Mag", ".Magnitude", names(dfAccelero))
names(dfAccelero)<-gsub("^t", "Time.", names(dfAccelero))

#  STEP 5 - AVERAGE VARIABLE
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

dfAccelero.summary<-aggregate(. ~subject + activity, dfAccelero, mean)
dfAccelero.summary<-dfAccelero.summary[order(dfAccelero.summary$subject,dfAccelero.summary$activity),]
write.table(dfAccelero.summary, file = "tidydata.txt",row.name=FALSE)

