--table creation from hdfs file
CREATE EXTERNAL TABLE musicset 
(marketplace STRING, 
      customer_id DOUBLE, 
      review_id STRING,
      product_id STRING,
      product_parent DOUBLE,
      product_title STRING,
      product_category STRING,
      helpful_votes INT,
	  star_rating INT,
      total_votes INT,
      vine STRING,  
      verified_purchase STRING,
      review_headline STRING,
      review_body STRING,
      review_date DATE
      )
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE 
LOCATION '/dataset'
TBLPROPERTIES("skip.header.line.count"="1");


--test if table is created
SELECT * FROM musicset LIMIT 10;

--creating temp table for cleaning
ALTER TABLE musicset RENAME TO table_to_dump;


--removal of null values and the removal of unwanted character from the body 
CREATE TABLE musicset AS
SELECT regexp_replace(review_id,"[$&+,:;=?@#|<>.^*()%!-]"," "),
    regexp_replace(customer_id,"[$&+,:;=?@#|<>.^*()%!-]"," "),
    regexp_replace(review_body,"[$&+,:;=?@#|<>.^*()%!-]"," "),
    regexp_replace(review_headline,"[$&+,:;=?@#|<>.^*()%!-]"," "),
    regexp_replace(helpful_votes,"[$&+,:;=?@#|<>.^*()%!-]"," ")
FROM table_to_dump 
WHERE customer_id IS NOT NULL 
    and product_id IS NOT NULL 
    and review_body IS NOT NULL
    and review_headline IS NOT NULL
    and helpful_votes IS NOT NULL;


--creation of table with top ham accounts and reviews
CREATE TABLE tophamratings AS
SELECT regexp_replace(`_c0`,"[$&+,:;=?@#|<>.^*()%!-]"," "),
    regexp_replace(`_c1`,"[$&+,:;=?@#|<>.^*()%!-]"," "),
    regexp_replace(`_c2`,"[$&+,:;=?@#|<>.^*()%!-]"," "),
    regexp_replace(`_c3`,"[$&+,:;=?@#|<>.^*()%!-]"," "),
    regexp_replace(`_c4`,"[$&+,:;=?@#|<>.^*()%!-]"," ")
FROM MUSICSET WHERE 
`_c1`='5 073695E7' OR 
`_c1`='3 8214553E7' OR
`_c1`='5 1184997E7' OR
`_c1`='1 8116317E7' OR
`_c1`='2 3267387E7' OR
`_c1`='5 0345651E7' OR
`_c1`='1 4539589E7' OR
`_c1`='1 5725862E7' OR
`_c1`='1 9380211E7' OR
`_c1`='2 0018062E7';


--table creation from hdfs file
CREATE EXTERNAL TABLE hamset 
(     customer_id STRING,
      review_body STRING
      )
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE 
LOCATION '/ham'
TBLPROPERTIES("skip.header.line.count"="1");

INSERT OVERWRITE TABLE hamset
SELECT `_c1` AS customer_id ,
`_c2` AS review_body FROM tophamratings;



--creation of table with top spam accounts and reviews
CREATE TABLE topspamratings AS
SELECT regexp_replace(`_c0`,"[$&+,:;=?@#|<>.^*()%!-]"," "),
    regexp_replace(`_c1`,"[$&+,:;=?@#|<>.^*()%!-]"," "),
    regexp_replace(`_c2`,"[$&+,:;=?@#|<>.^*()%!-]"," "),
    regexp_replace(`_c3`,"[$&+,:;=?@#|<>.^*()%!-]"," "),
    regexp_replace(`_c4`,"[$&+,:;=?@#|<>.^*()%!-]"," ")
FROM MUSICSET WHERE 
`_c1`='5 073695E7' OR 
`_c1`='3 8214553E7' OR
`_c1`='5 1184997E7' OR
`_c1`='1 8116317E7' OR
`_c1`='2 3267387E7' OR
`_c1`='5 0345651E7' OR
`_c1`='1 5725862E7' OR
`_c1`='2 0018062E7' OR
`_c1`='3 7455882E7' OR
`_c1`='4 7924228E7';

--table creation from hdfs file
CREATE EXTERNAL TABLE spamset 
(     customer_id STRING,
      review_body STRING
      )
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE 
LOCATION '/spam'
TBLPROPERTIES("skip.header.line.count"="1");

INSERT OVERWRITE TABLE spamset
SELECT `_c1` AS customer_id ,
`_c2` AS review_body FROM topspamratings;


