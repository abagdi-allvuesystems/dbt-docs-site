
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select id
from AV_EDM.AV_SYSTEM.sys_sf_event
where id is null



  
  
      
    ) dbt_internal_test