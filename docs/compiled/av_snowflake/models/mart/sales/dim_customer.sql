WITH map AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_av_customer_system_mapping
), sf_cust AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_customers
), oa_cust AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_customer
)
SELECT av_customer_id as customer_id
    ,sf_cust.name as name
    ,sf_cust.account_type as account_type
    ,sf_cust.client_vertical as client_vertical
    ,sf_cust.primary_investor_type as primary_investor_type
    ,sf_cust.segment as segment
    ,sf_cust.segmentation as segmentation
    ,sf_cust.deployment_type as deployment_type
    ,sf_cust.tier AS tier
    ,sf_cust.client_priortization AS client_priortization
    ,sf_cust.finance_arr AS finance_arr
    ,sf_cust.arr_by_customer_asset
    ,sf_cust.health_score AS health_score
    ,sf_cust.nps_score AS nps_score
    ,sf_cust.risk_forecast_pct_current_year AS risk_forecast_pct_current_year
    ,sf_cust.risk_forecast_pct_next_year AS risk_forecast_pct_next_year
    ,sf_cust.risk_forecast_reason_current AS risk_forecast_reason_current
    ,sf_cust.billing_country as billing_country
    ,sf_cust.billing_region as billing_region
    ,sf_cust.account_id AS sf_account_id
    ,oac.id AS oa_customer_id
    ,oac.is_priority_client AS is_priority_client
    ,oac.delivery_mgr_user_name AS client_delivery_manager
FROM sf_cust LEFT JOIN map ON sf_cust.account_id = map.sf_account_id
             LEFT JOIN oa_cust oac ON sf_cust.account_id = oac.sf_account_id