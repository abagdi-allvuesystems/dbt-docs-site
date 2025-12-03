
  
    

create or replace transient table AV_EDM.AV_ENG_ANALYTICS.workitem_fix_versions
    
    
    
    as (WITH dim_wi AS (
    SELECT issue_id,fix_versions FROM AV_EDM.AV_STAGING.dim_jira_workitems
)
select dim_wi.issue_id::INT as jira_issue_id
    ,versions.value:id::INT as jira_version_id
from dim_wi,
    LATERAL FLATTEN(input => fix_versions) as versions
    )
;


  