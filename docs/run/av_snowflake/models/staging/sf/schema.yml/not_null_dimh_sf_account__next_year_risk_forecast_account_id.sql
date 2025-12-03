
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select account_id
from AV_EDM.AV_STAGING.dimh_sf_account__next_year_risk_forecast
where account_id is null



  
  
      
    ) dbt_internal_test