
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select survey_response_id
from AV_EDM.AV_STAGING.dim_sf_nps_surveys
where survey_response_id is null



  
  
      
    ) dbt_internal_test