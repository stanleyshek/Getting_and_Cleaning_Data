**
**

Getting and Cleaning Data
=========================

**
Course Project Code Book
========================

**
data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The attached R script (run_analysis.R) performs the following to clean up the data:

Merges the training train/X_train.txt and test sets test/X_test.txt to create one data set X.  
Merge train/subject_train.txt with test/subject_test.txt to create one date set S.  
Merge train/y_train.txt with test/y_test.txt to create one data set Y. 

Reads features.txt and extracts only the measurements on the mean and standard deviation for each measurement as "indices". The result is a 10299x66 data frame, only 66 out of 561 attributes are measurements on the mean and standard deviation. All measurements appear to be floating point numbers in the range (-1, 1).

Reads activity_labels.txt as "activity_names" and apply descriptive activity names to name the activities in the following data set:

walking
walkingupstairs
walkingdownstairs
sitting
standing
laying

The script also labels the data set with descriptive names.  Attributes and activity names are converted to lower case, underscores and brackets () are removed. Then it merges the 10299x66 data frame containing features with 10299x1 data frames containing activity labels and subject IDs. The result is saved as merged_clean_data.txt.  The first column contains subject IDs, the second column activity names, following 66 columns of measurements. Subject IDs are integers between 1 and 30 inclusive. The names of the attributes are similar to the following:

tbodyacc-mean-x 
tbodyacc-mean-y 
tbodyacc-mean-z 
tbodyacc-std-x 
tbodyacc-std-y 
tbodyacc-std-z 
tgravityacc-mean-x 
tgravityacc-mean-y

Finally, part 5 of the script creates a second, independent tidy data set with the average of each variable for each activity and each subject.  The result is saved as data_set_with_the_averages.txt.  The first column contains subject IDs, the second column contains activity names, and then the averages for each of the 66 attributes are in columns 3 to 68. There are 30 subjects and 6 activities, total 180 rows in this data set with averages.