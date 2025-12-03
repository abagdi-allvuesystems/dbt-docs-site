
  create or replace   view AV_EDM.AV_SOURCE.ab_jira_fod_project_versions
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_PROJECT_FOD.PROJECT_VERSIONS
  );

