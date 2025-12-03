
    
    

with child as (
    select contact_account_id as from_field
    from AV_EDM.AV_STAGING.stg_sf_opportunity_contact_role
    where contact_account_id is not null
),

parent as (
    select id as to_field
    from AV_EDM.AV_SYSTEM.sys_sf_account
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


