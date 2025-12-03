
  create or replace   view AV_EDM.AV_SOURCE.ab_jira_arch_project_versions
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_PROJECT_ARCH.PROJECT_VERSIONS
  );

