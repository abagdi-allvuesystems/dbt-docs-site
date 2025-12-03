
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    contract_id as unique_field,
    count(*) as n_records

from AV_EDM.AV_STAGING.dim_sf_contract_msa
where contract_id is not null
group by contract_id
having count(*) > 1



  
  
      
    ) dbt_internal_test