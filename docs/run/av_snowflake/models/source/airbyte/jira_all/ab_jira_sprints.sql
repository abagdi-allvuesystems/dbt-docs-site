
  create or replace   view AV_EDM.AV_SOURCE.ab_jira_sprints
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_ALL.SPRINTS
  );

