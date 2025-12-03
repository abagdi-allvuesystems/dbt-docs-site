
    
    

select
    event_id as unique_field,
    count(*) as n_records

from AV_EDM.AV_STAGING.stg_sf_event
where event_id is not null
group by event_id
having count(*) > 1


