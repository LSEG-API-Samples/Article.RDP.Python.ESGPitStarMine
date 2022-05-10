CREATE EXTERNAL TABLE daily_dates_with_weekends
(
    as_of_date TIMESTAMP
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe' 
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat' 
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat'
LOCATION 's3://YOUR_BUCKET/data/repo/esg/daily_dates_with_weekends/'
;