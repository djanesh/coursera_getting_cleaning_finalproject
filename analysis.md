This assignment is done by Janesh Devkota. 

The assignment was updated 2017-11-16 12:17:12 using R version 3.3.3 (2017-03-06).


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
library(tidyr)
library(data.table)
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
head(x_test)
```

```
##          V1          V2          V3         V4         V5         V6
## 1 0.2571778 -0.02328523 -0.01465376 -0.9384040 -0.9200908 -0.6676833
##           V7         V8         V9        V10        V11        V12
## 1 -0.9525011 -0.9252487 -0.6743022 -0.8940875 -0.5545772 -0.4662230
##         V13       V14       V15        V16        V17        V18
## 1 0.7172085 0.6355024 0.7894967 -0.8777642 -0.9977661 -0.9984138
##          V19        V20        V21        V22        V23        V24
## 1 -0.9343453 -0.9756690 -0.9498237 -0.8304778 -0.1680842 -0.3789955
##          V25       V26         V27         V28         V29           V30
## 1  0.2462170 0.5212036 -0.48779311  0.48228047 -0.04546211  0.2119550500
##           V31        V32         V33         V34         V35         V36
## 1 -0.13489443 0.13085848 -0.01417631 -0.10597085  0.07354401 -0.17151642
##           V37         V38        V39        V40       V41        V42
## 1  0.04006298  0.07698893 -0.4905457 -0.7090026 0.9364893 -0.2827192
##         V43        V44        V45        V46        V47        V48
## 1 0.1152882 -0.9254273 -0.9370141 -0.5642884 -0.9300199 -0.9378220
##          V49       V50        V51       V52       V53        V54
## 1 -0.6055877 0.9060826 -0.2792441 0.1528952 0.9444614 -0.2621596
##           V55         V56       V57        V58        V59        V60
## 1 -0.07616168 -0.01782692 0.8292968 -0.8646206 -0.9677953 -0.9497267
##          V61        V62        V63 V64        V65        V66       V67
## 1 -0.9461192 -0.7597181 -0.4249753  -1  0.2192273 -0.4302536 0.4310483
##          V68       V69        V70       V71        V72       V73
## 1 -0.4318389 0.4327738 -0.7954677 0.7813139 -0.7803915 0.7852716
##          V74       V75        V76       V77       V78        V79
## 1 -0.9844102 0.9871799 -0.9894148 0.9876861 0.9805803 -0.9963518
##          V80        V81          V82          V83        V84        V85
## 1 -0.9601171 0.07204601  0.045754401 -0.106042660 -0.9066828 -0.9380164
##          V86        V87        V88        V89        V90        V91
## 1 -0.9359358 -0.9160809 -0.9367255 -0.9490538 -0.9032242 -0.9498183
##          V92       V93       V94       V95        V96        V97
## 1 -0.8914035 0.8984794 0.9501816 0.9461528 -0.9306729 -0.9950459
##          V98        V99       V100       V101       V102        V103
## 1 -0.9974955 -0.9970156 -0.9364160 -0.9468741 -0.9687746 -0.08517415
##         V104       V105       V106       V107        V108       V109
## 1 -0.3102630 -0.5102876 0.52148173 -0.2258897  0.49172843 0.31275555
##           V110        V111       V112      V113        V114        V115
## 1  0.229796800  0.11395925 0.21987861 0.4229745 -0.08263318  0.14042653
##          V116       V117        V118        V119       V120         V121
## 1 -0.19623228 0.07235794 -0.26486023  0.03585215 -0.3497352  0.119976160
##          V122       V123       V124       V125       V126       V127
## 1 -0.09179234 0.18962854 -0.8830891 -0.8161636 -0.9408812 -0.8886123
##         V128       V129       V130       V131       V132      V133
## 1 -0.8578010 -0.9458183 -0.6634106 -0.7134366 -0.6486786 0.8371004
##        V134      V135       V136       V137       V138       V139
## 1 0.8252568 0.8109771 -0.7964999 -0.9796164 -0.9829001 -0.9940368
##         V140       V141       V142        V143        V144        V145
## 1 -0.8865579 -0.9061043 -0.9580488  0.77403279 -0.26770588  0.45224806
##          V146        V147       V148        V149        V150        V151
## 1 -0.07845127 -0.01257862  0.2359816 -0.19904751  0.03391784 -0.08078053
##           V152        V153        V154        V155      V156        V157
## 1  0.006998715  0.24488551  0.21651661 -0.27968077 0.2497388  0.01771975
##           V158        V159       V160        V161        V162        V163
## 1  0.648464540 -0.23693109 -0.3017347 -0.20489621 -0.17448771 -0.09338934
##         V164       V165       V166       V167       V168       V169
## 1 -0.9012242 -0.9108601 -0.9392504 -0.9103627 -0.9273567 -0.9535541
##         V170       V171       V172      V173      V174      V175
## 1 -0.8679143 -0.9134978 -0.8975779 0.9049367 0.9173084 0.9476122
##         V176       V177       V178       V179       V180       V181
## 1 -0.9296091 -0.9946862 -0.9957906 -0.9978126 -0.9365408 -0.9588796
##         V182        V183        V184       V185        V186        V187
## 1 -0.9703483  0.03661912  0.07645993 -0.1971260  0.10651426 -0.02081190
##          V188        V189        V190        V191        V192      V193
## 1  0.19325784  0.30447875  0.11572923  0.05414960  0.06895124 0.1970496
##         V194        V195         V196      V197        V198        V199
## 1  0.3099283 -0.21265711  0.173178140 0.1458445  0.12400875 -0.15534634
##         V200       V201       V202       V203       V204       V205
## 1 -0.3234373 -0.8669294 -0.7051911 -0.7440217 -0.7607956 -0.9816487
##         V206       V207       V208       V209        V210        V211
## 1 -0.8669294 -0.9801658 -0.8594742  0.2551044  0.05377970 -0.20414449
##           V212         V213       V214       V215       V216       V217
## 1  0.610527550 -0.564449320 -0.8669294 -0.7051911 -0.7440217 -0.7607956
##         V218       V219       V220       V221       V222        V223
## 1 -0.9816487 -0.8669294 -0.9801658 -0.8594742  0.2551044  0.05377970
##          V224         V225         V226       V227       V228       V229
## 1 -0.20414449  0.610527550 -0.564449320 -0.9297665 -0.8959942 -0.9004173
##         V230       V231       V232       V233       V234       V235
## 1 -0.9030044 -0.9750111 -0.9297665 -0.9956077 -0.9141207 -0.1295523
##         V236        V237        V238        V239       V240       V241
## 1  0.2389109 -0.34559715  0.32646236 -0.26304800 -0.7955439 -0.7620732
##         V242       V243       V244       V245       V246       V247
## 1 -0.7826723 -0.7165936 -0.7641926 -0.7955439 -0.9741521 -0.8395810
##         V248        V249        V250        V251         V252       V253
## 1 0.66756269  0.03562114 -0.16189398  0.15325006 -0.006759604 -0.9251949
##         V254       V255       V256       V257       V258       V259
## 1 -0.8943436 -0.9001467 -0.9167371 -0.9763667 -0.9251949 -0.9958242
##         V260       V261         V262        V263        V264        V265
## 1 -0.9118375  0.3316543  0.516953160 -0.51350400  0.04131981  0.01183501
##         V266       V267       V268       V269       V270       V271
## 1 -0.9185097 -0.9182132 -0.7890915 -0.9482903 -0.9251369 -0.6363167
##         V272       V273       V274       V275       V276       V277
## 1 -0.9306803 -0.9244385 -0.7249026 -0.9684241 -0.9401367 -0.5971887
##         V278       V279       V280       V281       V282       V283
## 1 -0.9661371 -0.9844505 -0.9520871 -0.8650632 -0.9978437 -0.9960362
##         V284       V285       V286       V287       V288       V289
## 1 -0.9401950 -0.9048404 -0.9338125 -0.8693829 -0.3396733 -0.4858032
##         V290        V291       V292       V293        V294         V295
## 1 -0.1662577 -1.00000000 -1.0000000 -1.0000000  0.01111695  0.121250690
##          V296       V297       V298       V299       V300       V301
## 1 -0.52294869 -0.5719995 -0.8946124 -0.3382659 -0.6867975  0.1895525
##         V302       V303       V304       V305       V306       V307
## 1 -0.1135957 -0.9985063 -0.9979426 -0.9955979 -0.9950356 -0.9959769
##         V308       V309       V310       V311       V312       V313
## 1 -0.9914874 -0.9921312 -0.9997751 -0.9982039 -0.9947467 -0.9943090
##         V314       V315       V316       V317       V318       V319
## 1 -0.9946932 -0.9980205 -0.9937275 -0.9962089 -0.9979761 -0.9989209
##         V320       V321       V322       V323       V324       V325
## 1 -0.9964011 -0.9975599 -0.9950680 -0.9973513 -0.9982380 -0.9960705
##         V326       V327       V328       V329       V330       V331
## 1 -0.9979246 -0.9963566 -0.9976398 -0.9962200 -0.9962254 -0.9247055
##         V332       V333       V334       V335       V336       V337
## 1 -0.9940973 -0.9953235 -0.9989694 -0.9979016 -0.9949296 -0.9892607
##         V338       V339       V340       V341       V342       V343
## 1 -0.9800854 -0.9379367 -0.9966776 -0.9970254 -0.9864274 -0.9392008
##         V344       V345       V346       V347       V348       V349
## 1 -0.9984318 -0.8996332 -0.9374850 -0.9235514 -0.9244291 -0.9432104
##         V350       V351       V352       V353       V354       V355
## 1 -0.9478915 -0.8966146 -0.9383091 -0.9425757 -0.9486343 -0.9583254
##         V356       V357       V358       V359       V360       V361
## 1 -0.9588169 -0.9438824 -0.9873033 -0.9784656 -0.9052742 -0.9950361
##         V362       V363       V364       V365       V366       V367
## 1 -0.9974993 -0.9970307 -0.8870774 -0.9358196 -0.9536533 -0.4706616
##         V368       V369  V370  V371  V372       V373        V374
## 1 -0.6721718 -0.5962740 -0.52  0.08  0.32 0.45100539  0.13716703
##          V375       V376       V377       V378       V379       V380
## 1 -0.18029913 -0.5800861 -0.9080700 -0.6255269 -0.9427572 -0.6619101
##         V381       V382       V383       V384       V385       V386
## 1 -0.9115321 -0.9990115 -0.9976301 -0.9959848 -0.9947085 -0.9955716
##         V387       V388       V389       V390       V391       V392
## 1 -0.9878765 -0.9864452 -0.9982052 -0.9980404 -0.9944968 -0.9920496
##         V393       V394       V395       V396       V397       V398
## 1 -0.9863330 -0.9968935 -0.9907627 -0.9994092 -0.9986481 -0.9987487
##         V399       V400       V401       V402       V403       V404
## 1 -0.9964063 -0.9971722 -0.9945302 -0.9979198 -0.9999697 -0.9986417
##         V405       V406       V407       V408       V409       V410
## 1 -0.9974017 -0.9954108 -0.9981824 -0.9984631 -0.9959958 -0.9936388
##         V411       V412       V413       V414       V415       V416
## 1 -0.9978378 -0.9971293 -0.9987495 -0.9967088 -0.9951097 -0.9984858
##         V417       V418       V419       V420       V421       V422
## 1 -0.9990935 -0.9959246 -0.9979509 -0.9960129 -0.9984601 -0.9962671
##         V423       V424       V425       V426       V427       V428
## 1 -0.9977005 -0.8235579 -0.8079160 -0.9179126 -0.9032627 -0.8226770
##         V429       V430       V431       V432       V433       V434
## 1 -0.9561651 -0.8651270 -0.8318008 -0.9410562 -0.9047980 -0.8792566
##         V435       V436       V437       V438       V439       V440
## 1 -0.9677885 -0.8785993 -0.9483291 -0.9196852 -0.8284720 -0.9929495
##         V441       V442       V443       V444       V445          V446
## 1 -0.9826631 -0.9979933 -0.8788944 -0.8381520 -0.9291400  0.0007581481
##          V447       V448 V449       V450       V451        V452
## 1  0.20014368 -0.2533842 -1.0 -0.9354839 -0.9310345  0.18403457
##          V453        V454          V455        V456        V457       V458
## 1 -0.05932286  0.43810716 -0.3954227600 -0.69876160 -0.38745724 -0.7863942
##         V459       V460       V461       V462       V463       V464
## 1 -0.4856536 -0.7868151 -0.9946291 -0.9904691 -0.9927778 -0.9956797
##         V465       V466       V467       V468       V469       V470
## 1 -0.9870777 -0.9866510 -0.9841144 -0.9852502 -0.9935525 -0.9924302
##         V471       V472       V473       V474       V475       V476
## 1 -0.9856058 -0.9846170 -0.9932692 -0.9927255 -0.9779278 -0.9948522
##         V477       V478       V479       V480       V481       V482
## 1 -0.9978191 -0.9948430 -0.9924099 -0.9881227 -0.9904332 -0.9879613
##         V483       V484       V485       V486       V487       V488
## 1 -0.9817910 -0.9963992 -0.9914523 -0.9880600 -0.9820484 -0.9933800
##         V489       V490       V491       V492       V493       V494
## 1 -0.9988777 -0.9983667 -0.9984673 -0.9983746 -0.9989059 -0.9958936
##         V495       V496       V497       V498       V499       V500
## 1 -0.9931284 -0.9954723 -0.9983871 -0.9977543 -0.9980959 -0.9941477
##         V501       V502       V503       V504       V505       V506
## 1 -0.9981906 -0.9982901 -0.7909464 -0.7110740 -0.7267070 -0.7776971
##         V507       V508       V509       V510       V511       V512
## 1 -0.9448813 -0.7909464 -0.9539836 -0.8735426 -0.1745929 -1.0000000
##          V513        V514       V515       V516       V517       V518
## 1 -0.48345254  0.01104068 -0.3845166 -0.8950612 -0.8963596 -0.8881974
##         V519       V520       V521       V522       V523       V524
## 1 -0.9284657 -0.8980998 -0.8950612 -0.9934714 -0.9214767 -0.4846193
##         V525        V526       V527       V528       V529       V530
## 1 -1.0000000 -0.03535579 -0.2542483 -0.7003257 -0.7706100 -0.7971128
##         V531       V532       V533       V534       V535       V536
## 1 -0.7644846 -0.8201876 -0.9379593 -0.7706100 -0.9709580 -0.7983865
##         V537       V538        V539        V540       V541       V542
## 1  0.1794352 -1.0000000 -0.04739130 -0.46784901 -0.7613258 -0.8901655
##         V543       V544       V545       V546       V547       V548
## 1 -0.9073076 -0.8953006 -0.9178830 -0.9098288 -0.8901655 -0.9941054
##         V549       V550       V551        V552       V553       V554
## 1 -0.8980215 -0.2348153 -1.0000000  0.07164545 -0.3303704 -0.7059739
##           V555        V556        V557        V558       V559      V560
## 1  0.006462403  0.16291982 -0.82588562  0.27115145 -0.7200093 0.2768010
##          V561
## 1 -0.05797830
##  [ reached getOption("max.print") -- omitted 5 rows ]
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

