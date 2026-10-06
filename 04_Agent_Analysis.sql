--- 04_Agent_Analysis.sql

-- 1. Resolved tickets and average resolution time per Agent
SELECT 
    a.AgentName,
    a.Team,
    COUNT(i.InteractionID) AS TicketsHandled,
    AVG(i.ResolutionTime_Minutes) AS AvgResolutionMinutes,
    AVG(i.CSAT_Score) AS AvgCSAT
FROM Agents a
JOIN Interactions i ON a.AgentID = i.AgentID
WHERE i.Status = 'Resolved' AND i.ResolutionTime_Minutes > 0
GROUP BY a.AgentName, a.Team
ORDER BY TicketsHandled DESC;
GO