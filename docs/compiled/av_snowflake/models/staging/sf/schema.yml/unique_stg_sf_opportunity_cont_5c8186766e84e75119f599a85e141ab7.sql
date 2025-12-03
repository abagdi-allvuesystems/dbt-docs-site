
    
    

select
    opportunity_contact_map_id as unique_field,
    count(*) as n_records

from AV_EDM.AV_STAGING.stg_sf_opportunity_contact_mapping
where opportunity_contact_map_id is not null
group by opportunity_contact_map_id
having count(*) > 1


