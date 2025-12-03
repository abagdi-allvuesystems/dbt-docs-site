
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select project_id
from AV_EDM.AV_CX_PS.ps_project_task
where project_id is null



  
  
      
    ) dbt_internal_test