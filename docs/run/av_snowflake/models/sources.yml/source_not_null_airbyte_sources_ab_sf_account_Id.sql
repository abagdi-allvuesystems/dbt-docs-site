
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select Id
from AV_EDM.AV_SOURCE.ab_sf_account
where Id is null



  
  
      
    ) dbt_internal_test