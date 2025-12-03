
  create or replace   view AV_EDM.AV_SOURCE.ab_itsm_objects
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_ASSETS.ITSM_OBJECTS
  );

