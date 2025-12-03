
    
    

select
    task_id as unique_field,
    count(*) as n_records

from AV_EDM.AV_STAGING.stg_sf_task
where task_id is not null
group by task_id
having count(*) > 1


