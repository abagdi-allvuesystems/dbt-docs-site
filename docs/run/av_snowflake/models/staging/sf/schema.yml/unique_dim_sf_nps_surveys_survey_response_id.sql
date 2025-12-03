
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    survey_response_id as unique_field,
    count(*) as n_records

from AV_EDM.AV_STAGING.dim_sf_nps_surveys
where survey_response_id is not null
group by survey_response_id
having count(*) > 1



  
  
      
    ) dbt_internal_test