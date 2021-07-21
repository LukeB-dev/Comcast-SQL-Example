-- BUSINESS PROBLEM:
-- Leadership would like to identify trends among customers that unsubscribed from our telecom services. 

--Information on the datasets
-- Data are spread across four tables inside the Customer Churn database of a fictional Telecom company in California.
-- The dataset belongs to IBM and is publicly available on Kaggle and the IBM Analytics Community page
-- Link:https://www.kaggle.com/ylchang/telco-customer-churn-1113




-- Creating a summary VIEW to utilize in Tableau later.
CREATE VIEW churn_summary_view AS 

-- SELECTING relevant data for view
SELECT
	DISTINCT(tc.CustomerID), tc.Country, tc.State, tc.City, tc.[Zip Code], 

-- Splitting lat/long column for easier geomapping in Tableau
	SUBSTRING(tc.[Lat Long],1,9) as Latitude, 
	SUBSTRING(tc.[Lat Long],12,11) as Longitude,

-- SELECTING data from JOINED tables
	dem.Gender, dem.Age, dem.Married, dem.[Number of Dependents], 
	ser.Offer, ser.[Internet Service], ser.[Internet Type], ser.[Avg Monthly GB Download], ser.[Unlimited Data], 
	ser.[Phone Service], ser.[Tenure in Months], ser.[Monthly Charge], ser.[Total Charges], ser.[Total Extra Data Charges], ser.[Total Long Distance Charges], ser.[Total Revenue], tc.[Churn Reason]

-- JOINING and ALIASING relevant tables
FROM
	Telco_Churn as tc
INNER JOIN dbo.Demographics as dem
	ON tc.CustomerID = dem.[Customer ID]
INNER JOIN dbo.Services as ser
	ON tc.CustomerID = ser.[Customer ID]
INNER JOIN dbo.Population_Zip as zip
	ON tc.[Zip Code] = zip.[Zip Code]

-- Sorting data (For debugging before creating VIEW. Cannot execute ORDER BY while creating a VIEW.)
ORDER BY [Zip Code] ASC, ser.[Total Revenue] DESC
