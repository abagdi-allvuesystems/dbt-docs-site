
  create or replace   view AV_EDM.AV_SOURCE.ab_jira_spp_project_versions
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_PROJECT_SPP.PROJECT_VERSIONS
  );

