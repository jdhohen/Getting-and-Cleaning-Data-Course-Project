# Getting and Cleaning Data Course Project CodeBook.md 

CodeBook.md describes data, variables, and any transformations or work that was performed to generate tidy data using **run_analysis.R**.

## **Source data:**

The data set and full data set description from the original study can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "Human Activity Recognition Using Smarthphones Data Set (UCI Machine Learning Repository)").

Data alone can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "Clicking will download data").

**Short descriptor of experimental design (taken from data description at UCI dataset website above):** "The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data."

**Modified from the features_info.txt file in original data set:** "The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern: 

'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ, tGravityAcc-XYZ, tBodyAccJerk-XYZ, tBodyGyro-XYZ, tBodyGyroJerk-XYZ, tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag, fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccMag, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag"

The set of variables that were estimated from these signals included in **merged_tidy_data.txt** are:

-mean: Mean value

-std: Standard deviation

## About run_analysis.R

After downloading the data set:

1.  Merge training and test sets to create one data set (input for all variables used read.table() function)
    -   X_train\<- train/X_train.txt: training data set
    -   y_train\<-/train/y_train.txt: training set activity code labels
    -   X_test\<-test/X_test.txt: test data set
    -   y_test\<-test/y_test.txt: test set activity code labels
    -   Combined_data_train_test \<- combines X_train and X_test using rbind() function
    -   subject_train\<-train/subject_train.txt: subject IDs in the training data set (70% of subjects)
    -   subject_test\<-test/subject_test.txt: subject IDs in the test data set (30% of subjects)
    -   Combined_subjects\<-combines subject_train and subject_test using rbind() function
2.  Extract only the measurements on the mean and standard deviation for each measurement
    -   features\<-features.txt: data frame of pre-processed features measured in the study
    -   mean_std_index\<- creates an row index of object 'features' that includes 'mean' or 'std' using grep() function
    -   mean.std.data\<-subset of 'Combined_data_train_test' based on the mean_std_index
    -   modified column names to the subsetted dataset 'mean.st.data' from 'features' using colnames() and gsub() functions
3.  Use descriptive activity names to name the activities in the data set
    -   Combined_activity\<-combines y_train and y_test using rbind() function
    -   Activity_names\<-activity_labels.txt: links the class labels with their activity name
    -   Convert the activity number to the activity name in the large data set
4.  Appropriately label the data set with variable names
    -   Name Subject and Activity column with names() function
    -   Modified other column names to something more understandable using colnames() and gsub() functions:
        -   'Acc' replaced by 'Accelerometer'
        -   'Gyro' replaced by 'Gyroscope'
        -   'Mag' replaced by 'Magnitude'
        -   't' (line start character) replaced with 'Time'
        -   'f' (line start character) replaced with 'Frequency'
        -   various spacing of column names fixed
    -   Finished.dataset created by combining 'Subject' 'Activity' and the rest of the data set using cbind() function
    -   Table written to "merged_tidy_data.txt" using write.table() function
5.  From the data set in step 4, create a second independent tidy data set with the average of each variable for each activity and each subject.
    -   load dplyr library
    -   summarized\<-summary dataset takes the means of each variable for each activity and subject using group_by(), summarize_all(), and mean() functions. Ungroup() function to remove grouping to see correct table
    -   Table written to "Summarized_tidy_data.txt" using write.table() function
