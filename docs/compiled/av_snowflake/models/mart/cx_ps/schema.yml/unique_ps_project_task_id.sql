
    
    

select
    id as unique_field,
    count(*) as n_records

from AV_EDM.AV_CX_PS.ps_project_task
where id is not null
group by id
having count(*) > 1


