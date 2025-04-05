SELECT * 
FROM ads 
JOIN adcampaigns ON ads.id = adcampaigns.ad_id 
WHERE ads.businesscustomer_id = ? 
AND now() BETWEEN adcampaigns.date_start AND adcampaigns.date_stop;  


SELECT * 
FROM ads 
JOIN adcampaigns ON ads.id = adcampaigns.ad_id 
WHERE ads.businesscustomer_id = ? 
AND now() > adcampaigns.date_stop; 

SELECT * 
FROM ads 
JOIN adcampaigns ON ads.id = adcampaigns.ad_id 
WHERE ads.businesscustomer_id = ? 
AND now() < adcampaigns.date_start; 

 
SELECT * 
FROM ads 
JOIN adcampaigns ON ads.id = adcampaigns.ad_id 
WHERE ads.businesscustomer_id = ? 
AND adcampaigns.id IS NULL; 


INSERT INTO ads (title, adtype_id, businesscustomer_id) 
VALUES (?, ?, ?); 

 

WITH new_ad AS ( 
INSERT INTO ads (title, adtype_id, businesscustomer_id) 
VALUES (?, ?, ?) 
RETURNING id 
) 

INSERT INTO adcampaigns (ad_id, date_start, date_stop) 
SELECT id, ?, ? FROM new_ad; 

UPDATE ads 
SET title = ? 
WHERE id = ?; 


UPDATE adcampaigns 
SET date_start = ?, date_stop = ? 
WHERE id = ?; 


SELECT ads.id AS ad_id, SUM(adcampaigncategories.negotiatedprice) AS total_owed
FROM ads
JOIN adcampaigns ON ads.id = adcampaigns.ad_id
JOIN adcampaigncategories ON adcampaigns.id = adcampaigncategories.adcampaign_id
WHERE adcampaigns.date_stop < now()
AND ads.businesscustomer_id = 3
GROUP BY ads.id;


SELECT ads.id AS ad_id, SUM(adcampaigncategories.negotiatedprice) AS total_owed
FROM ads
JOIN adcampaigns ON ads.id = adcampaigns.ad_id
JOIN adcampaigncategories ON adcampaigns.id = adcampaigncategories.adcampaign_id
WHERE now() BETWEEN adcampaigns.date_start AND adcampaigns.date_stop
AND ads.businesscustomer_id = 3
GROUP BY ads.id;


SELECT SUM(adcampaigncategories.negotiatedprice) AS total_owed
FROM ads
JOIN adcampaigns ON ads.id = adcampaigns.ad_id
JOIN adcampaigncategories acc ON adcampaigns.id = adcampaigncategories.adcampaign_id
WHERE (
    adcampaigns.date_stop < now()
    OR now() BETWEEN adcampaigns.date_start AND adcampaigns.date_stop
) AND ads.businesscustomer_id = 3;
