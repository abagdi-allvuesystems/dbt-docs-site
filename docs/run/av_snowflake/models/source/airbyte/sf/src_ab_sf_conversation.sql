
  create or replace   view AV_EDM.AV_SOURCE.src_ab_sf_conversation
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.SALESFORCE.GONG__GONG_CALL__C
  );

