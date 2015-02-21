# Course-Project
Course Project for Coursera Getting &amp; Cleaning Data

This repository contains the following files:

1. README.md
2. run_analysis.R: script to analyze data from UCI Human project and generate "tidy_data.txt"
3. tidy_data.txt : the data.frame resulting from the steps of the "run_analysis" script
4. Codebook.txt: describes the variables contained in the tiny_data.txt file

=================================================
The following are the processing steps used to create the tidy dataset:

1. Download Files from UCI HAR Project and save to a local directory
2. Load the features.txt file & extract the names contained in variable:V2
3. Process "Testing" Data

    a. Load test data
    b. Extract only variables containing information on mean and standard deviation measures
    c. Load activity descriptions for testing data
    d. Load subject id's for testing data & rename variable to "subject"
    e. Combine subject id's and activities using cbind()
    d. Combine subject, activities and testing data using cbind()
    f. Add activity descriptions associated with each activity performed using merge()
    g. Rename activities variable to "activity"
    h. Create a clean dataset containing only extracted variables, subject ID and activity 
    
4. Process "Training" Data
  *follow steps a-h outlined in Step 3
5. Merge the clean datasets created in steps 3g and 4g
6. Created an independent tidy data set with the average of each variable grouped by activity for each subject.
7. Convert the tidy data set to a txt file




