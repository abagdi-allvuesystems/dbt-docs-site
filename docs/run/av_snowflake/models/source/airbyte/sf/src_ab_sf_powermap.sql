
  create or replace   view AV_EDM.AV_SOURCE.src_ab_sf_powermap
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.SALESFORCE.QS_KEY_PLAYERS_INFLUENCERS__C
  );

