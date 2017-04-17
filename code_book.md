#Course Project Code Book
Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The attached R script (run_analysis.R) performs 5 steps to clean the data. 

Introduction

The script run_analysis.R performs the 5 steps described in the course project's definition.
•	All the similar data is merged using the rbind() function. Similar files have the same number of columns and referring to the same entities.
•	Columns with the mean and standard deviation measures are taken from the full dataset. After extracting these columns, they are given the correct names, taken from features.txt.
•	As activity data is addressed with values 1:6, we take the activity names and IDs from activity_labels.txt and they are substituted in the dataset.
•	On the whole dataset, those columns with vague column names are corrected.
•	Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called merge_data_avg_act_sub.txt, and uploaded to this repository.

Variables
•	x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
•	x_data, y_data and subject_data merge the previous datasets to further analysis.
•	features contains the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std_features, a numeric vector used to extract the desired data.
•	A similar approach is taken with activity names through the activities variable.
•	all_data merges x_data, y_data and subject_data in a big dataset.
•	Finally, averages_data contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans() and ease the development.
