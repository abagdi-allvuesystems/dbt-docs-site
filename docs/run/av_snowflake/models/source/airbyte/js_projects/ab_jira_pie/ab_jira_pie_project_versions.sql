
  create or replace   view AV_EDM.AV_SOURCE.ab_jira_pie_project_versions
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_PROJECT_PIE.PROJECT_VERSIONS
  );

