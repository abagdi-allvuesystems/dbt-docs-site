
  create or replace   view AV_EDM.AV_STAGING.stg_confluence_tasks
  
  
  
  
  as (
    WITH confluence_tasks AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_confluence_tasks
)
SELECT
        assigned_to AS assigned_to
        ,completed_at AS completed_date
        ,completed_by AS completed_by
        ,created_at AS created_date
        ,created_by AS created_by
        ,due_at AS due_date
        ,id AS id
        ,local_id AS local_id
        ,page_id AS page_id
        ,space_id AS space_id
        ,status AS status
        ,updated_at AS updated_date
        ,_airbyte_extracted_at AS airbyte_extracted_at
        ,_airbyte_generation_id as airbyte_generation_id
        ,_airbyte_meta as airbyte_meta
        ,_airbyte_raw_id AS airbyte_raw_id
FROM 
        confluence_tasks
  );