### Now merge activity labels with train_test

```r
train_test <- train_test %>% dplyr::left_join(activity_names, by = "activityNum")
```

### Now change the data from short and wide format to tall and narrow format 

```r
reshape_train_test <- train_test %>% 
  tidyr::gather(key = "featureCode", value = "value", -subject, -activityNum, -activityName)
```

### merge activity name

```r
reshape_train_test <- reshape_train_test %>% 
  dplyr::left_join(features, by = "featureCode")
```

#### Create a new variable, activity that is equivalent to activityName as a factor class.Create a new variable, feature that is equivalent to featureName as a factor class.

```r
reshape_train_test$activity <- factor(reshape_train_test$activityName)
reshape_train_test$feature <- factor(reshape_train_test$featureName)
```

## Now let's separate features from featureName 


```r
jd_grep <- function (regex) {
  grepl(regex, reshape_train_test$feature)
}

reshape_train_test <- data.table(reshape_train_test)
## Features with 2 categories
n <- 2
y <- matrix(seq(1, n), nrow=n)
x <- matrix(c(jd_grep("^t"), jd_grep("^f")), ncol=nrow(y))

reshape_train_test$featDomain <- factor(x %*% y, labels=c("Time", "Freq"))
x <- matrix(c(jd_grep("Acc"), jd_grep("Gyro")), ncol=nrow(y))
reshape_train_test$featInstrument <- factor(x %*% y, labels=c("Accelerometer", "Gyroscope"))
x <- matrix(c(jd_grep("BodyAcc"), jd_grep("GravityAcc")), ncol=nrow(y))
reshape_train_test$featAcceleration <- factor(x %*% y, labels=c(NA, "Body", "Gravity"))
x <- matrix(c(jd_grep("mean()"), jd_grep("std()")), ncol=nrow(y))
reshape_train_test$featVariable <- factor(x %*% y, labels=c("Mean", "SD"))
## Features with 1 category
reshape_train_test$featJerk <- factor(jd_grep("Jerk"), labels=c(NA, "Jerk"))
reshape_train_test$featMagnitude <- factor(jd_grep("Mag"), labels=c(NA, "Magnitude"))
## Features with 3 categories
n <- 3
y <- matrix(seq(1, n), nrow=n)
x <- matrix(c(jd_grep("-X"), jd_grep("-Y"), jd_grep("-Z")), ncol=nrow(y))
reshape_train_test$featAxis <- factor(x %*% y, labels=c(NA, "X", "Y", "Z"))
head(reshape_train_test)
```

