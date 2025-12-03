
  
    

create or replace transient table AV_EDM.AV_CORE.fact_customer_status
    
    
    
    as (WITH cust AS (
    SELECT * FROM AV_EDM.AV_CORE.customer
), dim_sf_customers AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_customers
), cust_timeline AS (
    SELECT * FROM AV_EDM.AV_CORE.customer_timeline
), date_dim AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_date where date >= '1/1/2023' and date <= CURRENT_TIMESTAMP()
), cust_monthly AS (
    select distinct date_dim.first_date_of_month
        ,date_dim.last_date_of_month
        ,cust.sf_account_id
    from date_dim FULL OUTER JOIN cust on 1=1
)
select cm.first_date_of_month as date
        ,cm.sf_account_id
    ,CASE WHEN ct.last_product_rider_end_date >= cm.first_date_of_month AND cm.first_date_of_month > ct.first_msa_start_date THEN 'active'
          WHEN ct.last_product_rider_end_date < cm.first_date_of_month THEN 'terminated' 
          WHEN cm.first_date_of_month <= ct.first_msa_start_date THEN 'prospect'
          ELSE 'terminated' END::VARCHAR as status
    ,CASE WHEN ct.last_product_rider_end_date >= cm.first_date_of_month AND cm.first_date_of_month > ct.first_msa_start_date 
                THEN true
          ELSE false
          END::BOOLEAN as is_active
    ,CASE WHEN ct.last_product_rider_end_date >= cm.first_date_of_month AND cm.first_date_of_month > ct.first_msa_start_date 
                THEN 1
          ELSE 0
          END::INT as count_active
    ,CASE WHEN ct.first_msa_start_date >= cm.first_date_of_month AND ct.first_msa_start_date <= cm.last_date_of_month 
                THEN true ELSE false 
          END::BOOLEAN as is_new_customer
    ,CASE WHEN ct.first_msa_start_date >= cm.first_date_of_month AND ct.first_msa_start_date <= cm.last_date_of_month 
                THEN 1 ELSE 0 
          END::INT as count_new_customer
    ,CASE WHEN ct.last_product_rider_end_date >= cm.first_date_of_month AND ct.last_product_rider_end_date <= cm.last_date_of_month 
                THEN true 
          ELSE false 
          END::BOOLEAN as is_leaving_customer
    ,CASE WHEN ct.last_product_rider_end_date >= cm.first_date_of_month AND ct.last_product_rider_end_date <= cm.last_date_of_month 
                THEN 1 
          ELSE 0
          END::INT as count_leaving_customer
from cust_monthly cm LEFT JOIN dim_sf_customers dc on cm.sf_account_id = dc.account_id
                     LEFT JOIN cust_timeline ct on cm.sf_account_id = ct.sf_account_id
where (last_product_rider_end_date is not null and last_product_rider_end_date > '1/1/2023') and ct.name not in ('Test Training Customer Account')
    )
;


  