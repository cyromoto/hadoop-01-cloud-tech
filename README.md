# hadoop-01-cloud-tech
Cloud Test Assignment


--data was downloaded from https://www.kaggle.com/datasets/cynthiarempel/amazon-us-customer-reviews-dataset
--Using Music subset


--created a datproc cluster in gcp which has hadoop ,pig,hive





---uploaded the file to google cloud storage bucket-01/amazon-music/amazon_reviews_us_Music

---the file was copied in to hdfs by the folowing command to hdfs

hdfs dfs -cp gs://hadoop-data-bucket-01/amazon-music/amazon_reviews_us_Music.tsv /dataset


