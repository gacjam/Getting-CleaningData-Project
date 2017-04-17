
# The data for the project can be downloaded from:

#     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# This single R script called run_analysis.R, does the following:

########################################################################################
########################################################################################
##      1. Merges the training and the test sets to create one data set.
##      2. Extracts only the measurements on the mean and standard deviation for each measurement.
##      3. Uses descriptive activity names to name the activities in the data set
##      4. Appropriately labels the data set with descriptive variable names.
##      5. From the data set in step 4, creates a second, independent tidy data set 
##         with the average of each variable for each activity and each subject.
########################################################################################
########################################################################################


#######################################################################
# 1. Merges the training and the test sets to create one data set.
#######################################################################

x_train <- read.table("train/X_train.txt")

x_test <- read.table("test/X_test.txt")

x_data <- rbind(x_train, x_test)

subject_train <- read.table("train/subject_train.txt")

subject_test <- read.table("test/subject_test.txt")

subject_data <- rbind(subject_train, subject_test)

y_train <- read.table("train/y_train.txt")

y_test <- read.table("test/y_test.txt")

y_data <- rbind(y_train, y_test)

#######################################################################
# 2. Extracts only the measurements on the mean and standard deviation 
#    for each measurement.
#######################################################################

features <- read.table("features.txt")

data_mean_std_id <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])

x_data <- x_data[, data_mean_std_id]

names(x_data) <- features[data_mean_std_id, 2]

names(x_data) <- gsub("\\(|\\)", "", names(x_data))

names(x_data) <- tolower(names(x_data))

#######################################################################
# 3. Uses descriptive activity names to name the activities in the data set.
#######################################################################

activities <- read.table("activity_labels.txt")

activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))

y_data[,1] = activities[y_data[,1], 2]

names(y_data) <- "Activity"

#######################################################################
# 4. Appropriately labels the data set with descriptive activity names.
#######################################################################

names(subject_data) <- "Subject"

merge_data_mean_std <- cbind(subject_data, y_data, x_data)

write.table(merge_data_mean_std, file = "merged_tidy_data.txt")

#######################################################################
# 5. From the data set in step 4, Creates a 2nd, independent tidy data set 
#    with the average of each variable for each activity and each subject.
#######################################################################

merge_data_avg_act_sub <- ddply(merge_data_mean_std, c("Subject","Activity"), numcolwise(mean))

write.table(merge_data_avg_act_sub, file = "merge_data_avg_act_sub.txt")
