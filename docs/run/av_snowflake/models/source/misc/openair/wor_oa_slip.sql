
  create or replace   view AV_EDM.AV_SOURCE.wor_oa_slip
  
  
  
  
  as (
    SELECT * FROM LANDING_EDM.OPENAIR_WORKATO.SLIP
  );

