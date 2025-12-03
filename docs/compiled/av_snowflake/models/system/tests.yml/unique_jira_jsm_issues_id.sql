
    
    

select
    id as unique_field,
    count(*) as n_records

from AV_EDM.AV_SYSTEM.jira_jsm_issues
where id is not null
group by id
having count(*) > 1


