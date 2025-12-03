
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select task_id
from AV_EDM.AV_STAGING.stg_sf_task
where task_id is null



  
  
      
    ) dbt_internal_test