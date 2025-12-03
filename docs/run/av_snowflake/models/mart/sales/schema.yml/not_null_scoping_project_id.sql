
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select id
from AV_EDM.AV_SALES.scoping_project
where id is null



  
  
      
    ) dbt_internal_test