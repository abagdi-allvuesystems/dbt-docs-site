
  create or replace   view AV_EDM.AV_SOURCE.src_ab_confluence_users
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.CONFLUENCE_CUSTOM.CONFLUENCE_USERS
  );

