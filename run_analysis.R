setwd("D:\\timons\\Documents\\R\\Coursera\\getCleanData\\week3\\project")

#Step 1 read and merge the datasets
full_X<-rbind(read.table(".\\UCI HAR Dataset\\test\\X_test.txt"),read.table(".\\UCI HAR Dataset\\train\\X_train.txt"))
full_Y<-rbind(read.table(".\\UCI HAR Dataset\\test\\y_test.txt"),read.table(".\\UCI HAR Dataset\\train\\y_train.txt"))
actLabels<-read.table(".\\UCI HAR Dataset\\activity_labels.txt")
colnames(actLabels)<-c("Id","ActivityName")
featLabels<-read.table(".\\UCI HAR Dataset\\features.txt")
colnames(featLabels)<-c("Id","Name")

#step 2 extract means and standard deviations
mean_cols<-grep(glob2rx("*mean*"),featLabels$Name, ignore.case =TRUE)
means<-full_X[mean_cols]
stdev_cols<-grep(glob2rx("*std*"),featLabels$Name, ignore.case =TRUE)
stdevs<-full_X[mean_cols]

#step 3 Add activity column into new dataset full
merged_Y<-merge(full_Y,actLabels, by.x = 1, by.y=1)
full<-cbind(merged_Y[2] ,full_X)

#step 4 Add columnames to full dataset
colnames(full)<-c("ActivityName",t(featLabels[2]))


#step 5 create dataset cat_means with means per category
cat_means<-aggregate(full[,2:562],list(full[,1]),FUN = function(x) mean(as.numeric(as.character(x))))
write.table(cat_means, file="new_set.txt", row.names=FALSE)
