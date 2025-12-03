
  create or replace   view AV_EDM.AV_SOURCE.ab_jira_admin_managed_users
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_ORG_ADMIN.MANAGED_USERS
  );