```
##    subject activityNum activityName featureCode     value featureNum
## 1:       1           5     STANDING          V1 0.2885845          1
## 2:       1           5     STANDING          V1 0.2784188          1
## 3:       1           5     STANDING          V1 0.2796531          1
## 4:       1           5     STANDING          V1 0.2791739          1
## 5:       1           5     STANDING          V1 0.2766288          1
## 6:       1           5     STANDING          V1 0.2771988          1
##          featureName activity           feature featDomain featInstrument
## 1: tBodyAcc-mean()-X STANDING tBodyAcc-mean()-X       Time  Accelerometer
## 2: tBodyAcc-mean()-X STANDING tBodyAcc-mean()-X       Time  Accelerometer
## 3: tBodyAcc-mean()-X STANDING tBodyAcc-mean()-X       Time  Accelerometer
## 4: tBodyAcc-mean()-X STANDING tBodyAcc-mean()-X       Time  Accelerometer
## 5: tBodyAcc-mean()-X STANDING tBodyAcc-mean()-X       Time  Accelerometer
## 6: tBodyAcc-mean()-X STANDING tBodyAcc-mean()-X       Time  Accelerometer
##    featAcceleration featVariable featJerk featMagnitude featAxis
## 1:             Body         Mean       NA            NA        X
## 2:             Body         Mean       NA            NA        X
## 3:             Body         Mean       NA            NA        X
## 4:             Body         Mean       NA            NA        X
## 5:             Body         Mean       NA            NA        X
## 6:             Body         Mean       NA            NA        X
```

