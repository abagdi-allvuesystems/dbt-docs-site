
  create or replace   view AV_EDM.AV_SOURCE.ab_jira_fppm_project_versions
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_PROJECT_FPPM.PROJECT_VERSIONS
  );

