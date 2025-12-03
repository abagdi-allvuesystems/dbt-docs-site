
    
    

select
    quote_id as unique_field,
    count(*) as n_records

from AV_EDM.AV_STAGING.stg_sf_quote
where quote_id is not null
group by quote_id
having count(*) > 1


