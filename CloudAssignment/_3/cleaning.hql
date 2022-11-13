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
