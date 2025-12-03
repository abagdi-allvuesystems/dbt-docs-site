
  create or replace   view AV_EDM.AV_SOURCE.jsm_portal_only_customers
  
  
  
  
  as (
    SELECT * FROM LANDING_EDM.JIRA_MANUAL_LOAD.JSM_PORTAL_ONLY_CUSTOMERS
  );

