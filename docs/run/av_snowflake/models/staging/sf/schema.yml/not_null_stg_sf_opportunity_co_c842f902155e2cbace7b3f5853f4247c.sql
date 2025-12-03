
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select opportunity_contact_role_id
from AV_EDM.AV_STAGING.stg_sf_opportunity_contact_role
where opportunity_contact_role_id is null



  
  
      
    ) dbt_internal_test