
  
    

create or replace transient table AV_EDM.AV_ENG_ANALYTICS.release_versions
    
    
    
    as (with dim_project_versions AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_project_versions
)
select id as version_id
    ,id as jira_version_id
    ,project_id as jira_project_id
    ,name as name
    ,overdue as is_currently_overdue
    ,archived as is_archived
    ,released as is_released
    ,start_date as start_date
    ,release_date as release_date
    ,description as description
from dim_project_versions
    )
;


  