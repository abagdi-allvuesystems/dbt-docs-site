
  create or replace   view AV_EDM.AV_SOURCE.ab_objectschema_objecttypes
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_ASSETS.OBJECTSCHEMA_OBJECTTYPES
  );

