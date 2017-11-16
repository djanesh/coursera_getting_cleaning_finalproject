Codebook
========
Codebook was generated on 2017-11-16 11:43:03 during the same process that generated the dataset. See `run_analysis.md` or `run_analysis.html` for details on dataset creation.

Variable list and descriptions
------------------------------

Variable name    | Description
-----------------|------------
subject          | ID the subject who performed the activity for each window sample. Its range is from 1 to 30.
activity         | Activity name
featDomain       | Feature: Time domain signal or frequency domain signal (Time or Freq)
featInstrument   | Feature: Measuring instrument (Accelerometer or Gyroscope)
featAcceleration | Feature: Acceleration signal (Body or Gravity)
featVariable     | Feature: Variable (Mean or SD)
featJerk         | Feature: Jerk signal
featMagnitude    | Feature: Magnitude of the signals calculated using the Euclidean norm
featAxis         | Feature: 3-axial signals in the X, Y and Z directions (X, Y, or Z)
featCount        | Feature: Count of data points used to compute `average`
featAverage      | Feature: Average of each variable for each activity and each subject

Dataset structure
-----------------


```r
str(tidy_data)
```

```
## Error in str(tidy_data): object 'tidy_data' not found
```

List the key variables in the data table
----------------------------------------


```r
key(tidy_data)
```

```
## Error in key(tidy_data): object 'tidy_data' not found
```

Show a few rows of the dataset
------------------------------


```r
tidy_data
```

```
## Error in eval(expr, envir, enclos): object 'tidy_data' not found
```

Summary of variables
--------------------


```r
summary(tidy_data)
```

```
## Error in summary(tidy_data): object 'tidy_data' not found
```

List all possible combinations of features
------------------------------------------


```r
tidy_data[, .N, by=c(names(tidy_data)[grep("^feat", names(tidy_data))])]
```

```
## Error in eval(expr, envir, enclos): object 'tidy_data' not found
```

Save to file
------------

Save data table objects to a tab-delimited text file called `DatasetHumanActivityRecognitionUsingSmartphones.txt`.


```r
f <- file.path(path, "DatasetHumanActivityRecognitionUsingSmartphones.txt")
```

```
## Error in file.path(path, "DatasetHumanActivityRecognitionUsingSmartphones.txt"): object 'path' not found
```

```r
write.table(tidy_data, f, quote=FALSE, sep="\t", row.names=FALSE)
```

```
## Error in is.data.frame(x): object 'tidy_data' not found
```
