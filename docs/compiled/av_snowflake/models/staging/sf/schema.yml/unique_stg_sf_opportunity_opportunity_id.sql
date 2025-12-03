
    
    

select
    opportunity_id as unique_field,
    count(*) as n_records

from AV_EDM.AV_STAGING.stg_sf_opportunity
where opportunity_id is not null
group by opportunity_id
having count(*) > 1


