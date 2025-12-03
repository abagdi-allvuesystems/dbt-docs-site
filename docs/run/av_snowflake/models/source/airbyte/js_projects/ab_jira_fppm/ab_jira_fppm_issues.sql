
  create or replace   view AV_EDM.AV_SOURCE.ab_jira_fppm_issues
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_PROJECT_FPPM.ISSUES
  );

