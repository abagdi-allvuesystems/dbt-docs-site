
  create or replace   view AV_EDM.AV_SOURCE.csv_oa_revenue_projection
  
  
  
  
  as (
    SELECT * FROM LANDING_EDM.OPENAIR.REVENUE_PROJECTION
  );

