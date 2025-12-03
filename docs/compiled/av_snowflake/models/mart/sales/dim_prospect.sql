WITH map AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_av_customer_system_mapping
), sf_prosp AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_prospect
), oa_cust AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_customer
)
SELECT av_customer_id as customer_id
    ,sf_prosp.name as name
    ,sf_prosp.account_type as account_type
    ,sf_prosp.client_vertical as client_vertical
    ,sf_prosp.primary_investor_type as primary_investor_type
    ,sf_prosp.segment as segment
    ,sf_prosp.segmentation as segmentation
    ,sf_prosp.deployment_type as deployment_type
    ,sf_prosp.tier AS tier
    ,sf_prosp.client_priortization AS client_priortization
    ,sf_prosp.finance_arr AS finance_arr
    ,sf_prosp.arr_by_customer_asset
    ,sf_prosp.health_score AS health_score
    ,sf_prosp.nps_score AS nps_score
    ,sf_prosp.risk_forecast_pct_current_year AS risk_forecast_pct_current_year
    ,sf_prosp.risk_forecast_pct_next_year AS risk_forecast_pct_next_year
    ,sf_prosp.risk_forecast_reason_current AS risk_forecast_reason_current
    ,sf_prosp.billing_country as billing_country
    ,sf_prosp.billing_region as billing_region
    ,sf_prosp.account_id AS sf_account_id
    ,oac.id AS oa_customer_id
    ,oac.is_priority_client AS is_priority_client
    ,oac.delivery_mgr_user_name AS client_delivery_manager
FROM sf_prosp LEFT JOIN map ON sf_prosp.account_id = map.sf_account_id
             LEFT JOIN oa_cust oac ON sf_prosp.account_id = oac.sf_account_id