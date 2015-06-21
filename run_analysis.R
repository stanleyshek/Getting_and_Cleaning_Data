# Data for this project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# 1. Merges the training and the test sets to create one data set.
part1 <- read.table("train/X_train.txt")
part2 <- read.table("test/X_test.txt")
X <- rbind(part1, part2)

part1 <- read.table("train/subject_train.txt")
part2 <- read.table("test/subject_test.txt")
S <- rbind(part1, part2)

part1 <- read.table("train/y_train.txt")
part2 <- read.table("test/y_test.txt")
Y <- rbind(part1, part2)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("features.txt")
indices <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, indices]
names(X) <- features[indices, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. Uses descriptive activity names to name the activities in the data set
activity_names <- read.table("activity_labels.txt")
activity_names[, 2] = gsub("_", "", tolower(as.character(activity_names[, 2])))
Y[,1] = activity_names[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive variable names. 
names(S) <- "subject"
cleaned <- cbind(S, Y, X)
write.table(cleaned, "merged_clean_data.txt")

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
uniqueSubjects = unique(S)[,1]
numSubjects = length(unique(S)[,1])
numActivities = length(activities[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
        for (a in 1:numActivities) {
                result[row, 1] = uniqueSubjects[s]
                result[row, 2] = activities[a, 2]
                tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
                result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
                row = row+1
        }
}
write.table(result, "data_set_with_the_averages.txt")