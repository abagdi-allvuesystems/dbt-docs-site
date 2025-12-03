
  create or replace   view AV_EDM.AV_SOURCE.ab_odata_oa_project_snapshots
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.SUITEPROJECTS_ODATA.PROJECTSNAPSHOTS
  );

