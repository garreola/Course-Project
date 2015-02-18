
#assing url for zip file to a variable called "run"
run<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download data files
download.file(run,temp)

#set working directory to store files
setwd("~/Documents/R/Getting & Cleaning Data/Course Project")

library(dplyr)

#load the variable labels for the test and training data
features=read.table("~/Documents/R/Getting & Cleaning Data/UCI HAR Dataset/features.txt")
#extract the column names
names<-select(features,V2)

#TESTING DATA
#Load Test Data Elements & append the column names
testdata=read.table("~/Documents/R/Getting & Cleaning Data/UCI HAR Dataset/test/X_test.txt", col.names=names[,1])
#extract ONLY the mean and standard deviation for all measures
  testdata2<-select(testdata,contains("mean"),contains("std"))

#add activity metadata
activities=read.table("~/Documents/R/Getting & Cleaning Data/UCI HAR Dataset/activity_labels.txt")

#load the activity labels that go with testing data
  testlabels=read.table("~/Documents/R/Getting & Cleaning Data/UCI HAR Dataset/test/y_test.txt")
#load id for person performing activity
  testsubject=read.table("~/Documents/R/Getting & Cleaning Data/UCI HAR Dataset/test/subject_test.txt")

#Cleaning Test Data
#Add label for test subjects
  testsubject<-rename(testsubject,subject=V1)
#combine test subjects and activities
  subact<-cbind(testsubject, testlabels)
#add the testing data
  testall<-cbind(subact,testdata2)
#add activity labels
  testall<- merge(testall,activities,all=TRUE)
#change variable name for "activity" and rearrange dataset
  testall<-rename(testall,activity=V2)
  testall<-select(testall, activity, subject,tBodyAcc.mean...X:fBodyBodyGyroJerkMag.std.. )

#TRAINING DATA

#loading training dataset
trainingdata=read.table("~/Documents/R/Getting & Cleaning Data/UCI HAR Dataset/train/X_train.txt",col.names=names[,1])
#extract ONLY the mean and standard deviation for all measures
traindata2<-select(trainingdata,contains("mean"),contains("std"))

#load the activity identifiers for each row
traininglabels=read.table("~/Documents/R/Getting & Cleaning Data/UCI HAR Dataset/train/y_train.txt")
#load id for person performing activity
trainsubject=read.table("~/Documents/R/Getting & Cleaning Data/UCI HAR Dataset/train/subject_train.txt")

#Cleaning TRAINING Data steps
  #Uses descriptive activity names to name the activities in the data set
    trainsubject<-rename(trainsubject,subject=V1)
  #combine train subjects and activities
    subact_train<-cbind(trainsubject, traininglabels)
  #add the trainingdata
    trainall<-cbind(subact_train,traindata2)
  #add activity labels
    trainall<- merge(trainall,activities,all=TRUE)
  #change variable name for "activity" and rearrange dataset
    trainall<-rename(trainall,activity=V2)
    trainall<-select(trainall, activity, subject,tBodyAcc.mean...X:fBodyBodyGyroJerkMag.std.. )

#MERGE BOTH DATASETS
alldata<-rbind(trainall, testall)
alldata<-arrange(alldata,subject)

#CREATE an independent tidy data set with the average of each variable for each activity and each subject.

databyact<-alldata %>%
  group_by(subject,activity) %>%
  summarise_each(funs(mean))

View(databyact)
group_by(alldata,subject,activity, mean)

write.table(databyact,file="~/Documents/R/tidy_data_file.txt",row.names=FALSE)
