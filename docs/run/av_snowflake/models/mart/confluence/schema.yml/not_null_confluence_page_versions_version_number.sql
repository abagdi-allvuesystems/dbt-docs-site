
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select version_number
from AV_EDM.AV.confluence_page_versions
where version_number is null



  
  
      
    ) dbt_internal_test