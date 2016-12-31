##  Download the file in current working directory    
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
options('download.file.method'='curl')
download.file(fileUrl,destfile="./Dataset.zip",method="auto")

##  Unzip the file and extract it in the current working directory
unzip(zipfile="./Dataset.zip",exdir="./")
path_rf <- file.path("./" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
#files

## Read data from the files into the variables
## Read the Activity files
dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)

## Read the Subject files
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)

## Read Fearures files
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

##  1. Merges the training and the test sets to create one data set.
##  Append the rows of train and test datasets
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

##  Set names to variables
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

## Merge columns to generate a combined file
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

##  2. Extracts only the measurements on the mean and standard deviation for each measurement.
##     Extract  Names of Features with “mean()” or “std()”
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
##   Subset the data frame Data by seleted names of Features
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)
#str(Data)


##  Uses descriptive activity names to name the activities in the data set
##  Read descriptive activity names from “activity_labels.txt”
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

## facorize Variale activity in the data frame Data using descriptive activity names
#head(Data$activity,30)


##  4. Appropriately labels the data set with descriptive variable names.
##  In the former part, variables activity and subject and names of the activities have been labelled using descriptive names.
##  In this part, Names of Feteatures will labelled using descriptive variable names.
##  prefix t is replaced by time
##  Acc is replaced by Accelerometer
##  Gyro is replaced by Gyroscope
##  prefix f is replaced by frequency
##  Mag is replaced by Magnitude
##  BodyBody is replaced by Body

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

##  Creates a second,independent tidy data set and ouput it
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)
