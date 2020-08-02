DECLARE
	@SomeTime DATETIME2(7) = SYSUTCDATETIME();

-- Retrieve the year, month, and day
SELECT
	YEAR(@SomeTime) AS TheYear,
	MONTH(@SomeTime) AS TheMonth,
	DAY(@SomeTime) AS TheDay;


DECLARE
	@BerlinWallFalls DATETIME2(7) = '1989-11-09 23:49:36.2294852';

-- Fill in each date part
SELECT
	DATEPART(YEAR, @BerlinWallFalls) AS TheYear,
	DATEPART(MONTH, @BerlinWallFalls) AS TheMonth,
	DATEPART(DAY, @BerlinWallFalls) AS TheDay,
	DATEPART(DAYOFYEAR, @BerlinWallFalls) AS TheDayOfYear,
    -- Day of week is WEEKDAY
	DATEPART(WEEKDAY, @BerlinWallFalls) AS TheDayOfWeek,
	DATEPART(WEEK, @BerlinWallFalls) AS TheWeek,
	DATEPART(SECOND, @BerlinWallFalls) AS TheSecond,
	DATEPART(NANOSECOND, @BerlinWallFalls) AS TheNanosecond;


DECLARE
	@BerlinWallFalls DATETIME2(7) = '1989-11-09 23:49:36.2294852';

-- Fill in the function to show the name of each date part
SELECT
	DATENAME(YEAR, @BerlinWallFalls) AS TheYear,
	DATENAME(MONTH, @BerlinWallFalls) AS TheMonth,
	DATENAME(DAY, @BerlinWallFalls) AS TheDay,
	DATENAME(DAYOFYEAR, @BerlinWallFalls) AS TheDayOfYear,
    -- Day of week is WEEKDAY
	DATENAME(WEEKDAY, @BerlinWallFalls) AS TheDayOfWeek,
	DATENAME(WEEK, @BerlinWallFalls) AS TheWeek,
	DATENAME(SECOND, @BerlinWallFalls) AS TheSecond,
	DATENAME(NANOSECOND, @BerlinWallFalls) AS TheNanosecond;

-- Date math and leap years
DECLARE
	@LeapDay DATETIME2(7) = '2012-02-29 18:00:00';

-- Fill in the date parts and intervals as needed
SELECT
	DATEADD(DD, -1, @LeapDay) AS PriorDay,
	DATEADD(DD, 1, @LeapDay) AS NextDay,
    -- For leap years, we need to move 4 years, not just 1
	DATEADD(YEAR, -4, @LeapDay) AS PriorLeapYear,
	DATEADD(YEAR, 4, @LeapDay) AS NextLeapYear,
	DATEADD(YEAR, -1, @LeapDay) AS PriorYear;

DECLARE
	@PostLeapDay DATETIME2(7) = '2012-03-01 18:00:00';

-- Fill in the date parts and intervals as needed
SELECT
	DATEADD(DAY, -1, @PostLeapDay) AS PriorDay,
	DATEADD(DAY, 1, @PostLeapDay) AS NextDay,
	DATEADD(YEAR, -4, @PostLeapDay) AS PriorLeapYear,
	DATEADD(YEAR, 4, @PostLeapDay) AS NextLeapYear,
	DATEADD(YEAR, -1, @PostLeapDay) AS PriorYear,
    -- Move 4 years forward and one day back
	DATEADD(DAY, -1, DATEADD(YEAR, 4, @PostLeapDay)) AS NextLeapDay,
    DATEADD(DAY, -2, @PostLeapDay) AS TwoDaysAgo;


DECLARE
	@PostLeapDay DATETIME2(7) = '2012-03-01 18:00:00',
    @TwoDaysAgo DATETIME2(7);

SELECT
	@TwoDaysAgo = DATEADD(DAY, -2, @PostLeapDay);

