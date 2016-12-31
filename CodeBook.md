You have to download source data from link below and unzip it to working directory of R Studio and unzip in the file in working directory.
You have to perform R script.
About source data

The source data used for the project is Human Activity Recognition Using Smartphones Data Set. A full description is available at the following website where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

About the R script
File with R code "run_analysis.R" perform 5 following steps (in accordance assigned task of course work):
Step 1. Read and Merge the training and the test sets to create one data set.
1.1 Reading files
1.1.1 Reading Activity files
1.1.2 Reading Subject files
1.1.3 Reading Features files
1.2 Merging the training and the test sets to create one data set.
1.2.1 Append the rows of train and test datasets
1.2.2 Set names to variables
1.2.3 Merge columns to generate a combined file


2. Extracting only the measurements on the mean and standard deviation for each measurement
2.1 Extract  Names of Features with “mean()” or “std()”
2.2 Subset the data frame Data by seleted names of Features

3. Using descriptive activity names to name the activities in the data set
3.1 Read descriptive activity names from “activity_labels.txt”


4. Appropriately labeling the data set with descriptive variable names
4.1.Labelling of Names of Feteatures using descriptive variable names.

5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject.
5.1 Making second tidy data set
5.2 Writing second tidy data set in txt file
