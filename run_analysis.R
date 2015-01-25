# this script assumes that the Samsung data has been extracted to a folder called
#"getdata-projectfiles-UCI HAR Dataset"

#get the column headings
headingsFile<-  "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt"
headings <- read.table(headingsFile, stringsAsFactors=FALSE)   

#get activity labels
activityFile<-  "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt"
activityLabel <- read.table(activityFile, stringsAsFactors=FALSE)   

#get the test data
testMeasurementsFile <- "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt"
testMeasurements <- read.table(testMeasurementsFile, col.names = headings$V2)

testActivityFile <- "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt"
testActivity <- read.table(testActivityFile)
testSubjectFile <- "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt"
testSubject <- read.table(testSubjectFile)

#get training data
trainMeasurementsFile <- "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"
trainMeasurements <- read.table(trainMeasurementsFile, col.names = headings$V2)

trainActivityFile <- "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt"
trainActivity <- read.table(trainActivityFile)
trainSubjectFile <- "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"
trainSubject <- read.table(trainSubjectFile)
trainDataFile <- "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"
traindata <- read.table(trainDataFile, col.names = headings$V2)


#combine activity and subject to measurement test data
#only get columns that have mean or std
subsetCols <-grep("mean[^F]|std",colnames(trainMeasurements))
testCombined <- testMeasurements[,subsetCols]
#add activity and subject
#apply activity labels
testActivityLabels <- merge(testActivity, activityLabel, by = "V1")
testCombined$Activity <- testActivityLabels$V2
testCombined$Subject <- testSubject$V1


#combine activity and subject to measurement training data
#only get columns that have mean or std
subsetCols <-grep("mean[^F]|std",colnames(trainMeasurements))
trainCombined <- trainMeasurements[,subsetCols]
#add activity and subject
#apply activity labels
trainActivityLabels <- merge(trainActivity, activityLabel, by = "V1")
trainCombined$Activity <- trainActivityLabels$V2
trainCombined$Subject <- trainSubject$V1

#merge test and train (but not a 'join merge")
Combined<-rbind(trainCombined, testCombined)

#Rename variables 
colnames <- colnames(Combined)
colnames <- gsub(colnames,pattern =  "[.]", replacement = "")
colnames <- gsub(colnames,pattern =  "tBody", replacement = "Time domain signal body ")
colnames <- gsub(colnames,pattern =  "fBody", replacement = "Frequency domain signal body ")
colnames <- gsub(colnames,pattern =  "tGravity", replacement = "Time domain signal gravity ")
colnames <- gsub(colnames,pattern =  "fGravity", replacement = "Frequency domain signal gravity ")

colnames <- gsub(colnames,pattern =  "Acc", replacement = "acceleration ")
colnames <- gsub(colnames,pattern =  "Gyro", replacement = "gyroscope ")
colnames <- gsub(colnames,pattern =  "Jerk", replacement = "jerk ")
colnames <- gsub(colnames,pattern =  "Mag", replacement = "magnitude ")
colnames <- gsub(colnames,pattern =  "mean", replacement = "mean ")
colnames <- gsub(colnames,pattern =  "std", replacement = "standard deviation ")
colnames <- gsub(colnames,pattern =  "X", replacement = "in the X axis")
colnames <- gsub(colnames,pattern =  "Y", replacement = "in the Y axis")
colnames <- gsub(colnames,pattern =  "Z", replacement = "in the Z axis")

colnames(Combined) <- colnames

#average variable for each subject and activity

averagebysubjectactivity <- 
aggregate.data.frame(Combined[,colnames], 
                     by=list(Subject = Combined$Subject,
                             Activity = Combined$Activity ), 
                     FUN = "mean")
write.table(averagebysubjectactivity, row.name=FALSE, "averagebysubjectactivity.txt")
