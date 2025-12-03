
  
    

create or replace transient table AV_EDM.AV_CORE.fact_customer_quarter
    
    
    
    as (WITH dim_date_qtr as (
    select distinct first_date_of_quarter,last_date_of_quarter
    from AV_EDM.AV_STAGING.dim_date
), cust_timeline as (
    select *
    from AV_EDM.AV_CORE.customer_timeline
), fact_details as (
    select dim_date_qtr.first_date_of_quarter as date
        ,dim_date_qtr.first_date_of_quarter as first_date_of_quarter
        ,dim_date_qtr.last_date_of_quarter as last_date_of_quarter
        ,cust.sf_account_id as sf_account_id
        ,cust.first_msa_start_date as first_msa_start_date
        ,cust.last_product_rider_end_date as last_product_rider_end_date
        ,CASE WHEN cust_begin.sf_account_id is not null THEN TRUE else FALSE END as is_new_customer
        ,CASE WHEN cust_leaving.sf_account_id is not null THEN TRUE else FALSE END as is_expiring_customer
    from dim_date_qtr JOIN cust_timeline cust ON cust.first_msa_start_date <= dim_date_qtr.last_date_of_quarter 
                                            AND dim_date_qtr.first_date_of_quarter < cust.last_product_rider_end_date 
                    LEFT JOIN cust_timeline cust_begin ON cust_begin.first_msa_start_date >= dim_date_qtr.first_date_of_quarter 
                                                            AND cust_begin.first_msa_start_date <= dim_date_qtr.last_date_of_quarter
                                                            AND cust_begin.sf_account_id = cust.sf_account_id
                    LEFT JOIN cust_timeline cust_leaving ON cust_leaving.last_product_rider_end_date >= dim_date_qtr.first_date_of_quarter 
                                            AND cust_leaving.last_product_rider_end_date <= dim_date_qtr.last_date_of_quarter
                                            AND cust_leaving.sf_account_id = cust.sf_account_id
)
SELECT date as date
    ,sf_account_id as sf_account_id
    ,is_new_customer as is_new_customer
    ,is_expiring_customer as is_expiring_customer
    ,CASE WHEN is_new_customer = false and is_expiring_customer = false then 'EXISTING'
          WHEN is_new_customer = true then 'NEW'
          WHEN is_expiring_customer = true THEN 'EXPIRING'
     END as status_flag
from fact_details
    )
;


  