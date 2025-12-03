
    
    

select
    contact_id as unique_field,
    count(*) as n_records

from AV_EDM.AV_STAGING.dim_sf_contacts_all
where contact_id is not null
group by contact_id
having count(*) > 1


