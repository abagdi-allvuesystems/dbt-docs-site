
  create or replace   view AV_EDM.AV_STAGING.dim_litheo_jira_board_sprints
  
  
  
  
  as (
    WITH lit_jira_board_sprints as (
    select * from AV_EDM.AV_SYSTEM.litheo_jira_board_sprints
)
select sprintid as jira_sprint_id
        ,originboardid as jira_origin_board_id
        ,sprintname as jira_sprint_name
        ,sprintstate as jira_sprint_state
        ,sprintisostartdate::TIMESTAMP_TZ as jira_sprint_start_date
        ,sprintisoenddate::TIMESTAMP_TZ as jira_sprint_end_date
        ,sprintisocompletedate::TIMESTAMP_TZ as jira_sprint_complete_date
        ,updatedate as sys_updated
        ,sprintitemupdatedate as sys_updated_sprint_itm
        ,raw_updated
from lit_jira_board_sprints
  );

