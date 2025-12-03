
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select quote_id
from AV_EDM.AV_STAGING.stg_sf_quote
where quote_id is null



  
  
      
    ) dbt_internal_test