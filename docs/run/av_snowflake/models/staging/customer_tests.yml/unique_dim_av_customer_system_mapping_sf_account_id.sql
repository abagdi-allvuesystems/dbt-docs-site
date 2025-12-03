
    select
      count(*) as failures,
      count(*) >0 as should_warn,
      count(*) >1000 as should_error
    from (
      
    
  
    
    

select
    sf_account_id as unique_field,
    count(*) as n_records

from AV_EDM.AV_STAGING.dim_av_customer_system_mapping
where sf_account_id is not null
group by sf_account_id
having count(*) > 1



  
  
      
    ) dbt_internal_test