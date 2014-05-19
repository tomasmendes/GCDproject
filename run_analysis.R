library(reshape2)

xt <- read.table("UCI HAR Dataset/train/X_train.txt")
yt <- read.table("UCI HAR Dataset/train/y_train.txt")
xtst <- read.table("UCI HAR Dataset/test/X_test.txt")
ytst <- read.table("UCI HAR Dataset/test/y_test.txt")
X <- rbind(xt,xtst)
Y <- rbind(yt, ytst)

subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt")
Subj <- rbind(subjecttrain, subjecttest)


fts <- read.table("UCI HAR Dataset/features.txt", header=FALSE,colClasses="character")
ftsFILT<- grep("mean\\(\\)|std\\(\\)", fts[, 2])

X <- X[, ftsFILT]
names(X) <- fts[ftsFILT, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- gsub("-","",names(X))
names(X) <- tolower(names(X))

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
Y[,1] = activities[Y[,1], 2]

names(Y)<- "Activity"
names(Subj) <- "subject"
clean <- cbind(Subj, Y, X)

id_vars = c("subject", "Activity")
molten <- melt(clean,id_vars)
tidy <- dcast(molten, subject + Activity ~ variable, mean)
write.table(tidy,"Final.txt")
