
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select project_task_id
from AV_EDM.AV_CX_PS.fact_ps_project_task_metrics_daily
where project_task_id is null



  
  
      
    ) dbt_internal_test