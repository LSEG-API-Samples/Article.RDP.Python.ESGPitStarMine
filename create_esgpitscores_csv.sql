CREATE EXTERNAL TABLE esgpitscores_csv
(
    organizationid BIGINT, 
    financialperiodid BIGINT, 
    periodenddate STRING, 
    periodtype STRING, 
    year BIGINT, 
    itemcode STRING, 
    esganalyticvaluescore DOUBLE, 
    esganalyticvaluescoregrade STRING, 
    effectivefromdate STRING, 
    effectivetodate STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES
(
    'separatorChar' = ',',
    'quoteChar'     = '"'
) 
LOCATION 's3://YOUR_BUCKET/data/repo/esg_pit/EsgPITScores/'
TBLPROPERTIES ('skip.header.line.count'='1')