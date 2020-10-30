library(tidyverse)

# Load and rename variables
definitions <- read.table("UCI HAR Dataset/features.txt")
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
test_label <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_sub <- read.table("UCI HAR Dataset/test/subject_test.txt")

colnames(test_sub) <- "subject"
colnames(test_label) <- "activity"
colnames(test_data) <- definitions$V2

test <- cbind(test_sub, test_label, test_data)

train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
train_label <- read.table("UCI HAR Dataset/train/Y_train.txt")
train_sub <- read.table("UCI HAR Dataset/train/subject_train.txt")

colnames(train_sub) <- "subject"
colnames(train_label) <- "activity"
colnames(train_data) <- definitions$V2

train <- cbind(train_sub, train_label, train_data)

# Merge test and train data
merged <- rbind(test, train)

# Rename activity
merged$activity <- activities[merged$activity, 2]

# Get mean and std cols only
merged_mean_std <- merged[,grepl("mean|std|subject|activity", names(merged))]

# rename variables
names(merged_mean_std)[2] = "activity"
names(merged_mean_std)<-gsub("Acc", "Accelerometer", names(merged_mean_std))
names(merged_mean_std)<-gsub("Gyro", "Gyroscope", names(merged_mean_std))
names(merged_mean_std)<-gsub("BodyBody", "Body", names(merged_mean_std))
names(merged_mean_std)<-gsub("Mag", "Magnitude", names(merged_mean_std))
names(merged_mean_std)<-gsub("^t", "Time", names(merged_mean_std))
names(merged_mean_std)<-gsub("^f", "Frequency", names(merged_mean_std))
names(merged_mean_std)<-gsub("tBody", "TimeBody", names(merged_mean_std))
names(merged_mean_std)<-gsub("mean[(][)]", "Mean", names(merged_mean_std), ignore.case = TRUE)
names(merged_mean_std)<-gsub("std[(][)]", "STD", names(merged_mean_std), ignore.case = TRUE)
names(merged_mean_std)<-gsub("freq[(][)]", "Frequency", names(merged_mean_std), ignore.case = TRUE)
names(merged_mean_std)<-gsub("angle", "Angle", names(merged_mean_std))
names(merged_mean_std)<-gsub("gravity", "Gravity", names(merged_mean_std))

# From data create a separate data set with average

avg_data <- merged_mean_std %>%
    group_by(subject, activity) %>%
    summarise_all(mean)

write.table(avg_data, "final_data.txt", row.name=FALSE)
