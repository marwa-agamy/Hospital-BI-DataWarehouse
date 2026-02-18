DECLARE @start DATE = '2020-01-01', @end DATE = '2030-12-31';

WITH dates AS (
    SELECT @start AS full_date
    UNION ALL
    SELECT DATEADD(DAY,1,full_date) 
    FROM dates 
    WHERE full_date < @end
)
INSERT INTO dbo.dim_date(date_key, full_date, [year], [month], [day], quarter, day_of_week, is_weekend)
SELECT
    CAST(FORMAT(full_date,'yyyyMMdd') AS INT) AS date_key,
    full_date,
    YEAR(full_date) AS [year],
    MONTH(full_date) AS [month],
    DAY(full_date) AS [day],
    DATEPART(QUARTER, full_date) AS quarter,
    DATENAME(WEEKDAY, full_date) AS day_of_week,       -
    CASE WHEN DATENAME(WEEKDAY, full_date) IN ('Friday','Saturday') THEN 1 ELSE 0 END AS is_weekend
FROM dates
OPTION (MAXRECURSION 0);
