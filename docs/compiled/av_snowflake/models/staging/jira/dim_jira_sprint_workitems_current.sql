WITH dim_jira_workitems_sprints as (
    select issue_id
        ,issue_sprints
     from AV_EDM.AV_STAGING.dim_jira_workitems
)
select issue_id
    ,sprints.value:id as sprint_id
from dim_jira_workitems_sprints,
lateral flatten( INPUT => issue_sprints ) as sprints