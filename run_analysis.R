# Objective of the script is to 

# Step 1: Merges the training and the test sets to create one data set.
# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
# Step 3: Uses descriptive activity names to name the activities in the data set
# Step 4: Appropriately labels the data set with descriptive variable names.
# Step 5: From the data set in step 4, creates a second, independent tidy data set 
#			with the average of each variable for each activity and each subject.

#ctl +l clear the console
cat("\014")  

# CurrentDir is your home directory (by default)
# alternatly, you can setWd() to the directory (un-comment the following line with valid path) which has 'run_analysis.R' file
#setwd("your-path")

currentDir <- getwd()


##
# To test the auto installation of the respahe2 package , uncomment this following lines 2 lines, 
# It will first uninstall the package and then script will try to install it in the next block
#library(utils)
#remove.packages("reshape2")
##

print("Install the package 'reshape2' if not already installed.")

if (!("reshape2" %in% rownames(installed.packages())) ) 
{
	print("Required package 'reshape2' not found, I will try to install before proceeding further")
	install.packages("reshape2", dependencies = TRUE)
} 

print("Check if the package 'reshape2' is installed.")

if ( "reshape2" %in% rownames(installed.packages()) ) 
{
    #ctl +l clear the console
    cat("\014")  

    startTime <- Sys.time()  
    
    print("Package 'reshape2' Found, so lets start the show, the directory in context is  ...")
    print(currentDir)
    

    #define some folder location for data
    
    #To store teh downloaded file
    rawDataFolder <-  "raw-data"
    
    # Data is availble in following folder
    dataFolder <- "UCI HAR Dataset"    
    
    #to stor the merged data
    mergedDataFolder <- "merged-data"    
    
    #to stor the clean data
    tidyDataFolder <- "tidy-data"

    #check if the above mentioned folders exists, remove them including 
    # any subfolders of files in them, so to have a clean slate
    
    if (file.exists(file.path(currentDir, rawDataFolder))) { 
      unlink(file.path(currentDir, rawDataFolder), recursive=TRUE)
    }    
    
    if (file.exists(file.path(currentDir, dataFolder))) { 
      unlink(file.path(currentDir, dataFolder), recursive=TRUE)
    }        

    if (file.exists(file.path(currentDir, mergedDataFolder))) { 
      unlink(file.path(currentDir, mergedDataFolder), recursive=TRUE)
    }     
        
    if (file.exists(file.path(currentDir, tidyDataFolder))) { 
      unlink(file.path(currentDir, tidyDataFolder), recursive=TRUE)
    }      
    
    
    #Specifiy the downloaded file name
    fileName <- "assignment_data.zip"
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
    if(!file.exists("./raw-data")) {
      dir.create("./raw-data")
    }  
  
    filePath <- file.path(currentDir, "raw-data", fileName)
    
    if (!file.exists(filePath)) { 
      #For windows, download the file
      download.file(fileURL, filePath)
      
      #For mac etc. downlaod the file
      #download.file(fileURL, filePath, method="curl")
    } 
    
    #File must have been downloaded by this now, check and unzip the file
    if (file.exists(filePath)) { 
      unzip(filePath) 
    }
    

    
    ## Load the required package/libraries
    library(reshape2)
    
    
    ## Read all required (.txt) files and label the datasets
    
    ## Read all activities and their names and label the aproppriate columns 
    activity_labels <- read.table(file.path(dataFolder, "activity_labels.txt"),col.names=c("activity_id","activity_name"))
    print("Read all the available activity Labels ...")
    #print(activity_labels)
    
    ## Read the dataframe's column names
    features <- read.table(file.path(dataFolder, "features.txt"))
    feature_names <-  features[,2]
    print("Read all the feature Names ...")
    #print(feature_names)
    
    
    ## Read the test data and label the dataframe's columns
    test_data <- read.table(file.path(dataFolder, "test/X_test.txt"))
    colnames(test_data) <- feature_names
    print("Read the test data and assigned the feature Names to Test Data ...")
    #head(test_data)
    
    ## Read the training data and label the dataframe's columns
    train_data <- read.table(file.path(dataFolder, "train/X_train.txt"))
    colnames(train_data) <- feature_names    
    print("Read the train data and assigned the feature names to the Train Data ...")
    #head(train_data)
    
    
    ## Read the ids of the test subjects and label the the dataframe's columns
    test_subject_id <- read.table(file.path(dataFolder, "test/subject_test.txt"))
    colnames(test_subject_id) <- "subject_id"
    print("Read the ids of the test subjects and label the the dataframe's columns ...")
    
    ## Read the activity id's of the test data and label the the dataframe's columns
    test_activity_id <- read.table(file.path(dataFolder, "test/y_test.txt"))
    colnames(test_activity_id) <- "activity_id"
    print("Read the activity id's of the test data and label the the dataframe's columns ...")
    
    ## Read the ids of the test subjects and label the the dataframe's columns
    train_subject_id <- read.table(file.path(dataFolder, "train/subject_train.txt"))
    colnames(train_subject_id) <- "subject_id"
    print("Read the ids of the test subjects and label the the dataframe's columns")
    
    ## Read the activity id's of the training data and label 
    ##the dataframe's columns
    train_activity_id <- read.table(file.path(dataFolder, "train/y_train.txt"))
    colnames(train_activity_id) <- "activity_id"
    print("Read the activity id's of the training data and label the dataframe's columns")
    
    ##Combine the test subject id's, the test activity id's 
    ##and the test data into one dataframe
    test_data <- cbind(test_subject_id , test_activity_id , test_data)
    print("Combined the test data ...")
    
    ##Combine the test subject id's, the test activity id's 
    ##and the test data into one dataframe
    train_data <- cbind(train_subject_id , train_activity_id , train_data)
    print("Combined the train data ...")
    
    
    ##Combine the test data and the train data into one dataframe
    all_data <- rbind(train_data,test_data)    
    print("Combined the test and train data into one dataframe ...")
    
    
    head(all_data)
    
    
    print("Keeping only columns refering to mean() or std() values ...")
    
    ##Keep only columns refering to mean() or std() values
    mean_col_idx <- grep("mean",names(all_data),ignore.case=TRUE)
    mean_col_names <- names(all_data)[mean_col_idx]
    std_col_idx <- grep("std",names(all_data),ignore.case=TRUE)
    std_col_names <- names(all_data)[std_col_idx]
    meanstddata <-all_data[,c("subject_id","activity_id",mean_col_names,std_col_names)]
    
    ##Merge the activities dataset with the mean/std values datase 
    ##to get one dataset with descriptive activity names
    descrnames <- merge(activity_labels,meanstddata,by.x="activity_id",by.y="activity_id",all=TRUE)
    
    #Check and create the merged-data folder
    if(!file.exists("./merged-data")) {
      dir.create("./merged-data")
    }     
    print("Writing the merged data set ...")
    write.table(descrnames,file.path(mergedDataFolder, "merged_data.txt")) 
    

    ##Melt the dataset with the descriptive activity names for better handling
    data_melt <- melt(descrnames,id=c("activity_id","activity_name","subject_id"))
    
    ##Cast the melted dataset according to  the average of each variable 
    ##for each activity and each subjec
    mean_data <- dcast(data_melt,activity_id + activity_name + subject_id ~ variable,mean)
    print("Calculation of meandata completed ...")
    
    ## Create a file with the new tidy dataset
    
    if(!file.exists("./tidy-data")) {
      dir.create("./tidy-data")
    } 
    
    
    print("Writing the tidy data set ...")
    write.table(mean_data,file.path(tidyDataFolder, "tidy_data.txt"))    
    
    
    endTime <- Sys.time()  
    
    print("Getting and Cleaning data completed in ...")
    print(endTime - startTime)
    print("... Please Check the merged data at following location ...")
    print(file.path(currentDir, mergedDataFolder))    
    
    print("... Please Check the tidy data at following location ...")
    print(file.path(currentDir, tidyDataFolder))

} else {
  print("It seems some issue in installing Package 'reshape2'. Please install it manually, and re-try ...")
}


