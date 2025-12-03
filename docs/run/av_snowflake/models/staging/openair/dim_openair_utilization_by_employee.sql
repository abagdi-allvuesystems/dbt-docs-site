
  create or replace   view AV_EDM.AV_STAGING.dim_openair_utilization_by_employee
  
  
  
  
  as (
    WITH oa_utilization_emp AS (
    SELECT * from AV_EDM.AV_SYSTEM.openair_utilization_by_employee
)
SELECT * FROM oa_utilization_emp
  );

