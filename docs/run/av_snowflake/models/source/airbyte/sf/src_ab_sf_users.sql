
  create or replace   view AV_EDM.AV_SOURCE.src_ab_sf_users
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.SALESFORCE.USER
  );

