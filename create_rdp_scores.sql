CREATE EXTERNAL TABLE `rdp_scores`(
  `objectid` string COMMENT 'from deserializer', 
  `statementdetails` struct<organizationid:string,financialperiodenddate:string,financialperiodfiscalyear:string,financialperiodisincomplete:string> COMMENT 'from deserializer', 
  `esgorganization` struct<names:struct<name:struct<organizationname:array<struct<organizationnormalizedname:string>>>>> COMMENT 'from deserializer', 
  `esgscores` struct<esgcombinedscore:struct<value:string,valuecalculationdate:string,valuescoregrade:string>,esgscore:struct<value:string,valuecalculationdate:string,valuescoregrade:string>,environmentpillarscore:struct<value:string,valuecalculationdate:string,valuescoregrade:string>,esgresourceusescore:struct<value:string,valuecalculationdate:string,valuescoregrade:string>,esgemissionsscore:struct<value:string,valuecalculationdate:string,valuescoregrade:string>,esginnovationscore:struct<value:string,valuecalculationdate:string,valuescoregrade:string>,socialpillarscore:struct<value:string,valuecalculationdate:string,valuescoregrade:string>,esgworkforcescore:struct<value:string,valuecalculationdate:string,valuescoregrade:string>,esghumanrightsscore:struct<value:string,valuecalculationdate:string,valuescoregrade:string>,esgcommunityscore:struct<value:string,valuecalculationdate:string,valuescoregrade:string>,esgproductresponsibilityscore:struct<value:string,valuecalculationdate:string,valuescoregrade:string>,governancepillarscore:struct<value:string,valuecalculationdate:string,valuescoregrade:string>,esgmanagementscore:struct<value:string,valuecalculationdate:string,valuescoregrade:string>,esgshareholdersscore:struct<value:string,valuecalculationdate:string,valuescoregrade:string>,esgcsrstrategyscore:struct<value:string,valuecalculationdate:string,valuescoregrade:string>,esgccontroversiesscore:struct<value:string,valuecalculationdate:string,valuescoregrade:string>> COMMENT 'from deserializer', 
  `diversityandinclusionscores` struct<controversiesscore:struct<value:string,valuecalculationdate:string>,diversityscore:struct<value:string,valuecalculationdate:string>,inclusionscore:struct<value:string,valuecalculationdate:string>,peopledevelopmentscore:struct<value:string,valuecalculationdate:string>,score:struct<value:string,valuecalculationdate:string>> COMMENT 'from deserializer')
ROW FORMAT SERDE 
  'org.openx.data.jsonserde.JsonSerDe' 
WITH SERDEPROPERTIES ( 
  'paths'='DiversityAndInclusionScores,ESGOrganization,ESGScores,ObjectId,StatementDetails') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3:/YOUR_BUCKET/data/repo/esg/rdp_scores/'
;