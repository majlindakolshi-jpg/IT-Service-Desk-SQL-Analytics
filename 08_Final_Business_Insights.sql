-- 07_Final_Business_Insights.sql

-- 1. General Service Desk Summary KPIs
SELECT 
    COUNT(InteractionID) AS TotalTickets,
    SUM(CASE WHEN Status = 'Resolved' THEN 1 ELSE 0 END) AS ResolvedTickets,
    SUM(CASE WHEN SLA_Met = 'Yes' THEN 1 ELSE 0 END) AS SLAMetTickets,
    AVG(ResolutionTime_Minutes) AS AvgResolutionMinutes,
    AVG(CSAT_Score) AS AvgCSATScore
FROM Interactions
WHERE ResolutionTime_Minutes > 0;

-- 2. Performance Summary by Team
SELECT 
    a.Team,
    COUNT(i.InteractionID) AS TotalTickets,
    AVG(i.ResolutionTime_Minutes) AS AvgResolutionMinutes,
    AVG(i.CSAT_Score) AS AvgCSAT
FROM Agents a
JOIN Interactions i ON a.AgentID = i.AgentID
WHERE i.ResolutionTime_Minutes > 0
GROUP BY a.Team
ORDER BY TotalTickets DESC;
GO