Coursera Getting data Project - Codebook
----------------------------------------

### Overview and Purpose

The dataset represents measurements from embedded accelerometer and gyroscope in smartphones worn by 30 volunteers. Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone, and 3-axial linear acceleration and 3-axial angular velocity measurements were made at a constant rate of 50Hz. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The purpose of this exercise is to calculate the average for each mean and standard deviation variable across the training and test datasets, whilst demonstrating a 'tidy' attribute to data.

### Datastructure

For each record it is provided:

-   Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
-   Triaxial Angular velocity from the gyroscope.
-   A 561-feature vector with time and frequency domain variables.
-   Its activity label.
-   An identifier of the subject who carried out the experiment.

The dataset includes the following files:

-   'features\_info.txt': Shows information about the variables used on the feature vector.
-   'features.txt': List of all features.
-   'activity\_labels.txt': Links the class labels with their activity name.
-   'train/X\_train.txt': Training set.
-   'train/y\_train.txt': Training labels.
-   'test/X\_test.txt': Test set.
-   'test/y\_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

-   'train/subject\_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
-   'train/Inertial Signals/total\_acc\_x\_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total\_acc\_x\_train.txt' and 'total\_acc\_z\_train.txt' files for the Y and Z axis.
-   'train/Inertial Signals/body\_acc\_x\_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
-   'train/Inertial Signals/body\_gyro\_x\_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

Notes:
\* Features are normalized and bounded within \[-1,1\]. \* Each feature vector is a row on the text file.

### Processing Steps:

1.  Read and merge the training and test datasets
2.  Extract mean and SD measurements, ignoring other measurement types
3.  Use descriptive activity names to name the activities in the data set
4.  Appropriately label the data set with descriptive variable names
5.  From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject. The output is stored in "tidydata.txt"
