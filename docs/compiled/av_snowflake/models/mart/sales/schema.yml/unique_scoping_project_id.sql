
    
    

select
    id as unique_field,
    count(*) as n_records

from AV_EDM.AV_SALES.scoping_project
where id is not null
group by id
having count(*) > 1


