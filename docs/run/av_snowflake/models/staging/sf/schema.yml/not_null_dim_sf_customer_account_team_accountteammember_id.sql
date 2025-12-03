
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select accountteammember_id
from AV_EDM.AV_STAGING.dim_sf_customer_account_team
where accountteammember_id is null



  
  
      
    ) dbt_internal_test