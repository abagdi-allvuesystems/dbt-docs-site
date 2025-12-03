
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select customer_id
from AV_EDM.AV_ITSM.dim_customer_tickets_customers
where customer_id is null



  
  
      
    ) dbt_internal_test