
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select contract_record_type
from AV_EDM.AV_STAGING.dim_sf_contract_msa
where contract_record_type is null



  
  
      
    ) dbt_internal_test