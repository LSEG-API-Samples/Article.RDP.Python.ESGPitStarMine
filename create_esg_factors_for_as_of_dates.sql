CREATE TABLE esg_factors_for_as_of_dates
WITH (format = 'Parquet', parquet_compression = 'SNAPPY', external_location ='s3:/YOUR_BUCKET/data/repo/esg/esg_factors_for_as_of_dates')
AS
-- For each AsOfDate, figure out the most recent ESG Factors
-- Assuming a 1 year lag, that means ESG factors at least 1 year prior to AsOfDate
-- But also but in a 1 year lookback prior since not all companies will report on that each 1-year lag date
WITH universe
AS
(
	SELECT orgpermid,
	MIN(as_of_date) AS first_date,
	MAX(as_of_date) AS last_date
	FROM "YOUR_SCHEMA"."TABLE_WITH_YOUR_SIGNAL_BEFORE_ESG"
	GROUP BY orgpermid
),
esg_universe_dates
AS
(
	SELECT u.orgpermid, d.as_of_date
	FROM universe u
	INNER JOIN "YOUR_SCHEMA"."daily_dates_with_weekends" d
	ON d.as_of_date BETWEEN u.first_date AND u.last_date
),
most_recent_date
AS
(
  SELECT d.as_of_date, d.orgpermid, MAX(e.financialperiodenddate) AS last_date
  FROM esg_universe_dates d
  LEFT OUTER JOIN "YOUR_SCHEMA"."rdp_esg_all_factors" e
  ON d.orgpermid = CAST(e.organizationid  AS BIGINT)
  AND e.financialperiodenddate > DATE_ADD('year',-2, d.as_of_date) 
  AND e.financialperiodenddate <= DATE_ADD('year',-1, d.as_of_date) 
  GROUP BY d.as_of_date, d.orgpermid
)
SELECT d.as_of_date, d.orgpermid, e.totalco2equivalentsemissionstorevenues, e.vocemissionstorevenues, e.totalwastetorevenues, e.totalhazardouswastetorevenues, e.waterpollutantemissionstorevenues, e.injuriestomillionhours, e.voluntaryturnoverofemployees, e.totalrenewableenergytoenergyuse, e.womenmanagers, e.averagetraininghours, e.customersatisfaction, e.esgmanagementscore, e.esgshareholdersscore 
FROM most_recent_date d
LEFT OUTER JOIN "YOUR_SCHEMA"."rdp_esg_all_factors" e
ON d.orgpermid = CAST(e.organizationid AS BIGINT)
AND e.financialperiodenddate = d.last_date