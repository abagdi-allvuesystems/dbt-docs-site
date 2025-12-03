
  create or replace   view AV_EDM.AV_SOURCE.ab_jira_workflow_statuses
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_ALL.WORKFLOW_STATUSES
  );

