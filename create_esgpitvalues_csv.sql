CREATE EXTERNAL TABLE esgpitvalues_csv
(
    organizationid BIGINT, 
    financialperiodid BIGINT, 
    periodenddate STRING, 
    periodtype STRING, 
    year BIGINT, 
    ispartial BOOLEAN, 
    itemcode STRING, 
    esgvalue STRING, 
    currency STRING, 
    esgstringvalue STRING, 
    changetype STRING, 
    entrydate STRING, 
    effectivetodate STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES
(
    'separatorChar' = ',',
    'quoteChar'     = '"'
 ) 
LOCATION 's3://YOUR_BUCKET/data/repo/esg_pit/EsgPITValues/'
TBLPROPERTIES ("skip.header.line.count"="1")
;