SELECT
	@TwoDaysAgo AS TwoDaysAgo,
	@PostLeapDay AS SomeTime,
    -- Fill in the appropriate function and date types
	DATEDIFF(DAY, @TwoDaysAgo, @PostLeapDay) AS DaysDifference,
	DATEDIFF(HOUR, @TwoDaysAgo, @PostLeapDay) AS HoursDifference,
	DATEDIFF(MINUTE, @TwoDaysAgo, @PostLeapDay) AS MinutesDifference;


-- Rounding Dates
DECLARE
	@SomeTime DATETIME2(7) = '2018-06-14 16:29:36.2248991';

-- Fill in the appropriate functions and date parts
SELECT
	DATEADD(DAY, DATEDIFF(DAY, 0, @SomeTime), 0) AS RoundedToDay,
	DATEADD(HOUR, DATEDIFF(HOUR, 0, @SomeTime), 0) AS RoundedToHour,
	DATEADD(MINUTE, DATEDIFF(MINUTE, 0, @SomeTime), 0) AS RoundedToMinute;

-- Formatting Dates with CAST(), CONVERT() and FORMAT()
DECLARE
	@CubsWinWorldSeries DATETIME2(3) = '2016-11-03 00:30:29.245',
	@OlderDateType DATETIME = '2016-11-03 00:30:29.245';

SELECT
	-- Fill in the missing function calls
	CAST(@CubsWinWorldSeries AS DATE) AS CubsWinDateForm,
	CAST(@CubsWinWorldSeries AS NVARCHAR(30)) AS CubsWinStringForm,
	CAST(@OlderDateType AS DATE) AS OlderDateForm,
	CAST(@OlderDateType AS NVARCHAR(30)) AS OlderStringForm;

-- CubsWinDateForm	CubsWinStringForm	    OlderDateForm	OlderStringForm
-- 2016-11-03	    2016-11-03 00:30:29.245	2016-11-03	    Nov  3 2016 12:30AM

DECLARE
	@CubsWinWorldSeries DATETIME2(3) = '2016-11-03 00:30:29.245';

SELECT
	CAST(CAST(@CubsWinWorldSeries AS DATE) AS NVARCHAR(30)) AS DateStringForm;

-- DateStringForm
-- 2016-11-03

DECLARE
	@CubsWinWorldSeries DATETIME2(3) = '2016-11-03 00:30:29.245';

SELECT
	CONVERT(DATE, @CubsWinWorldSeries) AS CubsWinDateForm,
	CONVERT(NVARCHAR(30), @CubsWinWorldSeries) AS CubsWinStringForm;

-- CubsWinDateForm	CubsWinStringForm
-- 2016-11-03	    2016-11-03 00:30:29.245

DECLARE
	@CubsWinWorldSeries DATETIME2(3) = '2016-11-03 00:30:29.245';

SELECT
	CONVERT(NVARCHAR(30), @CubsWinWorldSeries, 0) AS DefaultForm,
	CONVERT(NVARCHAR(30), @CubsWinWorldSeries, 3) AS UK_dmy,
	CONVERT(NVARCHAR(30), @CubsWinWorldSeries, 1) AS US_mdy,
	CONVERT(NVARCHAR(30), @CubsWinWorldSeries, 103) AS UK_dmyyyy,
	CONVERT(NVARCHAR(30), @CubsWinWorldSeries, 101) AS US_mdyyyy;

-- DefaultForm	         UK_dmy	    US_mdy	    UK_dmyyyy	US_mdyyyy
-- Nov  3 2016  12:30AM	 03/11/16	11/03/16	03/11/2016	11/03/2016

DECLARE
	@Python3ReleaseDate DATETIME2(3) = '2008-12-03 19:45:00.033';

SELECT
	-- Fill in the function call and format parameter
	FORMAT(@Python3ReleaseDate, 'd', 'en-US') AS US_d,
	FORMAT(@Python3ReleaseDate, 'd', 'de-DE') AS DE_d,
	-- Fill in the locale for Japan
	FORMAT(@Python3ReleaseDate, 'd', 'jp-JP') AS JP_d,
	FORMAT(@Python3ReleaseDate, 'd', 'zh-cn') AS CN_d;

