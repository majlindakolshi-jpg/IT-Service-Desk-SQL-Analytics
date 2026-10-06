
---- 03_Customer_Analysis.sql

-- 1. Total interactions per Customer and Region
SELECT 
    c.CustomerName,
    c.Region,
    c.CustomerSegment,
    COUNT(i.InteractionID) AS TotalInteractions
FROM Customers c
LEFT JOIN Interactions i ON c.CustomerID = i.CustomerID
GROUP BY c.CustomerName, c.Region, c.CustomerSegment
ORDER BY TotalInteractions DESC;

-- 2. Customers with Critical and High priority tickets
SELECT 
    c.CustomerName,
    COUNT(i.InteractionID) AS HighPriorityTickets
FROM Customers c
JOIN Interactions i ON c.CustomerID = i.CustomerID
WHERE i.Priority IN ('Critical', 'High')
GROUP BY c.CustomerName
ORDER BY HighPriorityTickets DESC;
GO