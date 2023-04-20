###script name: run_analysis.R
###Coursera: Getting and Cleaning Data Course Project

#######################
####remove this before uploading
setwd("C:/Users/Jessica/Dropbox/PC/Desktop/Coursera/Data-Science-Foundations-using-R-Specialization/3_Getting_and_Cleaning_Data/Course-Project/Getting_and_Cleaning_Data_Course_Project/")

#######################

#download data
dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, destfile = "UCI_HAR_Dataset.zip")
unzip("UCI_HAR_Dataset.zip", exdir = "UCI_HAR_Dataset")

setwd("./UCI_HAR_Dataset")

###1. "Merge training and test sets to create one dataset"
#Combine Test+Training data sets
#read in train  (data and activity)
X_train<-read.table("./train/X_train.txt")
y_train<-read.table("./train/y_train.txt")

#read in test  (data and activity)
X_test<-read.table("./test/X_test.txt")
y_test<-read.table("./test/y_test.txt")

#merge training and test data rbind 'X_train' data and 'X_test' data (data)
Combined_data_train_test<-rbind(X_train, X_test)


#read in subjects and combine  (labeled 1-30; these are the people who performed the tests)
subject_train<-read.table("./train/subject_train.txt")
subject_test<-read.table("./test/subject_test.txt")
Combined_subjects<-rbind(subject_train, subject_test)

###2."Extract only the measurements on the mean and standard deviation for each measurement"
#Extract mean and std for each measurement
#read in features
features<-read.table("./features.txt")
class(features) #data.frame
#Choose only the columns with mean OR (|) std; 
#need to 'escape' the ( and ) regexp otherwise will get more columns than we need 
#(66 needed, get 79 columns if we don't escape parentheses)
mean_std_index<-grep("(mean|std)\\(\\)", features[, 2]) #integer vector with 66 elements
mean.std.data<-Combined_data_train_test[,mean_std_index] #choose only the indexed columns from original combined data frame

#add column names to the subsetted (mean, std) dataset
#this is also kind of part of step 4: "Appropriately label the data set with variable names"
colnames(mean.std.data)<-features[mean_std_index,2]
colnames(mean.std.data)<-gsub("\\(|\\)", "", colnames(mean.std.data)) #get rid of () in column name

###3. Use descriptive activity names to name the activities in the data set
#rbind 'y_train' and 'y_test' (activity)
Combined_activity<-rbind(y_train, y_test)
Activity_names<-read.table("./activity_labels.txt")
#Convert the activity number to the activity name in the large dataset
#essentially, the first column of 'Combined_activity' should be called
#whatever is the corresponding activity in the the second column in  'Activity_names'
Combined_activity[,1] <- Activity_names[Combined_activity[,1], 2]



###4."Appropriately label the data set with variable names"
#already partially did this in step 2, now we'll add the subject and activity columns with cbind
names(Combined_activity)<-"Activity"
names(Combined_subjects)<-"Subject"

#replace jargon or abbreviations with something a little easier to understand
colnames(mean.std.data)<-gsub("Acc", " Accelerometer", colnames(mean.std.data))
colnames(mean.std.data)<-gsub("Gyro", " Gyroscope", colnames(mean.std.data))
colnames(mean.std.data)<-gsub("Mag", " Magnitude", colnames(mean.std.data))
colnames(mean.std.data)<-gsub("^t", "Time ", colnames(mean.std.data))
colnames(mean.std.data)<-gsub("^f", "Frequency ", colnames(mean.std.data))
colnames(mean.std.data)<-gsub("GyroscopeJerk", "Gyroscope Jerk", colnames(mean.std.data))
colnames(mean.std.data)<-gsub("AccelerometerJerk", "Accelerometer Jerk ", colnames(mean.std.data))

#cbind Subject, Activity, and all Data
Finished.dataset<-cbind(Combined_subjects, Combined_activity, mean.std.data)
#write dataset
write.table(Finished.dataset, file= "merged_tidy_data.txt", row.names = FALSE)


###5. "From the tidy set in step 4, create a second, independent tidy data set 
#with the average of each variable for each activity and each subject"
library(dplyr)
summarized<-Finished.dataset %>% 
    group_by(Activity, Subject) %>% #first group by activity and subject
    summarize_all(funs(mean))%>%  #summarize all the columns within the groupings, use funs(mean) to get the mean function
    ungroup() #remove grouping

write.table(summarized, file= "Summarized_tidy_data.txt", row.name=FALSE) 

