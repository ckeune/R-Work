

getCiros <- rbind(getCiros, query_exec("
                                       SELECT  'Chromecast' as orgCampaign, 
                                       COUNT(DISTINCT CASE WHEN advertiser CONTAINS 'Android 2' then id2 else 'a' end) as Android,
                                       COUNT(DISTINCT CASE WHEN buy CONTAINS 'Chrome' then id2 else 'a' end) as Chrome,
                                       COUNT(DISTINCT CASE WHEN buy CONTAINS 'Baldwin' then id2 else 'a' end) as Baldwin,
                                       COUNT(DISTINCT CASE WHEN buy CONTAINS 'Chromebook' then id2 else 'a' end) as Chromebook,
                                       COUNT(DISTINCT CASE WHEN buy CONTAINS 'Year' then id2 else 'a' end) as YIS,
                                       COUNT(DISTINCT CASE WHEN buy CONTAINS 'GSA' then id2 else 'a' end) as GSA,
                                       COUNT(DISTINCT CASE WHEN buy CONTAINS 'Chromecast' then id2 else 'a' end) as Chromecast,
                                       COUNT(DISTINCT CASE WHEN buy CONTAINS 'Cloud' then id2 else 'a' end) as Cloud,
                                       COUNT(DISTINCT CASE WHEN buy CONTAINS 'YouTube' then id2 else 'a' end) as YouTube,
                                       From (
                                       
                                       select  id2 , buy, advertiser
                                       From 
                                       (
                                       select 
                                       user_id as id2, buy, advertiser
                                       FROM
                                       TABLE_DATE_RANGE(dt.impression_5295_, TIMESTAMP('2014-10-01'), TIMESTAMP('2014-12-31'))
                                       WHERE  country = 'United States'
                                       AND length(user_id) > 10
                                       
                                       
                                       AND advertiser contains(' NA')
                                       group each by  id2 ,buy, advertiser
                                       ) as tb1  
                                       
                                       INNER JOIN EACH
                                       (
                                       select  user_id
                                       From 
                                       (
                                       select 
                                       user_id
                                       FROM
                                       TABLE_DATE_RANGE(dt.impression_5295_, TIMESTAMP('2014-10-01'), TIMESTAMP('2014-12-31'))
                                       WHERE  
                                       advertiser_id CONTAINS  
                                       AND length(user_id) > 10         
                                       group each by  user_id 
                                       )) as tb2 ON tb1.id2 = tb2.user_id )
                                       
                                       " 
                                       , project="371216794594"))





selectSQL <- "SELECT  '" 
firstSQL  <- "' as orgCampaign, 
COUNT(DISTINCT CASE WHEN advertiser_id = 2679689 then id2 else 'a' end) as Nexus,
COUNT(DISTINCT CASE WHEN advertiser_id = 2845482 then id2 else 'a' end) as Chrome,
COUNT(DISTINCT CASE WHEN advertiser_id = 4375533 then id2 else 'a' end) as Chromecast,
COUNT(DISTINCT CASE WHEN advertiser_id = 4532898 then id2 else 'a' end) as Android,
COUNT(DISTINCT CASE WHEN advertiser_id = 2832855 then id2 else 'a' end) as YouTube,
COUNT(DISTINCT CASE WHEN advertiser_id = 3446964 then id2 else 'a' end) as Chromebooks,  
COUNT(DISTINCT CASE WHEN advertiser_id = 2832855 then id2 else 'a' end) as Maps
From (
select 
user_id as id2, advertiser_id, advertiser
FROM
TABLE_DATE_RANGE(dt.impression_5295_, TIMESTAMP('2014-10-01'), TIMESTAMP('2014-12-31'))
WHERE  
advertiser_id =    2679689
or advertiser_id = 2845482
or advertiser_id = 4375533
or advertiser_id = 4532898
or advertiser_id = 2832855
or advertiser_id = 3446964
or advertiser_id = 2832855 
AND length(user_id) > 10  
group each by  id2 ,advertiser_id, advertiser
) as tb1  

INNER JOIN EACH
(
select  user_id
From 
(
select 
user_id
FROM
TABLE_DATE_RANGE(dt.impression_5295_, TIMESTAMP('2014-10-01'), TIMESTAMP('2014-12-31'))
WHERE  
advertiser_id =  "


secondSQL <- " AND length(user_id) > 10         group each by  user_id  )) as tb2 ON tb1.id2 = tb2.user_id "





n <- nrow(EMEACAMPS)
for (i in 1:n){
  #print(i)
  orgCamp <- (EMEACAMPS[i,3])
  runSQL <- paste(selectSQL, orgCamp, firstSQL, orgCamp, secondSQL)
  
  
  EMEAtestRun <- rbind(EMEAtestRun, query_exec( runSQL , project="371216794594"))
}






SELECT  '' as orgCampaign, 
COUNT(DISTINCT CASE WHEN advertiser = 2679689 then id2 else 'a' end) as Nexus,
COUNT(DISTINCT CASE WHEN advertiser = 2845482  CONTAINS 'Chrome' then id2 else 'a' end) as Chrome,
COUNT(DISTINCT CASE WHEN advertiser = 4375533  CONTAINS 'Baldwin' then id2 else 'a' end) as Chromecast,
COUNT(DISTINCT CASE WHEN advertiser = 4532898 CONTAINS 'Chromebook' then id2 else 'a' end) as Android,
COUNT(DISTINCT CASE WHEN advertiser = 2832855 CONTAINS 'Year' then id2 else 'a' end) as YouTube,
COUNT(DISTINCT CASE WHEN advertiser = 3446964 CONTAINS 'GSA' then id2 else 'a' end) as Chromebooks,  
COUNT(DISTINCT CASE WHEN advertiser = 2832855 CONTAINS 'YouTube' then id2 else 'a' end) as YouTube,
From (
  
  
  
  
  query_exec( "  select  id2 , buy, advertiser
              From 
              (
              select 
              user_id as id2, buy, advertiser
              FROM
              TABLE_DATE_RANGE(dt.impression_5295_, TIMESTAMP('2014-10-01'), TIMESTAMP('2014-12-31'))
              WHERE  
              advertiser = '2679689'
              or advertiser = '2845482'
              or advertiser = '4375533'
              or advertiser = '4532898'
              or advertiser = '2832855'
              or advertiser = '3446964'
              or advertiser = '2832855' 
              AND length(user_id) > 10  
              group each by  id2 ,buy, advertiser
              ) as tb1  
              
              INNER JOIN EACH
              (
              select  user_id
              From 
              (
              select 
              user_id
              FROM
              TABLE_DATE_RANGE(dt.impression_5295_, TIMESTAMP('2014-10-01'), TIMESTAMP('2014-12-31'))
              WHERE  
              advertiser_id =  1234324
              AND length(user_id) > 10         
              group each by  user_id 
              )) as tb2 ON tb1.id2 = tb2.user_id  "
, project="371216794594")