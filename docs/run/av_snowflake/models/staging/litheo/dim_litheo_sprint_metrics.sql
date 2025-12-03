
  create or replace   view AV_EDM.AV_STAGING.dim_litheo_sprint_metrics
  
  
  
  
  as (
    WITH lit_ea_sprint_metrics as (
    select * from AV_EDM.AV_SYSTEM.litheo_ea_sprint_metrics
)
select sprintid as jira_sprint_id
        ,velocity as velocity
        ,pointsplanned as points_planned
        ,completedpointsplanned as completed_points_planned
        ,churn_totalpoints as churn_total_points
        ,churn as churn_pct
        ,performancetocommit as performance_to_commit_pct
        ,sprintscopecompletionrate as sprint_scope_completion_rate
        ,sprintsuccess as sprint_success
        ,teamcommentary as team_commentary
        ,updatedate as sys_updated
        ,raw_updated
from lit_ea_sprint_metrics
  );

