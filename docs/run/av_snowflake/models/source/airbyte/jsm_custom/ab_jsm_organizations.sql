
  create or replace   view AV_EDM.AV_SOURCE.ab_jsm_organizations
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_CUSTOM_JSM.JSM_ORGANIZATIONS
  );

