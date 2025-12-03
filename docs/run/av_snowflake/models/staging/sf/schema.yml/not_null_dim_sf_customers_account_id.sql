
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select account_id
from AV_EDM.AV_STAGING.dim_sf_customers
where account_id is null



  
  
      
    ) dbt_internal_test