




SELECT AVG(middle_values_GENERAL_APPEARANCE) AS median_value
FROM
(
    SELECT GENERAL_APPEARANCE  AS middle_values_GENERAL_APPEARANCE 
    FROM [xuanminh].[dbo].[data_student$]
    ORDER BY middle_values_GENERAL_APPEARANCE 
    OFFSET (SELECT COUNT(*) FROM [xuanminh].[dbo].[data_student$]) / 2 ROWS
    FETCH NEXT (CASE WHEN (SELECT COUNT(*) FROM [xuanminh].[dbo].[data_student$]) % 2 = 0 THEN 2 ELSE 1 END) ROWS ONLY
) AS middle
