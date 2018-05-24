How to use
===========

The run_analysis.R can be run to generate the tidy data "dataset.txt"", as long as the Samsung data (the folder "UCI HAR Dataset") is in the working directory. The Samsung data can be downloaded from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

Specifically, the run_analysis.R does the following things

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creat new independent tidy data set with the average of each variable for each activity and each subject.
6. Save the dataset into .txt