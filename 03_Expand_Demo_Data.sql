/*
============================================================
IT Service Desk - Safe Data Expansion Script
Database: IT_ServiceDesk_DB
Purpose:
  1) Correct two known data-quality issues in the original sample.
  2) Insert 1,000 additional realistic Interaction rows.
  3) Be safe to re-run: generated InteractionIDs are protected
     with NOT EXISTS, so the 1,000 rows are not duplicated.
============================================================

IMPORTANT:
- Run this script against the SAME SQL Server database used by Power BI.
- Do NOT re-run the original 10-ticket INSERT script after this.
- No table/column is added, removed, renamed, or retyped.
*/

USE IT_ServiceDesk_DB;
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRANSACTION;

    /* ---------------------------------------------------------
       STEP 1 - Correct the two known issues in the original data
       --------------------------------------------------------- */

    -- T8005 had ResolvedDate before CreatedDate and -30 minutes.
    UPDATE Interactions
    SET
        ResolvedDate = '2026-07-15 14:30',
        ResolutionTime_Minutes = 30
    WHERE InteractionID = 'T8005'
      AND ResolutionTime_Minutes = -30;

    -- T8009 duplicated T8001. Keep the ticket ID, but make it a
    -- legitimate, distinct interaction so the portfolio data is cleaner.
    UPDATE Interactions
    SET
        CustomerID = 'C106',
        AgentID = 'A105',
        Channel = 'Email',
        Category = 'Software',
        Priority = 'Medium',
        CreatedDate = '2026-07-21 09:00',
        ResolvedDate = '2026-07-21 10:30',
        ResolutionTime_Minutes = 90,
        SLA_Met = 'Yes',
        Status = 'Resolved',
        CSAT_Score = 4
    WHERE InteractionID = 'T8009'
      AND CreatedDate = '2026-07-01 08:00'
      AND CustomerID = 'C101';

    /* ---------------------------------------------------------
       STEP 2 - Insert 1,000 new Interaction rows
       IDs: T10001 ... T11000

       Design goals:
       - 6 existing customers
       - 5 existing agents
       - 4 existing channels
       - 4 existing categories
       - realistic priority mix
       - 90% resolved / 10% pending
       - SLA performance around the mid/high 70% range
       - CSAT concentrated around 4-5
       - dates distributed from 2026-01-01 through 2026-09-30
       --------------------------------------------------------- */

    ;WITH N AS
    (
        SELECT TOP (1000)
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
        FROM sys.all_objects AS a
        CROSS JOIN sys.all_objects AS b
    ),
    D AS
    (
        SELECT
            n,

            /* Existing Customers: weighted distribution */
            CASE
                WHEN ((n * 17) % 100) + 1 <= 20 THEN 'C101'
                WHEN ((n * 17) % 100) + 1 <= 37 THEN 'C102'
                WHEN ((n * 17) % 100) + 1 <= 52 THEN 'C103'
                WHEN ((n * 17) % 100) + 1 <= 67 THEN 'C104'
                WHEN ((n * 17) % 100) + 1 <= 85 THEN 'C105'
                ELSE 'C106'
            END AS CustomerID,

            /* Existing Agents: weighted workload */
            CASE
                WHEN ((n * 11) % 100) + 1 <= 28 THEN 'A101'
                WHEN ((n * 11) % 100) + 1 <= 50 THEN 'A102'
                WHEN ((n * 11) % 100) + 1 <= 72 THEN 'A103'
                WHEN ((n * 11) % 100) + 1 <= 90 THEN 'A104'
                ELSE 'A105'
            END AS AgentID,

            /* Channels */
            CASE
                WHEN ((n * 23) % 100) + 1 <= 35 THEN 'Phone'
                WHEN ((n * 23) % 100) + 1 <= 63 THEN 'Email'
                WHEN ((n * 23) % 100) + 1 <= 85 THEN 'Portal'
                ELSE 'Live Chat'
            END AS Channel,

            /* Categories */
            CASE
                WHEN ((n * 29) % 100) + 1 <= 35 THEN 'Network'
                WHEN ((n * 29) % 100) + 1 <= 60 THEN 'Software'
                WHEN ((n * 29) % 100) + 1 <= 80 THEN 'Access/Security'
                ELSE 'Hardware'
            END AS Category,

            /* Priority */
            CASE
                WHEN ((n * 31) % 100) + 1 <= 8 THEN 'Critical'
                WHEN ((n * 31) % 100) + 1 <= 33 THEN 'High'
                WHEN ((n * 31) % 100) + 1 <= 78 THEN 'Medium'
                ELSE 'Low'
            END AS Priority,

            /* Status: 90% Resolved, 10% Pending */
            CASE
                WHEN ((n * 37) % 100) + 1 <= 90 THEN 'Resolved'
                ELSE 'Pending'
            END AS Status,

            /* CreatedDate: Jan 1 2026 -> Sep 30 2026,
               business-like working hours */
            DATEADD(
                MINUTE,
                ((n * 37) % 60),
                DATEADD(
                    HOUR,
                    7 + ((n * 13) % 10),
                    DATEADD(
                        DAY,
                        (n - 1) % 273,
                        CAST('2026-01-01' AS datetime)
                    )
                )
            ) AS CreatedDate
        FROM N
    ),
    R AS
    (
        SELECT
            *,

            /* SLA target */
            CASE
                WHEN Status = 'Pending' THEN 'No'
                WHEN Priority = 'Critical'
                     AND ((n * 7) % 100) < 65 THEN 'Yes'
                WHEN Priority = 'High'
                     AND ((n * 7) % 100) < 78 THEN 'Yes'
                WHEN Priority = 'Medium'
                     AND ((n * 7) % 100) < 88 THEN 'Yes'
                WHEN Priority = 'Low'
                     AND ((n * 7) % 100) < 94 THEN 'Yes'
                ELSE 'No'
            END AS SLA_Met_Calc,

            /* Base resolution time */
            CASE
                WHEN Status = 'Pending' THEN NULL
                WHEN Priority = 'Critical'
                    THEN 120 + ((n * 43) % 181)
                WHEN Priority = 'High'
                    THEN 45 + ((n * 43) % 106)
                WHEN Priority = 'Medium'
                    THEN 20 + ((n * 43) % 81)
                ELSE
                    10 + ((n * 43) % 61)
            END AS BaseResolution
        FROM D
    ),
    F AS
    (
        SELECT
            *,
            CASE
                WHEN Status = 'Pending' THEN NULL
                WHEN SLA_Met_Calc = 'No' AND Priority = 'Critical'
                    THEN BaseResolution + 120
                WHEN SLA_Met_Calc = 'No' AND Priority = 'High'
                    THEN BaseResolution + 75
                WHEN SLA_Met_Calc = 'No' AND Priority = 'Medium'
                    THEN BaseResolution + 45
                WHEN SLA_Met_Calc = 'No' AND Priority = 'Low'
                    THEN BaseResolution + 30
                ELSE BaseResolution
            END AS FinalResolution
        FROM R
    )
    INSERT INTO Interactions
    (
        InteractionID,
        CustomerID,
        AgentID,
        Channel,
        Category,
        Priority,
        CreatedDate,
        ResolvedDate,
        ResolutionTime_Minutes,
        SLA_Met,
        Status,
        CSAT_Score
    )
    SELECT
        'T' + CAST(10000 + n AS varchar(10)) AS InteractionID,
        CustomerID,
        AgentID,
        Channel,
        Category,
        Priority,
        CreatedDate,

        CASE
            WHEN Status = 'Resolved'
                THEN DATEADD(MINUTE, FinalResolution, CreatedDate)
            ELSE NULL
        END AS ResolvedDate,

        FinalResolution AS ResolutionTime_Minutes,
        SLA_Met_Calc AS SLA_Met,
        Status,

        CASE
            WHEN Status = 'Pending' THEN NULL

            WHEN SLA_Met_Calc = 'Yes' THEN
                CASE
                    WHEN ((n * 19) % 100) + 1 <= 50 THEN 5
                    WHEN ((n * 19) % 100) + 1 <= 90 THEN 4
                    WHEN ((n * 19) % 100) + 1 <= 99 THEN 3
                    ELSE 2
                END

            ELSE
                CASE
                    WHEN ((n * 19) % 100) + 1 <= 35 THEN 4
                    WHEN ((n * 19) % 100) + 1 <= 80 THEN 3
                    WHEN ((n * 19) % 100) + 1 <= 95 THEN 2
                    ELSE 1
                END
        END AS CSAT_Score

    FROM F
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM Interactions AS I
        WHERE I.InteractionID = 'T' + CAST(10000 + F.n AS varchar(10))
    );

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    THROW;
END CATCH;
GO

