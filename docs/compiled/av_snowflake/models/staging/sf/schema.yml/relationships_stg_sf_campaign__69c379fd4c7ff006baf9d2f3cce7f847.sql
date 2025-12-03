
    
    

with child as (
    select contactid as from_field
    from AV_EDM.AV_STAGING.stg_sf_campaign_member
    where contactid is not null
),

parent as (
    select id as to_field
    from AV_EDM.AV_SYSTEM.sys_sf_contact
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


