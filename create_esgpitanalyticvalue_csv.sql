CREATE EXTERNAL TABLE esgpitanalyticvalue_csv
(
  organizationid BIGINT, 
  financialperiodid BIGINT, 
  periodenddate STRING, 
  periodtype STRING, 
  year BIGINT, 
  itemcode STRING, 
  esganalyticvalue DOUBLE, 
  currency STRING, 
  effectivefromdate STRING, 
  effectivetodate STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES
(
    'separatorChar' = ',',
    'quoteChar'     = '"'
) 
LOCATION 's3://204384-starmine-research/data/repo/esg_pit/EsgPITAnalyticValue/'
TBLPROPERTIES ('skip.header.line.count'='1')
;