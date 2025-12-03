
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    project_phase_id as unique_field,
    count(*) as n_records

from AV_EDM.AV_CX_PS.ps_project_phase
where project_phase_id is not null
group by project_phase_id
having count(*) > 1



  
  
      
    ) dbt_internal_test