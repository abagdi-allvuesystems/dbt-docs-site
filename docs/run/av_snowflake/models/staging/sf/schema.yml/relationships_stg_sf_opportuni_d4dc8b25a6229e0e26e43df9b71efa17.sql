
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with child as (
    select opportunity_id as from_field
    from AV_EDM.AV_STAGING.stg_sf_opportunity_contact_mapping
    where opportunity_id is not null
),

parent as (
    select id as to_field
    from AV_EDM.AV_SYSTEM.sys_sf_opportunity
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



  
  
      
    ) dbt_internal_test