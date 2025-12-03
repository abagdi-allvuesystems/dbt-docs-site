
  create or replace   view AV_EDM.AV_SOURCE.csv_oa_project_billing_transcaction
  
  
  
  
  as (
    SELECT * FROM LANDING_EDM.OPENAIR.PROJECT_BILLING_TRANSACTION
  );

