with jira_workitems_sprints as (
    select * 
    from AV_EDM.AV_STAGING.dim_jira_workitems_sprints
    where SPRINT_IDS != ''
)
select sprints.value::INT as sprint_id
    ,issue_id::INT as issue_id
    ,effective_date_start
    ,effective_date_end
from jira_workitems_sprints,
    LATERAL flatten( INPUT=>SPLIT(SPRINT_IDS,',')) sprints