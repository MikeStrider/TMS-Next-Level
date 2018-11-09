
UPDATE companyinfo SET invoicefooter = 'fweffwe' WHERE compid = 20045;


SELECT * FROM Billing

SELECT * FROM Truck002

SELECT * FROM DispatchTable

UPDATE Billing SET tcposted = 'y' WHERE ordernumber = 2

UPDATE Billing Set tcposted = 'n', paid = 'n', dpposted ='n' WHERE ordernumber = 2014

UPDATE DispatchTable SET driver = 'fff', truck = 'hhhh' WHERE ordernumber = 4019

SELECT * FROM Truck002 WHERE name = '003' ORDER BY lastdateandtime ASC

SELECT id, pickupdateandtime, GETDATE() AS CurrentTime, (DATEDIFF(day,GETDATE(),pickupdateandtime)) AS Days, (DATEDIFF(hour,GETDATE(),pickupdateandtime)) AS Hours, (DATEDIFF(minute,GETDATE(),pickupdateandtime)) AS Mins FROM orders ORDER BY id DESC

SELECT id, pickupdateandtime, GETDATE() AS CurrentTime, ((DATEDIFF(day,GETDATE(),pickupdateandtime)) - 1) AS Days , convert(char(8),dateadd(s,datediff(s,GETDATE(),pickupdateandtime),'1900-1-1'),8) AS 'Hours & Mins' FROM orders ORDER BY id DESC

SELECT id, pickupdateandtime, GETDATE() AS CurrentTime,  FROM orders

SELECT id, pickupdateandtime, 
    GETDATE() AS CurrentTime, 
    (DATEDIFF(day,GETDATE(),pickupdateandtime)) - 1 AS Days, 
    (DATEDIFF(hour,GETDATE(),pickupdateandtime) % 24) AS Hours, 
    (DATEDIFF(minute,GETDATE(),pickupdateandtime) % 60) AS Mins FROM orders ORDER BY id DESC

SELECT id, pickupdateandtime, 
    GETDATE() AS CurrentTime, 
    (DATEDIFF(day,GETDATE(),pickupdateandtime)) (DATEDIFF(hour,GETDATE(),pickupdateandtime) % 24) (DATEDIFF(minute,GETDATE(),pickupdateandtime) % 60) AS Mins FROM orders ORDER BY id DESC

	select
    mf.id,
    mf.pickupdateandtime,
    mf.CurrentTime,
    --The divisions in the following lines simply
    --truncate since all the numbers are integers
    --but that works in our favour here
    (mf.MinutesFull/(60*24)) as Days, 
    (mf.MinutesFull/60) % 24 as Hours,
    mf.MinutesFull % 60 as Minutes
from ( select
        id,
        pickupdateandtime,
        getdate() as CurrentTime,
        datediff(minute, getdate(), pickupdateandtime) as MinutesFull
    from orders
    ) mf


		select id, pickupdateandtime, getdate(),

    (datediff(minute, getdate(), pickupdateandtime) / (60*24)) as Days, 
    (datediff(minute, getdate(), pickupdateandtime) / 60) % 24 as Hours,
    datediff(minute, getdate(), pickupdateandtime) % 60 as Minutes
from orders





	SELECT        DispatchTable.ordernumber, DispatchTable.truck, DispatchTable.driver, DispatchTable.actualpickup, DispatchTable.actualdropoff, orders.pickupdateandtime, orders.dropoffdateandtime, TruckLatest.lastposition, 
                         TruckLatest.lastdateandtime, 


   (datediff(minute, getdate(), pickupdateandtime) / (60*24)) as Days, 
    (datediff(minute, getdate(), pickupdateandtime) / 60) % 24 as Hours,
    datediff(minute, getdate(), pickupdateandtime) % 60 as Mins,

	    (datediff(minute, getdate(), dropoffdateandtime) / (60*24)) as Days2, 
    (datediff(minute, getdate(), dropoffdateandtime) / 60) % 24 as Hours2,
    datediff(minute, getdate(), dropoffdateandtime) % 60 as Mins2


FROM            DispatchTable INNER JOIN
                         orders ON DispatchTable.ordernumber = orders.id INNER JOIN
                             (SELECT        name, lastposition, lastdateandtime
                               FROM            Truck002 AS Truck1
                               WHERE        (lastdateandtime =
                                                             (SELECT        MAX(lastdateandtime) AS Expr1
                                                               FROM            Truck002 AS Truck2
                                                               WHERE        (name = Truck1.name)))) AS TruckLatest ON DispatchTable.truck = TruckLatest.name
WHERE        (orders.status = 'onRoute')