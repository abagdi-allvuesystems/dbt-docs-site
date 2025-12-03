
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    Id as unique_field,
    count(*) as n_records

from AV_EDM.AV_SOURCE.ab_sf_account
where Id is not null
group by Id
having count(*) > 1



  
  
      
    ) dbt_internal_test