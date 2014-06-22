#Read text files for "train" data set
features <- read.table("features.txt")
train <- read.table("train/X_train.txt")
train_labels <- read.table("train/y_train.txt")
train_subject <- read.table("train/subject_train.txt")

#Read text files for "test" data set
test <- read.table("test/X_test.txt")
test_labels <- read.table("test/y_test.txt")
test_subject <- read.table("test/subject_test.txt")

#combine both "test" and "train" data sets
test_train <- rbind(test, train)

#Combine "test_labels" with "train_labels", "test_subject" with "train_subject"
test_train_labels <- rbind(test_labels, train_labels)
test_train_subject <- rbind(test_subject, train_subject)

#Give column name to "test_train_labels" and "test_train_subject"
names(test_train_labels) <- "id"
names(test_train_subject) <- "subject"

#Give column names to the "test_train" data set
features[,2] <- as.character(features[,2])
names(test_train) <- features[,2]

#Combine "test_train_subject" and "test_train_labels" with "test_train" data set to form a complete data set
merged_data <- cbind(cbind(test_train_subject, test_train_labels), test_train)

#Extract the measurement on mean
tidy_mean <- dcast(merged_data, subject + id ~ names(merged_data)[c(3,4,5)], mean)

#Extract the measurement on standard deviation
tidy_std <- dcast(merged_data, subject + id ~ names(merged_data)[c(6,7,8)], sd)
