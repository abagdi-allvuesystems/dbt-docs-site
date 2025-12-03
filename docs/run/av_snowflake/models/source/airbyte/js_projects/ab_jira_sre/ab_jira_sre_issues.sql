
  create or replace   view AV_EDM.AV_SOURCE.ab_jira_sre_issues
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_PROJECT_SRE.ISSUES
  );

