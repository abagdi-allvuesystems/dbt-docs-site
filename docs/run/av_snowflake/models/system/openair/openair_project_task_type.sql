
  create or replace   view AV_EDM.AV_SYSTEM.openair_project_task_type
  
  
  
  
  as (
    WITH project_task_type AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_projecttask_type
)

SELECT
        id::INT AS id
        ,name::VARCHAR AS name
FROM 
        project_task_type
  );

