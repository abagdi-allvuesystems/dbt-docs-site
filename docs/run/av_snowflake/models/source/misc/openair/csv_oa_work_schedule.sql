
  create or replace   view AV_EDM.AV_SOURCE.csv_oa_work_schedule
  
  
  
  
  as (
    SELECT * FROM LANDING_EDM.OPENAIR.WORKSCHEDULE
  );

