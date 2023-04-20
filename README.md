# Getting and Cleaning Data Course Project README.md 

Contains R code, CodeBook.md, and the two sets of tidy data (merged_tidy_data.txt, and Summarized_tidy_data.txt)

## Files in this repo:

**README.md**

**run.analysis.R** contains code to download and clean data to generate tidy data. Code performs these activities:

1.  Merge training and test sets to create one data set
2.  Extract only the measurements on the mean and standard deviation for each measurement
3.  Use descriptive activity names to name the activities in the data set
4.  Appropriately label the data set with variable names
5.  From the data set in step 4, create a second independent tidy data set with the average of each variable for each activity and each subject.

**merged_tidy_data.txt** contains data that results from steps 1-4 above.

**Summarized_tidy_data.txt** contains data that resulted from step 5 above (average of each variable for each activity and each subject).

**CodeBook.md** contains descriptions of data, variables, and any transformations or work that was performed to clean up the data.

## Citation

Use of this dataset in publications must be acknowledged by referencing the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

Human Activity Recognition Using Smartphones Dataset

Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.

Smartlab - Non Linear Complex Systems Laboratory

DITEN - Università degli Studi di Genova.

Via Opera Pia 11A, I-16145, Genoa, Italy.

activityrecognition\@smartlab.ws

www.smartlab.ws
