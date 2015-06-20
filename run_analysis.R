
library(plyr)

# Read in the data from files

features     = read.table('features.txt',header=FALSE)
activityType = read.table('activity_labels.txt',header=FALSE) 
subjectTrain = read.table('subject_train.txt',header=FALSE)
xTrain       = read.table('x_train.txt',header=FALSE)
yTrain       = read.table('y_train.txt',header=FALSE)
subjectTest = read.table('subject_test.txt',header=FALSE)
xTest       = read.table('x_test.txt',header=FALSE)
yTest       = read.table('y_test.txt',header=FALSE)



# Assigin column names to the data imported above

colnames(activityType)  = c('activityId','activityType')
colnames(subjectTrain)  = "subjectId"
colnames(xTrain)        = features[,2] 
colnames(yTrain)        = "activityId"
colnames(subjectTest) = "subjectId"
colnames(xTest)       = features[,2] 
colnames(yTest)       = "activityId"


# Merges the training and the test sets to create one data set.

xdata <- rbind(xTrain, xTest)
ydata <- rbind(yTrain, yTest)
subjectData <- rbind(subjectTrain, subjectTest)



#Extracts only the measurements on the mean and standard deviation for each measurement. 

xdata <- xdata[, mean_and_std_features]
colnames(xdata) <- features[mean_and_std_features, 2]
ydata[, 1] <- activityType[ydata[, 1], 2]
allData <- cbind(xdata, ydata, subjectData)


#From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject

averagesData <- ddply(allData, .(subjectId, activityId), function(x) colMeans(x[, 1:66]))
write.table(averagesData, "tidydata.txt", row.names=TRUE,sep='\t')