/* ---------------------------------------------------------
   STEP 3 - Verification
   --------------------------------------------------------- */

SELECT
    COUNT(*) AS TotalInteractions
FROM Interactions;
GO

SELECT
    COUNT(*) AS NewGeneratedTickets
FROM Interactions
WHERE TRY_CONVERT(int, SUBSTRING(InteractionID, 2, 20))
      BETWEEN 10001 AND 11000;
GO

/* Check for impossible negative resolution times */
SELECT
    COUNT(*) AS NegativeResolutionRows
FROM Interactions
WHERE ResolutionTime_Minutes < 0;
GO

/* Check for impossible date order */
SELECT
    COUNT(*) AS InvalidDateOrderRows
FROM Interactions
WHERE ResolvedDate IS NOT NULL
  AND ResolvedDate < CreatedDate;
GO

/* Check duplicate Interaction IDs */
SELECT
    InteractionID,
    COUNT(*) AS DuplicateCount
FROM Interactions
GROUP BY InteractionID
HAVING COUNT(*) > 1;
GO

/* Useful portfolio sanity check */
SELECT
    Status,
    COUNT(*) AS TicketCount
FROM Interactions
GROUP BY Status
ORDER BY TicketCount DESC;
GO

SELECT
    Channel,
    COUNT(*) AS TicketCount
FROM Interactions
GROUP BY Channel
ORDER BY TicketCount DESC;
GO