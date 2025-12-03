
  create or replace   view AV_EDM.AV_STAGING.dim_sf_customers
  
  
  
  
  as (
    -- We are only considering a Salesforce Account which has ever been a customer. Eiether still is or is now Former Custoemr
WITH sf_accounts AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_sf_account
), sf_acct_hist_type AS (
    SELECT * 
    FROM AV_EDM.AV_SYSTEM.sys_sf_accounthistory
    WHERE FIELD = 'Type'
), latest_customer_change AS (
    SELECT account_id,MAX(CREATED_DATE) as latest_change_date
    FROM sf_acct_hist_type
    WHERE new_value = 'Customer' OR old_value = 'Customer'
    GROUP BY account_id
), sf_account_region AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_account_region
)
select acct.id AS account_id
    ,name AS name
    ,CASE WHEN acct.type = 'Customer' THEN 'true' ELSE 'false' END::BOOLEAN as is_active
    ,CASE WHEN acct.type != 'Customer' THEN cust_change.latest_change_date ELSE NULL END::TIMESTAMP_TZ AS date_inactive
    ,type AS account_type
    ,primary_investor_type AS primary_investor_type
    ,client_vertical as client_vertical
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
FROM sf_accounts acct LEFT JOIN latest_customer_change cust_change ON acct.id = cust_change.account_id
                      LEFT JOIN sf_account_region ar ON acct.billingcountry = ar.billingcountry
WHERE (acct.type in ('Customer','Former Customer') OR cust_change.account_id IS NOT NULL) and acct.name not in ('Training Test Prospect Account','Test Training Customer Account')
  );

