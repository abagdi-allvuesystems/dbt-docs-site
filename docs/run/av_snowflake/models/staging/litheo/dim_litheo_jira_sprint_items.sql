
  create or replace   view AV_EDM.AV_STAGING.dim_litheo_jira_sprint_items
  
  
  
  
  as (
    WITH lit_jira_sprint_items as (
    select * from AV_EDM.AV_SYSTEM.litheo_jira_sprint_items
)
select sprintid as jira_sprint_id
        ,issueid as jira_issue_id
        ,issuekey as jira_issue_key
        ,issuesummary as jira_issue_summary
        ,issuetypename as jira_issue_type_name
        ,issuepriority as jira_issue_priority_name
        ,sprintitmcompstatus as jira_sprint_itm_comp_status
        ,issuestorypoints_current::FLOAT as jira_issue_story_points_current
        ,issuestorypoints_initial::FLOAT as jira_issue_story_points_initial
        ,issuekeyaddedduringsprint as jira_issue_key_added_during_sprint
        ,parentissueid as jira_issue_parent_issue_id
        ,parentissuekey as jira_issue_parent_issue_key
        ,parentissuetypename as jira_issue_parent_issue_type_name
        ,parentissuesummary as jira_issue_parent_issue_summary
        ,updatedate as sys_updated
        ,raw_updated
from lit_jira_sprint_items
  );

