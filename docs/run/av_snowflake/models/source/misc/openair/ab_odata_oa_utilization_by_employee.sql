
  create or replace   view AV_EDM.AV_SOURCE.ab_odata_oa_utilization_by_employee
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.SUITEPROJECTS_ODATA.UTILIZATIONBYEMPLOYEE
  );

