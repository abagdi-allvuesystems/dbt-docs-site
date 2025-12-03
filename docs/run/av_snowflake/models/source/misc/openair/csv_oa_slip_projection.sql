
  create or replace   view AV_EDM.AV_SOURCE.csv_oa_slip_projection
  
  
  
  
  as (
    SELECT * FROM LANDING_EDM.OPENAIR.SLIP_PROJECTION
  );

