
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    opportunity_id as unique_field,
    count(*) as n_records

from AV_EDM.AV_STAGING.stg_sf_opportunity
where opportunity_id is not null
group by opportunity_id
having count(*) > 1



  
  
      
    ) dbt_internal_test