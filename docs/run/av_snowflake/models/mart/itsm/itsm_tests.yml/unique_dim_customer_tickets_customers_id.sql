
    select
      count(*) as failures,
      count(*) >0 as should_warn,
      count(*) >1000 as should_error
    from (
      
    
  
    
    

select
    id as unique_field,
    count(*) as n_records

from AV_EDM.AV_ITSM.dim_customer_tickets_customers
where id is not null
group by id
having count(*) > 1



  
  
      
    ) dbt_internal_test