
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with child as (
    select product_id as from_field
    from AV_EDM.AV_STAGING.stg_sf_opportunity_product
    where product_id is not null
),

parent as (
    select id as to_field
    from AV_EDM.AV_SYSTEM.sys_sf_product2
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



  
  
      
    ) dbt_internal_test