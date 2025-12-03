
  create or replace   view AV_EDM.AV_SOURCE.src_ab_sf_uservaluemap
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.SALESFORCE.VALUE_MAP__C
  );

