
    
    

select
    id as unique_field,
    count(*) as n_records

from AV_EDM.AV_SYSTEM.sys_sf_accounthistory
where id is not null
group by id
having count(*) > 1


