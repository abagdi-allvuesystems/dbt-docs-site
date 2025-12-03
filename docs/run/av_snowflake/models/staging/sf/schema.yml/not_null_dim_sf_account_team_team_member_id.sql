
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select team_member_id
from AV_EDM.AV_STAGING.dim_sf_account_team
where team_member_id is null



  
  
      
    ) dbt_internal_test