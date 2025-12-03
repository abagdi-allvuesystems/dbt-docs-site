
  create or replace   view AV_EDM.AV_SOURCE.ab_ism_objects
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_ASSETS.ISM_OBJECTS
  );

