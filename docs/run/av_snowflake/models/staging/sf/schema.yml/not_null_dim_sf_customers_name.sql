
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select name
from AV_EDM.AV_STAGING.dim_sf_customers
where name is null



  
  
      
    ) dbt_internal_test