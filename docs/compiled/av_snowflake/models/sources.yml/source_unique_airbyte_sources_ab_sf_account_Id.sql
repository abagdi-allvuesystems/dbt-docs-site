
    
    

select
    Id as unique_field,
    count(*) as n_records

from AV_EDM.AV_SOURCE.ab_sf_account
where Id is not null
group by Id
having count(*) > 1


