
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select date
from AV_EDM.AV_CX_PS.fact_ps_project_task_backlog
where date is null



  
  
      
    ) dbt_internal_test