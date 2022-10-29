
--data was downloaded from https://www.kaggle.com/datasets/cynthiarempel/amazon-us-customer-reviews-dataset
--Using Music subset


--created a datproc cluster in gcp which has hadoop ,pig,hive





---uploaded the file to google cloud storage bucket-01/amazon-music/amazon_reviews_us_Music

---the file was copied in to hdfs by the folowing command to hdfs

hdfs dfs -cp gs://hadoop-data-bucket-01/amazon-music/amazon_reviews_us_Music.tsv /dataset
------https://stackoverflow.com/questions/54429642/how-to-copy-a-file-from-a-gcs-bucket-in-dataproc-to-hdfs-using-google-cloud

---using hive a table from created ...the table was created using the values from the tsv file.


CREATE EXTERNAL TABLE musicset 
(marketplace STRING, 
      customer_id DOUBLE, 
      review_id STRING,
      product_id STRING,
      product_parent DOUBLE,
      product_title STRING,
      product_category STRING,
      star_rating INT,
      helpful_votes INT,
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



 
 hdfs dfs -cp gs://hadoop-data-bucket-01/amazon-music/amazon_reviews_us_Music.tsv /dataset