require("data.table")
require("reshape2")

source("data_gathering.R")
Data_train<-data_gathering("E:/Data","train")
Data_test<-data_gathering("E:/Data","test")

## 1.Merges the training and the test sets to create one data set.
Data_set<-rbind(Data_train,Data_test)

##2.Extracts only the measurements on the mean and standard deviation 
##for each measurement
folder<-getwd()
feature_path <-paste0(folder,"/UCI HAR Dataset/features.txt")
feature<-read.table (feature_path,header=F, 
                     col.names=c("MeasureID","MeasureName"))
## extract columns Id for mean and SD
subset_columns<- grep(".*mean\\(\\)|.*std\\(\\)", feature$MeasureName)

## add columns 1 (SubjectID) and 2 (Activity_ID) to the list
subset_columns <-c(1,2,(subset_columns+2))
Data_set<- Data_set[,subset_columns]

##3.Uses descriptive activity names to name the activities in the data set
##4.Appropriately labels the data set with descriptive activity names.
unique(Data_set$Activity_ID)
Act_Labels_path<-paste0(folder, "/UCI HAR Dataset/activity_labels.txt")
Act_Labels<-read.table(Act_Labels_path,header=F,
                       col.names=c("Activity_ID","Activity_Label"))
Data_set<-merge(Data_set,Act_Labels)

##5.Creates a second, independent tidy data set with 
##the average of each variable for each activity and each subject
ids= c("Subject_ID", "Activity_ID", "Activity_Label")
var_labels = setdiff(colnames(Data_set), ids)
Data_setN= melt(Data_set, id = ids, measure.vars = var_labels)
tidy_dataSet= dcast(Data_setN, Subject_ID + Activity_Label ~ variable, mean)
write.table(tidy_dataSet, file = paste(folder,"tidy_data.txt", sep="/"))

