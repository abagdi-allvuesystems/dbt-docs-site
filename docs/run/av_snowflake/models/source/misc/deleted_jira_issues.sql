
  create or replace   view AV_EDM.AV_SOURCE.deleted_jira_issues
  
  
  
  
  as (
    SELECT * FROM LANDING_EDM.JIRA_MANUAL_LOAD.DELETED_JIRA_ISSUES
  );

