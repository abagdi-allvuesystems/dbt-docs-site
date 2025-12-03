
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select is_primary_contact
from AV_EDM.AV_STAGING.stg_sf_opportunity_contact_role
where is_primary_contact is null



  
  
      
    ) dbt_internal_test