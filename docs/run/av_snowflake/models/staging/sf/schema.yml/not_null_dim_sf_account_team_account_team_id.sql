
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select account_team_id
from AV_EDM.AV_STAGING.dim_sf_account_team
where account_team_id is null



  
  
      
    ) dbt_internal_test