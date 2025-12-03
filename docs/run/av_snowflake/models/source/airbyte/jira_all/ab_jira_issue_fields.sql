
  create or replace   view AV_EDM.AV_SOURCE.ab_jira_issue_fields
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_ALL.ISSUE_FIELDS
  );

