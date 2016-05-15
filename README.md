# Getting and Cleaning Data - Assignment

This is for the Getting and Cleaning Data Assignment.

The R script, 'run_analysis.R', does the following:

1. The Scripts clears the console and gets the current working directory. 
	The current working directory is then used as base directory to create other folders and files during the process.
	It will also log various log messages during the process
2. Script checks if the required package 'respahe2' is installed. 
	if not script will try to install the package before proceeding further with getting and cleaning the data.
3. If the script fails to install or not able to find the 'reshape2' as one of the installed package.
	It will prompt the   user with message "It seems some issue in installing Package 'reshape2'. 
	Please install it manually, and re-try ..."
4. Script will delete (if present) (for a clean slate) and re-create the following folders

	'raw-data' - to store the downloaded file (as assignment_data.zip)
	
	'UCI HAR Dataset' - to unzip the downloaded file (unzip of assignment_data.zip file having all the data)
	
	'merged-data' - to store the merged data file (merged_data.txt)
	
	'tidy-data' - to store the tidy data file (tidy_data.txt)
	
5. Download the dataset in 'raw-data' folder as a 'assignment_data.zip' zip file.
6. Load the activity and feature info.
7. Loads both the training and test datasets, keeping only those columns which
   reflect a mean or standard deviation
8. Loads the activity and subject data for each dataset, and merges those
   columns with the dataset.
9. Merges the two datasets and store the file under 'merged-data' folder.
10. Converts the `activity` and `subject` columns into factors
11. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.
12. Store the file `tidy_data.txt` under 'tidy-data' folder, having the cleaned data.
13. Script will display the time it took to compelte the above mentioned.
14. Script then prompts the user to check the tidy data under tidy-data folder (a sub folder in current working directory)