```r
names(reshape_train_test)
```

```
##  [1] "subject"          "activityNum"      "activityName"    
##  [4] "featureCode"      "value"            "featureNum"      
##  [7] "featureName"      "activity"         "feature"         
## [10] "featDomain"       "featInstrument"   "featAcceleration"
## [13] "featVariable"     "featJerk"         "featMagnitude"   
## [16] "featAxis"
```

```r
dim(reshape_train_test)
```

```
## [1] 679734     16
```

## Create a tidy data set 

```r
library(data.table)
reshape_train_test <- data.table(reshape_train_test)
setkey(reshape_train_test, subject, activity, featDomain, featAcceleration, featInstrument, featJerk, featMagnitude, featVariable, featAxis)
tidy_data <- reshape_train_test[, list(count = .N, average = mean(value)), by=key(reshape_train_test)]
head(tidy_data)
```

```
##    subject activity featDomain featAcceleration featInstrument featJerk
## 1:       1   LAYING       Time               NA      Gyroscope       NA
## 2:       1   LAYING       Time               NA      Gyroscope       NA
## 3:       1   LAYING       Time               NA      Gyroscope       NA
## 4:       1   LAYING       Time               NA      Gyroscope       NA
## 5:       1   LAYING       Time               NA      Gyroscope       NA
## 6:       1   LAYING       Time               NA      Gyroscope       NA
##    featMagnitude featVariable featAxis count     average
## 1:            NA         Mean        X    50 -0.01655309
## 2:            NA         Mean        Y    50 -0.06448612
## 3:            NA         Mean        Z    50  0.14868944
## 4:            NA           SD        X    50 -0.87354387
## 5:            NA           SD        Y    50 -0.95109044
## 6:            NA           SD        Z    50 -0.90828466
```

```r
dim(tidy_data)
```

```
## [1] 11880    11
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
