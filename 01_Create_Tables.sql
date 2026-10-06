CREATE DATABASE IT_ServiceDesk_DB;
GO

USE IT_ServiceDesk_DB;
GO

-- 1. Customers Table
CREATE TABLE Customers (
    CustomerID VARCHAR(10) PRIMARY KEY,
    CustomerName VARCHAR(100),
    CustomerSegment VARCHAR(50),
    Region VARCHAR(50),
    ServiceType VARCHAR(50),
    SignupDate DATE,
    CustomerStatus VARCHAR(20)
);

-- 2. Agents Table
CREATE TABLE Agents (
    AgentID VARCHAR(10) PRIMARY KEY,
    AgentName VARCHAR(100),
    Team VARCHAR(50),
    Region VARCHAR(50),
    HireDate DATE,
    AgentStatus VARCHAR(20)
);

-- 3. Interactions / Tickets Table
CREATE TABLE Interactions (
    InteractionID VARCHAR(10) PRIMARY KEY,
    CustomerID VARCHAR(10),
    AgentID VARCHAR(10),
    Channel VARCHAR(30),
    Category VARCHAR(50),
    Priority VARCHAR(20),
    CreatedDate DATETIME,
    ResolvedDate DATETIME,
    ResolutionTime_Minutes INT,
    SLA_Met VARCHAR(10),
    Status VARCHAR(20),
    CSAT_Score INT
);
GO