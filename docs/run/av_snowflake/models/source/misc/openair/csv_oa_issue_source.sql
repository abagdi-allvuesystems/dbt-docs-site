
  create or replace   view AV_EDM.AV_SOURCE.csv_oa_issue_source
  
  
  
  
  as (
    SELECT * FROM LANDING_EDM.OPENAIR.ISSUE_SOURCE
  );

