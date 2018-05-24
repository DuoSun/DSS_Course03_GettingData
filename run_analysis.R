# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 

library(dplyr)

y_train          <- read.table("./UCI HAR Dataset/train/y_train.txt",header = FALSE,sep="",col.names = ("label"))
y_test           <- read.table("./UCI HAR Dataset/test/y_test.txt",header = FALSE,sep="",col.names = ("label"))
y                <- bind_rows(y_train,y_test)

activity_labels  <- read.table("./UCI HAR Dataset/activity_labels.txt",header = FALSE,sep="",col.names = c("label","activity"))
z                <- y
z[]              <- lapply(y, function(x) activity_labels$activity[match(x, activity_labels$label)])
names(z)         <- "activity"

subject_train    <- read.table("./UCI HAR Dataset/train/subject_train.txt",header = FALSE,sep="",col.names = ("subject"))
subject_test     <- read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE,sep="",col.names = ("subject"))
subject          <- bind_rows(subject_train,subject_test)

body_acc_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt",header = FALSE,sep="")
body_acc_x_test  <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt",header = FALSE,sep="")
body_acc_x       <- bind_rows(body_acc_x_train,body_acc_x_test) %>% transmute(body_acc_x_ave=rowMeans(.),body_acc_x_std=apply(.,1,sd))

body_acc_y_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt",header = FALSE,sep="")
body_acc_y_test  <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt",header = FALSE,sep="")
body_acc_y       <- bind_rows(body_acc_y_train,body_acc_y_test) %>% transmute(body_acc_y_ave=rowMeans(.),body_acc_y_std=apply(.,1,sd))

body_acc_z_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt",header = FALSE,sep="")
body_acc_z_test  <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt",header = FALSE,sep="")
body_acc_z       <- bind_rows(body_acc_z_train,body_acc_z_test) %>% transmute(body_acc_z_ave=rowMeans(.),body_acc_z_std=apply(.,1,sd))

body_gyro_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt",header = FALSE,sep="")
body_gyro_x_test  <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt",header = FALSE,sep="")
body_gyro_x       <- bind_rows(body_gyro_x_train,body_gyro_x_test) %>% transmute(body_gyro_x_ave=rowMeans(.),body_gyro_x_std=apply(.,1,sd))

body_gyro_y_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt",header = FALSE,sep="")
body_gyro_y_test  <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt",header = FALSE,sep="")
body_gyro_y       <- bind_rows(body_gyro_y_train,body_gyro_y_test) %>% transmute(body_gyro_y_ave=rowMeans(.),body_gyro_y_std=apply(.,1,sd))

body_gyro_z_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt",header = FALSE,sep="")
body_gyro_z_test  <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt",header = FALSE,sep="")
body_gyro_z       <- bind_rows(body_gyro_z_train,body_gyro_z_test) %>% transmute(body_gyro_z_ave=rowMeans(.),body_gyro_z_std=apply(.,1,sd))

total_acc_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt",header = FALSE,sep="")
total_acc_x_test  <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt",header = FALSE,sep="")
total_acc_x       <- bind_rows(total_acc_x_train,total_acc_x_test) %>% transmute(total_acc_x_ave=rowMeans(.),total_acc_x_std=apply(.,1,sd))

total_acc_y_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt",header = FALSE,sep="")
total_acc_y_test  <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt",header = FALSE,sep="")
total_acc_y       <- bind_rows(total_acc_y_train,total_acc_y_test) %>% transmute(total_acc_y_ave=rowMeans(.),total_acc_y_std=apply(.,1,sd))

total_acc_z_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt",header = FALSE,sep="")
total_acc_z_test  <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt",header = FALSE,sep="")
total_acc_z       <- bind_rows(total_acc_z_train,total_acc_z_test) %>% transmute(total_acc_z_ave=rowMeans(.),total_acc_z_std=apply(.,1,sd))

data_set1 <- bind_cols(z,subject,body_acc_x,body_acc_y,body_acc_z,body_gyro_x,body_gyro_y,body_gyro_z,total_acc_x,total_acc_y,total_acc_z)

print(names(data_set1))

# 5. Creat new independent tidy data set with the average of each variable for each activity and each subject.
data_set2 <- data_set1 %>% 
  group_by(activity,subject) %>%
  summarise_all(funs(mean))

# Save the dataset into .txt
write.table(data_set2,file = "dataset.txt",sep=" ",row.names = FALSE)
