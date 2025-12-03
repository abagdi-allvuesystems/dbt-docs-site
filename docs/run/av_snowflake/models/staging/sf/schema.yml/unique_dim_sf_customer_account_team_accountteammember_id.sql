
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    accountteammember_id as unique_field,
    count(*) as n_records

from AV_EDM.AV_STAGING.dim_sf_customer_account_team
where accountteammember_id is not null
group by accountteammember_id
having count(*) > 1



  
  
      
    ) dbt_internal_test