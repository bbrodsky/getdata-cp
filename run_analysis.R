library(reshape2)

importdata <- function() {
  S <- rbind(read.table("./UCI HAR Dataset/train/subject_train.txt"), read.table("./UCI HAR Dataset/test/subject_test.txt"))
  names(S) <- "Subject"
  
  Y <- rbind(read.table("./UCI HAR Dataset/train/y_train.txt"),read.table("./UCI HAR Dataset/test/y_test.txt"))
  names(Y) <- "Activity"
  
  X <- rbind(read.table("./UCI HAR Dataset/train/X_train.txt"),read.table("./UCI HAR Dataset/test/X_test.txt"))
  names(X)<- read.table("./UCI HAR Dataset/features.txt")$V2

  
  HAR <- cbind(S,Y,X)
  HAR
}

run_analysis <- function () {
  #1 & #4
  dataset <- importdata();
  
  #2
  ckeep <- grep("-mean\\(|-std\\(",names(dataset))
  dataset <- dataset[,c(1,2, ckeep)]
  
  #3
  actl <- read.table("./UCI HAR Dataset/activity_labels.txt")
  dataset[,2] <- actl$V2[dataset[,2]]
  
  #5
  melt_dataset <- melt(dataset,id.vars = c("Subject", "Activity"))
  dcast_dataset <- dcast(melt_dataset, Subject + Activity ~ variable, mean)
  write.table(dcast_dataset, file = "tidy_data.txt", row.names = FALSE)
  

}