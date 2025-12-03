
  create or replace   view AV_EDM.AV_SOURCE.sp_openair_project_tasks
  
  
  
  
  as (
    SELECT * FROM AV_EDM_SNAPSHOTS.OPENAIR.OPENAIR_PROJECT_TASK_SNAPSHOT
  );

