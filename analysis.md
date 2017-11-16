This assignment is done by Janesh Devkota. 

The assignment was updated 2017-11-16 11:42:41 using R version 3.3.3 (2017-03-06).


Instructions for project as shown in coursera
------------------------

> The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  
> 
> One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
> 
> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
> 
> Here are the data for the project: 
> 
> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
> 
> You should create one R script called run_analysis.R that does the following. 
> 
> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement.
> 3. Uses descriptive activity names to name the activities in the data set.
> 4. Appropriately labels the data set with descriptive activity names.
> 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
> 
> Good luck!

### The codebook that is requested is towards the end of the document


#### Loading libraries 

```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(tidyr)
library(data.table)
```

```
## data.table 1.10.5 IN DEVELOPMENT built 2017-10-05 19:27:10 UTC; travis
```

```
## **********
## This development version of data.table was built more than 4 weeks ago. Please update.
## **********
```

```
##   The fastest way to learn (by data.table authors): https://www.datacamp.com/courses/data-analysis-the-data-table-way
```

```
##   Documentation: ?data.table, example(data.table) and browseVignettes("data.table")
```

```
##   Release notes, videos and slides: http://r-datatable.com
```

```
## 
## Attaching package: 'data.table'
```

```
## The following objects are masked from 'package:dplyr':
## 
##     between, first, last
```


Download the data 


```r
#dir.create(path = "data_project")

# download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
#               destfile = "data_project/dataset.zip")
```

The downloaded files were extracted and saved in the folder `data_project/dataset`

### Read files
Read test data 


```r
x_test <- read.table(file = "data_project/dataset/UCI HAR Dataset/test/X_test.txt", sep = "", header = F)
y_test <- read.table(file = "data_project/dataset/UCI HAR Dataset/test/y_test.txt", header = F, sep = "")
```

Now read training data

```r
x_train <- read.table(file = "data_project/dataset/UCI HAR Dataset/train/X_train.txt", header = F, sep = "")
y_train <- read.table(file = "data_project/dataset/UCI HAR Dataset/train/y_train.txt", header = F, sep = "")
```

Combine x_train, x_test 

```r
x_train_test <- rbind(x_train, x_test)
```

Read Subject train and test train ---------------

```r
subject_train <- read.table(file = "data_project/dataset/UCI HAR Dataset/train/subject_train.txt", header = F, sep = "")

subject_test <- read.table(file = "data_project/dataset/UCI HAR Dataset/test/subject_test.txt")
```

Combine train and test subject data 

```r
subject <- rbind(subject_train, subject_test)
names(subject) <- "subject"
```

Combine y train and y test as y_train_test

```r
y_train_test <- rbind(y_train, y_test)
names(y_train_test) <- "activityNum"
```

Combine x_train, x_test to x_train_test and combine subject, y_train_test & x_train_test

```r
x_train_test <- rbind(x_train, x_test)
train_test <- cbind(x_train_test, subject, y_train_test)
```


# Extract only mean and standard deviation
Read `features.txt` file

```r
features <- read.table(file = "data_project/dataset/UCI HAR Dataset/features.txt", header = F, sep = "")
names(features) <- c("featureNum", "featureName")
```

Subset only measurements for mean and standard deviation


```r
test <- grepl(pattern = "mean\\(\\)|std\\(\\)", features$featureName)
features <- features[test,]
```

Convert the column numbers to a vector of variable names matching columns 

```r
features <- features %>% 
  mutate(featureCode = paste0("V", featureNum))
```

 Select the featureCode from features and apply to train_test

```r
train_test <- train_test %>% select(features$featureCode, subject, activityNum)
```

Use descriptive activity names 

```r
activity_names <- read.table(file = "data_project/dataset/UCI HAR Dataset/activity_labels.txt", header = F, sep = "")
names(activity_names) <- c("activityNum", "activityName")
```

### Now merge activity labels with train_test1

```r
train_test <- train_test %>% dplyr::left_join(activity_names, by = "activityNum")
```

### Now change the data from short and wide format to tall and narrow format 

```r
reshape_train_test <- train_test1 %>% 
  tidyr::gather(key = "featureCode", value = "value", -subject, -activityNum, -activityName)
```

```
## Error in eval(expr, envir, enclos): object 'train_test1' not found
```

### merge activity name

```r
reshape_train_test <- reshape_train_test %>% 
  dplyr::left_join(features, by = "featureCode")
```

```
## Error in eval(expr, envir, enclos): object 'reshape_train_test' not found
```

#### Create a new variable, activity that is equivalent to activityName as a factor class.Create a new variable, feature that is equivalent to featureName as a factor class.

```r
reshape_train_test$activity <- factor(reshape_train_test$activityName)
```

```
## Error in factor(reshape_train_test$activityName): object 'reshape_train_test' not found
```

```r
reshape_train_test$feature <- factor(reshape_train_test$featureName)
```

