
  create or replace   view AV_EDM.AV_SOURCE.csv_oa_customer
  
  
  
  
  as (
    SELECT * FROM LANDING_EDM.OPENAIR.CUSTOMER
  );

