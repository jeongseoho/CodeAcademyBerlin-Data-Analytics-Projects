-- 7.1 Who received a 1.5kg package?
    -- The result is "Al Gore's Head".
SELECT Client.Name FROM Client
JOIN Package
ON Client.AccountNumber = Package.Recipient
WHERE Package.Weight = 1.5

	
-- 7.2 What is the total weight of all the packages that he sent?
SELECT sum(Package.Weight) FROM Package
JOIN Client
ON Client.AccountNumber = Package.Sender
WHERE Package.Sender = 2
