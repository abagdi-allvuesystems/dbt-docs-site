-- This consideres a Salesforce Account which is currently a Prospect, not a Customer or Former Customer.
WITH sf_accounts AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_sf_account
), sf_account_region AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_account_region
)
select acct.id AS account_id
    ,name AS name
    ,CASE WHEN acct.type = 'Customer' THEN 'true' ELSE 'false' END::BOOLEAN as is_active
    ,NULL::TIMESTAMP_TZ AS date_inactive
    ,type AS account_type
    ,primary_investor_type AS primary_investor_type
    ,client_vertical AS client_vertical
    ,tam AS tam
    ,segment AS segment
    ,segmentation AS segmentation
    ,deployment_type AS deployment_type
    ,tier AS tier
    ,client_priortization AS client_priortization
    ,finance_arr AS finance_arr
    ,health_score AS health_score
    ,nps_score AS nps_score
    ,arr_by_customer_asset AS arr_by_customer_asset
    ,netsuite_id AS netsuite_id
    ,openair_id AS openair_id
    ,current_year_risk_forecast as risk_forecast_pct_current_year
    ,next_year_risk_forecast as risk_forecast_pct_next_year
    ,risk_forecast_reason as risk_forecast_reason_current
    ,acct.billingcountry as billing_country
    ,ar.region as billing_region
    ,sys_updated AS sys_updated
    ,sys_created AS sys_created
    ,raw_updated AS raw_updated
FROM sf_accounts acct LEFT JOIN sf_account_region ar ON acct.billingcountry = ar.billingcountry
WHERE acct.type in ('Prospect') and acct.name not in ('Training Test Prospect Account','Test Training Customer Account')