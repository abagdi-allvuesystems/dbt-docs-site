
  create or replace   view AV_EDM.AV_SOURCE.ab_jira_rd_project_versions
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_PROJECT_RD.PROJECT_VERSIONS
  );

