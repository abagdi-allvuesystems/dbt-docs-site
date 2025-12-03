
  
    

create or replace transient table AV_EDM.AV_CORE.fact_customer_risk_projection
    
    
    
    as (WITH cust AS (
    SELECT * FROM AV_EDM.AV_CORE.customer
), dim_sf_customers AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_customers
), cust_timeline AS (
    SELECT * FROM AV_EDM.AV_CORE.customer_timeline
), current_year_forecast AS (
    SELECT * FROM AV_EDM.AV_STAGING.dimh_sf_account__current_year_risk_forecast
), next_year_forecast AS (
    SELECT * FROM AV_EDM.AV_STAGING.dimh_sf_account__next_year_risk_forecast
), date_dim AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_date where date >= '5/1/2024' and date <= CURRENT_TIMESTAMP()
), cust_monthly AS (
    select distinct date_dim.first_date_of_month
        ,date_dim.last_date_of_month
        ,cust.sf_account_id
    from date_dim FULL OUTER JOIN cust on 1=1
)
select cm.first_date_of_month
    ,cm.last_date_of_month
    ,cm.sf_account_id
    ,COALESCE(cyf.current_year_risk_forecast_percent,dc.risk_forecast_pct_current_year) as risk_forecast_pct_current_year
    ,COALESCE(nyf.next_year_risk_forecast_percent,dc.risk_forecast_pct_next_year) as risk_forecast_pct_next_year
    ,CASE WHEN ct.last_product_rider_end_date >= cm.first_date_of_month AND cm.first_date_of_month > ct.first_msa_start_date THEN 'active'
          WHEN ct.last_product_rider_end_date < cm.first_date_of_month THEN 'terminated' 
          WHEN cm.first_date_of_month <= ct.first_msa_start_date THEN 'prospect'
          ELSE 'terminated' END::VARCHAR as status
from cust_monthly cm LEFT JOIN current_year_forecast cyf on cm.sf_account_id = cyf.account_id and cm.last_date_of_month > cyf.effective_date_start and cm.last_date_of_month <= cyf.effective_date_end
                     LEFT JOIN next_year_forecast nyf on cm.sf_account_id = nyf.account_id and cm.last_date_of_month > nyf.effective_date_start and cm.last_date_of_month <= nyf.effective_date_end
                     LEFT JOIN dim_sf_customers dc on cm.sf_account_id = dc.account_id
                     LEFT JOIN cust_timeline ct on cm.sf_account_id = ct.sf_account_id
    )
;


  