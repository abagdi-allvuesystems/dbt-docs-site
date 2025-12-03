
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select space_id
from AV_EDM.AV.confluence_spaces
where space_id is null



  
  
      
    ) dbt_internal_test