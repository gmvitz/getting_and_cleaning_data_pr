Codebook
================

The R file runs analysis that does the following.

## Load data sets

Load the data within the data folder sub directory containing the **UCI
HAR Dataset**

## Merge and assign variables

Loaded data is loaded into the `merged` data set which contains both
train and test data as well as updated variable names for the activities

The `subject` column is the subject ID and the `activity` column lists
the activity being measured. All other columns are variable values.

`merge_mean_std` is the same data set, but focused only on the variable
columns with mean and std deviation.

## Relabel the variables columns

Columns in the `merge_mean_std` file are renamed using `gsub()`

  - Acc -\> Accelerometer
  - Gyro -\> Gyroscope
  - BodyBody -\> Body
  - Mag -\> Magnitude
  - f -\> frequency
  - t -\> time
  - mean and std had parenthesis removed

## Create final dataset

The final data set is created by grouping from subject and activity, and
averaging by all other variables.
