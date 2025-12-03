
  create or replace   view AV_EDM.AV_SOURCE.csv_oa_target_utilization
  
  
  
  
  as (
    SELECT * FROM LANDING_EDM.OPENAIR.TARGET_UTILIZATION
  );

