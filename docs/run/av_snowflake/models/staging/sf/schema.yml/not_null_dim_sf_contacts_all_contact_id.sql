
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select contact_id
from AV_EDM.AV_STAGING.dim_sf_contacts_all
where contact_id is null



  
  
      
    ) dbt_internal_test