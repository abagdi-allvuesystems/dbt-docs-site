
  create or replace   view AV_EDM.AV_SOURCE.sp_openair_projects
  
  
  
  
  as (
    SELECT * FROM AV_EDM_SNAPSHOTS.OPENAIR.OPENAIR_PROJECTS_SNAPSHOT
  );

