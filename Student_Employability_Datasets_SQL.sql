          /* I cleaned the titles of the data and calculated some basic statistics using SQL */

-- Overview Data Students
Select *
FROM data_students

-- Change all titles to underscore format instead of spaces and hyphens and capitalize all letters.
EXEC sp_rename 'data_students.[Name of Student]', 'NAME_OF_STUDENT', 'COLUMN';
EXEC sp_rename 'data_students.[GENERAL APPEARANCE]', 'GENERAL_APPEARANCE', 'COLUMN';
EXEC sp_rename 'data_students.[MANNER OF SPEAKING]', 'MANNER_OF_SPEAKING', 'COLUMN';
EXEC sp_rename 'data_students.[PHYSICAL CONDITION]', 'PHYSICAL_CONDITION', 'COLUMN';
EXEC sp_rename 'data_students.[MENTAL ALERTNESS]', 'MENTAL_ALERTNESS', 'COLUMN';
EXEC sp_rename 'data_students.[ABILITY TO PRESENT IDEAS]', 'ABILITY_TO_PRESENT_IDEAS', 'COLUMN';
EXEC sp_rename 'data_students.[COMMUNICATION SKILLS]', 'COMMUNICATION_SKILLS', 'COLUMN';
EXEC sp_rename 'data_students.[Student Performance Rating]', 'STUDENT_PERFORMANCE_RATING', 'COLUMN';

-- Replace the values of Employable with 1 and LessEmployable with 0 in the CLASS column for calculations.
UPDATE data_students
SET CLASS = CASE 
               WHEN class = 'Employable' THEN 1 
               WHEN class = 'LessEmployable' THEN 0 
               ELSE class 
           END

-- Currently, the data type of the CLASS column is Nvarchar. Convert it to Float type for calculation.
ALTER TABLE data_students
ALTER COLUMN CLASS FLOAT

-- Calculate the median
SELECT AVG(middle_values_GENERAL_APPEARANCE) AS median_value
FROM
(
    SELECT GENERAL_APPEARANCE  AS middle_values_GENERAL_APPEARANCE 
    FROM data_students
    ORDER BY middle_values_GENERAL_APPEARANCE 
    OFFSET (SELECT COUNT(*) FROM data_students) / 2 ROWS
    FETCH NEXT (CASE WHEN (SELECT COUNT(*) FROM data_students) % 2 = 0 THEN 2 ELSE 1 END) ROWS ONLY
) AS middle

                            /* Similarly, obtain the result:
                            GENERAL_APPEARANCE            4.0
                            MANNER_OF_SPEAKING            4.0
                            PHYSICAL_CONDITION            4.0
                            MENTAL_ALERTNESS              4.0
                            SELF_CONFIDENCE               4.0
                            ABILITY_TO_PRESENT_IDEAS      4.0
                            COMMUNICATION_SKILLS          3.0
                            STUDENT_PERFORMANCE_RATING    5.0
                            CLASS                         1.0
                            */


-- Calculate the mean value
SELECT AVG(GENERAL_APPEARANCE) as average_general_appearance
FROM data_students;

                            /* Similarly, obtain the result:
                            GENERAL_APPEARANCE	        4.246814
                            MANNER_OF_SPEAKING      	3.884641
                            PHYSICAL_CONDITION	        3.972166
                            MENTAL_ALERTNESS	        3.962777
                            SELF_CONFIDENCE	            3.910798
                            ABILITY_TO_PRESENT_IDEAS	3.813883
                            COMMUNICATION_SKILLS	    3.525486
                            STUDENT_PERFORMANCE_RATING	4.610664
                            CLASS	                    0.579812
                            */
-- Find the most frequent value in each column.
SELECT TOP 1 GENERAL_APPEARANCE
FROM data_students
GROUP BY GENERAL_APPEARANCE
ORDER BY COUNT(*) DESC;

                            /* Similarly, perform the same action for the remaining columns to obtain the most frequent values.
                            GENERAL_APPEARANCE                  4.0
                            MANNER_OF_SPEAKING                  4.0
                            PHYSICAL_CONDITION                  4.0
                            MENTAL_ALERTNESS                    4.0
                            SELF-CONFIDENCE                     4.0
                            ABILITY_TO_PRESENT_IDEAS            4.0
                            COMMUNICATION_SKILLS                3.0
                            STUDENT_PERFORMANCE_RATING          5.0
                            CLASS                               1.0
                            */

-- Calculate variance
SELECT VAR(GENERAL_APPEARANCE) as Variance_General_Appearance
FROM data_students;

                            /* Similarly, obtain the result:
                            GENERAL_APPEARANCE            0.460364
                            MANNER_OF_SPEAKING            0.573068
                            PHYSICAL_CONDITION            0.553737
                            MENTAL_ALERTNESS              0.611496
                            SELF-CONFIDENCE               0.652222
                            ABILITY_TO_PRESENT_IDEAS      0.546697
                            COMMUNICATION_SKILLS          0.553359
                            STUDENT_PERFORMANCE_RATING    0.480034
                            CLASS                         0.243712
                            */
-- Calculate standard deviation
SELECT STDEV(GENERAL_APPEARANCE) AS GeneralAppearanceStdDev
FROM data_students;

                            /* results: 
                            GENERAL_APPEARANCE            0.678501
                            MANNER_OF_SPEAKING            0.757013
                            PHYSICAL_CONDITION            0.744135
                            MENTAL_ALERTNESS              0.781982
                            SELF-CONFIDENCE               0.807602
                            ABILITY_TO_PRESENT_IDEAS      0.739390
                            COMMUNICATION_SKILLS          0.743881
                            STUDENT_PERFORMANCE_RATING    0.692845
                            CLASS                         0.493672
                            */
