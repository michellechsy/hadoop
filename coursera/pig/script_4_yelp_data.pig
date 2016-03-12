-- *******   PIG LATIN SCRIPT for Yelp Assignmet ******************

-- 0. get function defined for CSV loader

register /usr/lib/pig/piggybank.jar;
-- wrong path: register /home/cloudera/incubator-datafu/datafu-pig/build/libs/datafu-pig-incubating-1.3.0-SNAPSHOT.jar;
register /usr/lib/pig/datafu-1.1.0-cdh5.5.0.jar   -- check your jar version in the env
define CSVLoader org.apache.pig.piggybank.storage.CSVLoader();

-- 1 load data

Y      = LOAD '/usr/lib/hue/apps/search/examples/collections/solr_configs_yelp_demo/index_data.csv' USING CSVLoader() AS(business_id:chararray,cool,date,funny,id,stars:int,text:chararray,type,useful:int,user_id,name,full_address,latitude,longitude,neighborhoods,open,review_count,state);
Y_good = FILTER Y BY (useful is not null and stars is not null);

--2 Find max useful
Y_all = GROUP Y_good ALL;
Umax  = FOREACH Y_all GENERATE MAX(Y_good.useful);
-- DUMP Umax

-- this shows max useful rating of 28! ...

-- 3 Now limit useful field to be <=5 and then get wtd average

Y_rate  = FOREACH Y_good GENERATE business_id,stars,(useful>5 ? 5:useful) as useful_clipped;
Y_rate2 = FOREACH Y_rate GENERATE $0..,(double) stars*(useful_clipped/5) as wtd_stars;

-- 4 Rank businesses

Y_g = GROUP Y_rate2 BY business_id;
Y_m = FOREACH Y_g
      GENERATE group as business_idgroup,COUNT(Y_rate2.stars) as num_ratings ,
          AVG(Y_rate2.stars) as avg_stars,
          AVG(Y_rate2.useful_clipped) as avg_useful,
          AVG(Y_rate2.wtd_stars) as avg_wtdstars;

-- Question 2         
Y_m2 = FILTER Y_m BY (num_ratings > 1);
DESCRIBE Y_m2;
Y_m2_all = GROUP Y_m2 ALL;
Y_m2_avg = FOREACH Y_m2_all GENERATE AVG(Y_m2.avg_wtdstars) as avg_result;
DUMP Y_m2_avg;

-- Question 3
Y_m3 = JOIN Y_rate2 BY busness_id, Y_m2 BY business_idgroup;
Y_m3_group = GROUP Y_m3 ALL;
Y_m3_avgwtd = FOREACH Y_m3_group GENERATE AVG(Y_m3.wtd_stars)



