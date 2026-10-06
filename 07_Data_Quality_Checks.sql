--- 06_Data_Quality_Checks.sql
-- 1. Check for tickets with missing Customer ID
SELECT * 
FROM Interactions 
WHERE CustomerID IS NULL;

-- 2. Check for negative or invalid resolution times
SELECT * 
FROM Interactions 
WHERE ResolutionTime_Minutes <= 0;

-- 3. Check for duplicate ticket entries
SELECT CustomerID, AgentID, Channel, CreatedDate, COUNT(*) AS DuplicateCount
FROM Interactions
GROUP BY CustomerID, AgentID, Channel, CreatedDate
HAVING COUNT(*) > 1;
GO
-- 4. Fix missing CustomerID for ticket T8006
UPDATE Interactions
SET CustomerID = 'C101'
WHERE InteractionID = 'T8006';

-- 5. Fix negative resolution time for ticket T8005
UPDATE Interactions
SET ResolutionTime_Minutes = 30
WHERE InteractionID = 'T8005';
GO