-- US_d	        DE_d	    JP_d	    CN_d
-- 12/3/2008	03.12.2008	12/03/2008	2008/12/3

DECLARE
	@Python3ReleaseDate DATETIME2(3) = '2008-12-03 19:45:00.033';

SELECT
	-- Fill in the format parameter
	FORMAT(@Python3ReleaseDate, 'D', 'en-US') AS US_D,
	FORMAT(@Python3ReleaseDate, 'D', 'de-DE') AS DE_D,
	-- Fill in the locale for Indonesia
	FORMAT(@Python3ReleaseDate, 'D', 'id-ID') AS ID_D,
	FORMAT(@Python3ReleaseDate, 'D', 'zh-cn') AS CN_D;

-- US_D	                        DE_D	                    ID_D	                CN_D
-- Wednesday, December 3, 2008	Mittwoch, 3. Dezember 2008	Rabu, 03 Desember 2008	2008年12月3日

DECLARE
	@Python3ReleaseDate DATETIME2(3) = '2008-12-03 19:45:00.033';

SELECT
	-- 20081203
	FORMAT(@Python3ReleaseDate, 'yyyyMMdd') AS F1,
	-- 2008-12-03
	FORMAT(@Python3ReleaseDate, 'yyyy-MM-dd') AS F2,
	-- Dec 03+2008 (the + is just a "+" character)
	FORMAT(@Python3ReleaseDate, 'MMM dd+yyyy') AS F3,
	-- 12 08 03 (month, two-digit year, day)
	FORMAT(@Python3ReleaseDate, 'MM yy dd') AS F4,
	-- 03 Dec 07:45 2008.00
    -- (day, hour, minute, year, ".", second)
	FORMAT(@Python3ReleaseDate, 'dd HH:mm yyyy.ss') AS F5;

-- F1	    F2	        F3	         F4	        F5
-- 20081203	2008-12-03	Dec 03+2008	 12 08 03	03 19:45 2008.00


-- Calendar Table
-- Find Tuesdays in December for calendar years 2008-2010
SELECT
	c.Date
FROM dbo.Calendar c
WHERE
	c.MonthName = 'December'
	AND c.DayName = 'Tuesday'
	AND c.CalendarYear BETWEEN 2008 AND 2010
ORDER BY
	c.Date;

-- Find fiscal week 29 of fiscal year 2019
SELECT
	c.Date
FROM dbo.Calendar c
WHERE
    -- Instead of month, use the fiscal week
	c.FiscalWeekOfYear = 29
    -- Instead of calendar year, use fiscal year
	AND c.FiscalYear = 2019
ORDER BY
	c.Date ASC;

-- Type 3 Incidents on FY2019's 3rd quarter
SELECT
	ir.IncidentDate,
	c.FiscalDayOfYear,
	c.FiscalWeekOfYear
FROM dbo.IncidentRollup ir
	INNER JOIN dbo.Calendar c
		ON ir.IncidentDate = c.Date
WHERE
    -- Incident type 3
	ir.IncidentTypeID = 3
    -- Fiscal year 2019
	AND c.FiscalYear = 2019
    -- Fiscal quarter 3
	AND c.FiscalQuarter = 3;


-- Type 4 Incidents on FY2019's 3rd quarter after week 30
SELECT
	ir.IncidentDate,
	c.FiscalDayOfYear,
	c.FiscalWeekOfYear
FROM dbo.IncidentRollup ir
	INNER JOIN dbo.Calendar c
		ON ir.IncidentDate = c.Date
WHERE
    -- Incident type 4
	ir.IncidentTypeID = 4
    -- Fiscal year 2019
	AND c.FiscalYear = 2019
    -- Beyond fiscal week of year 30
	AND c.FiscalWeekOfYear > 30
    -- Only return weekends
	AND c.IsWeekend = 1;