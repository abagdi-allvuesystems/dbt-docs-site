
  create or replace   view AV_EDM.AV_SOURCE.ab_jira_issue_custom_field_options
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_ALL.ISSUE_CUSTOM_FIELD_OPTIONS
  );

