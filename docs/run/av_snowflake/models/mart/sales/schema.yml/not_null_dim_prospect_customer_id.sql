
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select customer_id
from AV_EDM.AV_SALES.dim_prospect
where customer_id is null



  
  
      
    ) dbt_internal_test