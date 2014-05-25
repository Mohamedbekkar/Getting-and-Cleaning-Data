data_gathering<-function (folder, partition="train") {
require("data.table")  
feature_path <-paste0(folder,"/UCI HAR Dataset/features.txt")
feature<-read.table (feature_path,header=F, as.is=T, 
                     col.names=c("MeasureID","MeasureName"))
if (partition == "train") {
  x_train_path <- paste0(folder,"/UCI HAR Dataset/",partition,"/X_",
                         partition,".txt")
  x_train <-read.table(x_train_path,header=F)
  names(x_train)<-feature$MeasureName
  y_train_path <- paste0(folder,"/UCI HAR Dataset/",partition,"/y_",
                         partition,".txt")
  y_train <-read.table(y_train_path,header=F,col.names=c("Activity_ID"))
  subject_train_path <-paste0(folder,"/UCI HAR Dataset/",partition,"/subject_",
                              partition,".txt")
  subject_train <-read.table(subject_train_path,header=F, col.names=c("Subject_ID"))
  Data<-cbind(subject_train,y_train,x_train)
  
}
else { if (partition=="test"){
  x_test_path <- paste0(folder,"/UCI HAR Dataset/",partition,"/X_",
                        partition,".txt")
  x_test <-read.table(x_test_path,header=F)
  names(x_test)<-feature$MeasureName
  y_test_path <- paste0(folder,"/UCI HAR Dataset/",partition,"/y_",
                        partition,".txt")
  y_test <-read.table(y_test_path,header=F,col.names=c("Activity_ID"))
  subject_test_path <-paste0(folder,"/UCI HAR Dataset/",partition,"/subject_",
                             partition,".txt")
  subject_test <-read.table(subject_test_path,header=F, col.names=c("Subject_ID"))
  Data<-cbind(subject_test,y_test,x_test)  
}
}
Data
}