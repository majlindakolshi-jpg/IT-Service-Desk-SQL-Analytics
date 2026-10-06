-- 05_Interaction_Analysis.sql

-- 1. Ticket distribution by Channel
SELECT 
    Channel,
    COUNT(InteractionID) AS TotalTickets
FROM Interactions
GROUP BY Channel
ORDER BY TotalTickets DESC;

-- 2. SLA Met vs Breached per Channel
SELECT 
    Channel,
    SLA_Met,
    COUNT(InteractionID) AS TicketCount
FROM Interactions
GROUP BY Channel, SLA_Met
ORDER BY Channel;
GO