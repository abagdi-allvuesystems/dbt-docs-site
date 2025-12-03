
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select page_id
from AV_EDM.AV.confluence_page_versions
where page_id is null



  
  
      
    ) dbt_internal_test