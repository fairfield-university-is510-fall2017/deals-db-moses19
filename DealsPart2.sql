USE deals;

SELECT *
FROM Companies
WHERE CompanyName like "%Inc."
ORDER BY CompanyID;

/* Select Deal Parts with dollar value */
SELECT DealName,PartNumber,DollarValue
FROM Deals,DealParts
WHERE Deals.DealID = DealParts.DealID;

/* Select Deal Parts with dollar value using the Join Command */
SELECT DealName,PartNumber,DollarValue
FROM Deals Join DealParts ON (Deals.DealID = DealParts.DealID);

/* Create a view  that matches companies to deals */
#CREATE VIEW CompanyDeals AS
SELECT DealName,RoleCode,CompanyName
FROM Companies
	JOIN Players ON (Companies.CompanyID = Players.CompanyID)
	JOIN Deals ON (Players.DealID = Deals.DealID)
ORDER BY DealName;
#A test on company deals
SELECT * FROM CompanyDeals;

#Creating DealValues with DealID, total dollar value aand number of parts for each deallocate
CREATE VIEW DealValues AS 
SELECT deals.DealID, SUM(DollarValue) AS TotalDollarValue , Count(PartNumber) AS CountPartNumber
FROM deals
    JOIN DealParts ON (Deals.DealID = DealParts.DealID)
Group By Deals.DealID
ORDER BY Deals.DealID;

#Select * From DealValues;

#10
Create VIEW DealSummary AS
Select deals.DealID, DealName , Count(PlayerID) , TotalDollarValue, CountPartNumber
FROM Deals
	Join DealValues ON (Deals.DealID = DealValues.DealID)
	Join Players ON (Deals.DealID = Players.PlayerID)
Group BY Deals.DealID;
#A test on dealSummary
select * from dealsummary;


#11
CREATE VIEW DealsByType AS 
Select DealTypes.TypeCode , count( Deals.DealID) As NumDeals , Sum(DealParts.DollarValue) AS TotDollarValue
FROM DealTypes
	Left Join Deals on (DealTypes.DealID = Deals.DealID)
    Join DealParts on (DealParts.DealID= Deals.DealID)
Group BY DealTypes.TypeCode;

# A Test on DealsByType
Select * FROM DealsByType;

#12 

SELECT DealID,CompanyName, Companies.CompanyID,RoleCodes.RoleCode
FROM Players 
	Join Companies ON (Players.CompanyID = Companies.CompanyID)
	Join RoleCodes  ON (Players.RoleCode = RoleCodes.RoleCode)
Order BY RoleSortOrder;


#13

Select FirmID , `Name` AS FirmName ,Count(Players.DealID) AS NumDeals ,SUM(TotalDollarValue) AS TotValue
From Firms
	Left Join playersupports Using (FirmID)
    Left Join players Using (PlayerID)
    Left Join DealValues Using (DealID)
Group By FirmID, `Name`;    


