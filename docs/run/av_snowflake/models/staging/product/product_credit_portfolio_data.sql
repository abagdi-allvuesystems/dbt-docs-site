
  create or replace   view AV_EDM.AV_STAGING.product_credit_portfolio_data
  
  
  
  
  as (
    WITH jul_24 AS (
    SELECT * FROM AV_EDM.AV_SOURCE.credit_aum_2024_07_11
)
SELECT '2024-07-11'::TIMESTAMP_TZ AS as_of_date
    ,UPPER(app_server_name) AS server_name
    ,client_type AS client_type
    ,portfolio_id AS portfolio_id
    ,portfolio_name AS portfolio_name
    ,portfolio_abbrev_name AS portfolio_abbrev_name
    ,portfolio_type AS portfolio_type
    ,NULLIF(MVRC,'NULL')::NUMERIC AS MVRC
    ,NULLIF(PARRC,'NULL')::NUMERIC AS PARRC
    ,CASE WHEN UPPER(PORTFOLIO_NAME) LIKE '%TEST%' OR UPPER(PORTFOLIO_NAME) like '%DEMO%' THEN 'true' ELSE 'false' END::BOOLEAN AS portfolio_flagged_as_test
FROM jul_24
  );

