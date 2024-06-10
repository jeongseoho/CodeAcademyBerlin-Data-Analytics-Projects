-- 9.1 Give the package name and how many times they're downloaded. Order by the 2nd column descending.
SELECT package, count(package) as downloaded_time FROM logs
GROUP BY package
ORDER BY 2 DESC;

-- 9.2 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM
SELECT package,
			   RANK() OVER (ORDER BY COUNT(package) DESC) AS package_ranking
FROM logs
GROUP BY package
HAVING time BETWEEN '09:00:00' and '11:00:00';

-- 9.3 How many records (downloads) are from China ("CN") or Japan("JP") or Singapore ("SG")?
SELECT COUNT(*) as download_count FROM logs
WHERE country IN ('CN', 'JP', 'SG');


-- 9.4 Print the countries whose downloads are more than the downloads from China ("CN")
SELECT country FROM logs
GROUP BY country
HAVING count(country) > (SELECT COUNT(country) FROM logs WHERE country = 'CN');


-- 9.5 Print the average length of the package name of all the UNIQUE packages
SELECT AVG(LENGTH(package)) AS AverageLength
FROM (SELECT DISTINCT package FROM logs);


-- 9.6 Get the package whose download count ranks 2nd (print package name and its download count).
SELECT package, package_ranking
FROM (SELECT package,
             RANK() OVER (ORDER BY COUNT(package) DESC) AS package_ranking 
			 FROM logs
			 GROUP BY package) 
WHERE package_ranking = 2;


-- 9.7 Print the name of the package whose download count is bigger than 1000.
SELECT package FROM logs
GROUP BY package
having count(package) > 100;


-- 9.8 The field "r_os" is the operating system of the users.
    -- 	Here we would like to know what main system we have (ignore version number), the relevant counts, and the proportion (in percentage).
	
REGEXP_replace

SELECT r_os, COUNT(r_os) AS 'OS_COUNT', ROUND((COUNT(r_os) * 100.0 / (SELECT COUNT(r_os) FROM logs)),2) AS 'Proportion'
FROM logs
GROUP BY r_os
ORDER BY COUNT(r_os) DESC;


