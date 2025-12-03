
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select campaign_member_id
from AV_EDM.AV_STAGING.stg_sf_campaign_member
where campaign_member_id is null



  
  
      
    ) dbt_internal_test