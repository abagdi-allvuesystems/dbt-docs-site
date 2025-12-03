
  create or replace   view AV_EDM.AV_SOURCE.csv_oa_budget
  
  
  
  
  as (
    SELECT * FROM LANDING_EDM.OPENAIR.BUDGET
  );

