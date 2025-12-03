
  create or replace   view AV_EDM.AV_STAGING.dim_jira_scrum_boards
  
  
  
  
  as (
    WITH jira_boards as (
    select * from AV_EDM.AV_SYSTEM.jira_boards
)
select id
    ,name
    ,projectid as project_id
    ,projectkey as project_key
    ,raw_updated
from jira_boards
where type = 'scrum'
  );

