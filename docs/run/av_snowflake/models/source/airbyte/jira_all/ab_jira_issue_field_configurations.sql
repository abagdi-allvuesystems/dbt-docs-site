
  create or replace   view AV_EDM.AV_SOURCE.ab_jira_issue_field_configurations
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_ALL.ISSUE_FIELD_CONFIGURATIONS
  );

