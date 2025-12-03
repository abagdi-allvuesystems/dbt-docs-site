
  create or replace   view AV_EDM.AV_SOURCE.csv_oa_slip
  
  
  
  
  as (
    SELECT * FROM LANDING_EDM.OPENAIR.SLIP
  );

