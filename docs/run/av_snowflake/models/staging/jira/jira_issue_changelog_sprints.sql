
  create or replace   view AV_EDM.AV_STAGING.jira_issue_changelog_sprints
  
  
  
  
  as (
    WITH changelog as (
    select * 
    from AV_EDM.AV_SYSTEM.jira_issue_changelog 
)
select issue_id
          ,history_id
          ,sys_created
          ,account_id
          ,account_display_name
          ,from_id
          ,to_id
from changelog
where FIELD_ID = 'customfield_10020'
  );

