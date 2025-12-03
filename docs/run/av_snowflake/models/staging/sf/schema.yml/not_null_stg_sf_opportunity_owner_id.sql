
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select owner_id
from AV_EDM.AV_STAGING.stg_sf_opportunity
where owner_id is null



  
  
      
    ) dbt_internal_test