
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    account_team_id as unique_field,
    count(*) as n_records

from AV_EDM.AV_STAGING.dim_sf_account_team
where account_team_id is not null
group by account_team_id
having count(*) > 1



  
  
      
    ) dbt_internal_test