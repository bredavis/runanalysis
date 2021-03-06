run_analysis <- function() {
	##Make the "test" dataset
	subject_test <- read.table("subject_test.txt", header=FALSE)
	x_test <- read.table("X_test.txt", header=FALSE)
	y_test <- read.table("Y_test.txt", header=FALSE)
	test_dataset <- cbind(x_test, y_test, subject_test)
	
	##Make the "train" dataset
	subject_train <- read.table("subject_train.txt", header=FALSE)
	x_train <- read.table("X_train.txt", header=FALSE)
	y_train <- read.table("Y_train.txt", header=FALSE)
	train_dataset <- cbind(x_train, y_train, subject_train)
	
	##Merge into one dataset
	full_dataset <- rbind(test_dataset, train_dataset)
	
	##Narrow the dataset to only include mean and std variables
	narrow_dataset <- full_dataset[,c(1:6, 41:46, 81:86, 121:126, 161:166, 201, 202, 214, 215, 227, 228, 240, 241, 253, 254, 266:271, 294:296, 345:350, 373:375, 424:429, 452:454, 503, 504, 513, 516, 517, 526, 529, 542, 543, 555:563)]
	
	##Name the variables based on features.txt
	column_labels <- read.table("features.txt", header=FALSE)
	short_clabels <- column_labels[c(1:6, 41:46, 81:86, 121:126, 161:166, 201, 202, 214, 215, 227, 228, 240, 241, 253, 254, 266:271, 294:296, 345:350, 373:375, 424:429, 452:454, 503, 504, 513, 516, 517, 526, 529, 542, 543, 555:561),2]
	names(narrow_dataset) <- short_clabels
	names(narrow_dataset)[84] <- "Activity"
	names(narrow_dataset)[85] <- "ID"
	narrow_dataset <- narrow_dataset[,c(84,85,1:83)]
	narrow_dataset <- narrow_dataset[order(narrow_dataset$Activity, narrow_dataset$ID),]
	
	##Calculate the mean of each variable for each activity performed by each subject 
	Activity1 <- narrow_dataset[narrow_dataset$Activity == 1,]
	Activity1 <- Activity1 %>% group_by(ID) %>% summarise_each(funs(mean))
	Activity2 <- narrow_dataset[narrow_dataset$Activity == 2,]
	Activity2 <- Activity2 %>% group_by(ID) %>% summarise_each(funs(mean))	
	Activity3 <- narrow_dataset[narrow_dataset$Activity == 3,]
	Activity3 <- Activity3 %>% group_by(ID) %>% summarise_each(funs(mean))	
	Activity4 <- narrow_dataset[narrow_dataset$Activity == 4,]
	Activity4 <- Activity4 %>% group_by(ID) %>% summarise_each(funs(mean))	
	Activity5 <- narrow_dataset[narrow_dataset$Activity == 5,]
	Activity5 <- Activity5 %>% group_by(ID) %>% summarise_each(funs(mean))	
	Activity6 <- narrow_dataset[narrow_dataset$Activity == 6,]
	Activity6 <- Activity6 %>% group_by(ID) %>% summarise_each(funs(mean))
	
	##Merge into final dataset
	final_dataset <- rbind(Activity1, Activity2, Activity3, Activity4, Activity5, Activity6)
}