```
## Error in factor(reshape_train_test$featureName): object 'reshape_train_test' not found
```

## Now let's separate features from featureName 


```r
jd_grep <- function (regex) {
  grepl(regex, reshape_train_test$feature)
}

reshape_train_test <- data.table(reshape_train_test)
```

```
## Error in data.table(reshape_train_test): object 'reshape_train_test' not found
```

```r
## Features with 2 categories
n <- 2
y <- matrix(seq(1, n), nrow=n)
x <- matrix(c(jd_grep("^t"), jd_grep("^f")), ncol=nrow(y))
```

```
## Error in grepl(regex, reshape_train_test$feature): object 'reshape_train_test' not found
```

```r
reshape_train_test$featDomain <- factor(x %*% y, labels=c("Time", "Freq"))
```

```
## Error in factor(x %*% y, labels = c("Time", "Freq")): object 'x' not found
```

```r
x <- matrix(c(jd_grep("Acc"), jd_grep("Gyro")), ncol=nrow(y))
```

```
## Error in grepl(regex, reshape_train_test$feature): object 'reshape_train_test' not found
```

```r
reshape_train_test$featInstrument <- factor(x %*% y, labels=c("Accelerometer", "Gyroscope"))
```

```
## Error in factor(x %*% y, labels = c("Accelerometer", "Gyroscope")): object 'x' not found
```

```r
x <- matrix(c(jd_grep("BodyAcc"), jd_grep("GravityAcc")), ncol=nrow(y))
```

```
## Error in grepl(regex, reshape_train_test$feature): object 'reshape_train_test' not found
```

```r
reshape_train_test$featAcceleration <- factor(x %*% y, labels=c(NA, "Body", "Gravity"))
```

```
## Error in factor(x %*% y, labels = c(NA, "Body", "Gravity")): object 'x' not found
```

```r
x <- matrix(c(jd_grep("mean()"), jd_grep("std()")), ncol=nrow(y))
```

```
## Error in grepl(regex, reshape_train_test$feature): object 'reshape_train_test' not found
```

```r
reshape_train_test$featVariable <- factor(x %*% y, labels=c("Mean", "SD"))
```

```
## Error in factor(x %*% y, labels = c("Mean", "SD")): object 'x' not found
```

```r
## Features with 1 category
reshape_train_test$featJerk <- factor(jd_grep("Jerk"), labels=c(NA, "Jerk"))
```

```
## Error in grepl(regex, reshape_train_test$feature): object 'reshape_train_test' not found
```

```r
reshape_train_test$featMagnitude <- factor(jd_grep("Mag"), labels=c(NA, "Magnitude"))
```

```
## Error in grepl(regex, reshape_train_test$feature): object 'reshape_train_test' not found
```

```r
## Features with 3 categories
n <- 3
y <- matrix(seq(1, n), nrow=n)
x <- matrix(c(jd_grep("-X"), jd_grep("-Y"), jd_grep("-Z")), ncol=nrow(y))
```

```
## Error in grepl(regex, reshape_train_test$feature): object 'reshape_train_test' not found
```

```r
reshape_train_test$featAxis <- factor(x %*% y, labels=c(NA, "X", "Y", "Z"))
```

```
## Error in factor(x %*% y, labels = c(NA, "X", "Y", "Z")): object 'x' not found
```

```r
head(reshape_train_test)
```

```
## Error in head(reshape_train_test): object 'reshape_train_test' not found
```

```r
names(reshape_train_test)
```

```
## Error in eval(expr, envir, enclos): object 'reshape_train_test' not found
```

```r
dim(reshape_train_test)
```

```
## Error in eval(expr, envir, enclos): object 'reshape_train_test' not found
```

## Create a tidy data set 

```r
library(data.table)
reshape_train_test <- data.table(reshape_train_test)
```

```
## Error in data.table(reshape_train_test): object 'reshape_train_test' not found
```

```r
setkey(reshape_train_test, subject, activity, featDomain, featAcceleration, featInstrument, featJerk, featMagnitude, featVariable, featAxis)
```

```
## Error in setkey(reshape_train_test, subject, activity, featDomain, featAcceleration, : object 'reshape_train_test' not found
```

```r
tidy_data <- reshape_train_test[, list(count = .N, average = mean(value)), by=key(reshape_train_test)]
```

```
## Error in eval(expr, envir, enclos): object 'reshape_train_test' not found
```

```r
head(tidy_data)
```

```
## Error in head(tidy_data): object 'tidy_data' not found
```

```r
dim(tidy_data)
```

```
## Error in eval(expr, envir, enclos): object 'tidy_data' not found
```

## Now let's make a codebook

```r
knit("codebook.Rmd", output="codebook.md", encoding="ISO8859-1", quiet=TRUE)
```

```
## [1] "codebook.md"
```

### convert to html

```r
markdown::markdownToHTML("codebook.md", "codebook.html")
```
