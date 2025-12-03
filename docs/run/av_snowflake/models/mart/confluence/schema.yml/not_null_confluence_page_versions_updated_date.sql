
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select updated_date
from AV_EDM.AV.confluence_page_versions
where updated_date is null



  
  
      
    ) dbt_internal_test