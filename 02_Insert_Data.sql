USE IT_ServiceDesk_DB;
GO

-- 1. Insert Customers
INSERT INTO Customers (CustomerID, CustomerName, CustomerSegment, Region, ServiceType, SignupDate, CustomerStatus) VALUES
('C101', 'Siemens Energy', 'Enterprise', 'Germany', 'Managed Network', '2023-01-15', 'Active'),
('C102', 'E.ON Tech', 'Enterprise', 'Germany', 'Security Operations', '2023-03-20', 'Active'),
('C103', 'Metro AG', 'SME', 'Austria', 'Service Desk', '2023-05-10', 'Active'),
('C104', 'Novartis AG', 'Enterprise', 'Switzerland', 'Managed Network', '2023-06-01', 'Active'),
('C105', 'Kosovo Energy Corp', 'Public Sector', 'Kosovo', 'Full IT Support', '2024-02-12', 'Active'),
('C106', 'Solaris Power Gmbh', 'SME', 'Germany', 'Service Desk', '2024-04-18', 'Active');

-- 2. Insert Agents
INSERT INTO Agents (AgentID, AgentName, Team, Region, HireDate, AgentStatus) VALUES
('A101', 'Alban Hoxha', 'Tier 1 Service Desk', 'Kosovo', '2022-01-10', 'Active'),
('A102', 'Elira Berisha', 'Tier 1 Service Desk', 'Kosovo', '2022-03-15', 'Active'),
('A103', 'Dren Kelmendi', 'Network & Security Ops', 'Kosovo', '2021-06-01', 'Active'),
('A104', 'Zana Gashi', 'Applications Support', 'Kosovo', '2023-02-20', 'Active'),
('A105', 'Krenar Krasniqi', 'Infrastructure Team', 'Kosovo', '2020-11-05', 'Active');

-- 3. Insert Interactions
INSERT INTO Interactions (InteractionID, CustomerID, AgentID, Channel, Category, Priority, CreatedDate, ResolvedDate, ResolutionTime_Minutes, SLA_Met, Status, CSAT_Score) VALUES
('T8001', 'C101', 'A101', 'Phone', 'Access/Security', 'High', '2026-07-01 08:00', '2026-07-01 08:45', 45, 'Yes', 'Resolved', 5),
('T8002', 'C102', 'A102', 'Email', 'Software', 'Medium', '2026-07-02 09:30', '2026-07-02 11:30', 120, 'Yes', 'Resolved', 4),
('T8003', 'C101', 'A103', 'Portal', 'Network', 'Critical', '2026-07-05 10:00', '2026-07-05 15:00', 300, 'No', 'Resolved', 3),
('T8004', 'C103', 'A101', 'Live Chat', 'Access/Security', 'Low', '2026-07-10 11:15', '2026-07-10 11:35', 20, 'Yes', 'Resolved', 5),
('T8005', 'C104', 'A102', 'Phone', 'Hardware', 'Medium', '2026-07-15 14:00', '2026-07-15 13:30', -30, 'Yes', 'Resolved', 4),
('T8006', NULL, 'A101', 'Email', 'Network', 'High', '2026-08-01 09:00', NULL, NULL, 'No', 'Pending', NULL),
('T8007', 'C102', 'A103', 'Phone', 'Network', 'High', '2026-08-10 10:30', '2026-08-10 12:00', 90, 'Yes', 'Resolved', 5),
('T8008', 'C105', 'A104', 'Live Chat', 'Software', 'Low', '2026-08-15 13:00', '2026-08-15 13:25', 25, 'Yes', 'Resolved', 5),
('T8009', 'C101', 'A101', 'Phone', 'Access/Security', 'High', '2026-07-01 08:00', '2026-07-01 08:45', 45, 'Yes', 'Resolved', 5),
('T8010', 'C106', 'A105', 'Portal', 'Hardware', 'Critical', '2026-09-01 08:30', '2026-09-01 12:30', 240, 'No', 'Resolved', 2);
GO