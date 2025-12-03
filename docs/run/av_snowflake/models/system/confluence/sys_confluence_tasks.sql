
  create or replace   view AV_EDM.AV_SYSTEM.sys_confluence_tasks
  
  
  
  
  as (
    WITH confluence_tasks AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_confluence_tasks
)
SELECT
        ASSIGNEDTO::VARCHAR AS assigned_to
        ,COMPLETEDAT::VARCHAR AS completed_at
        ,COMPLETEDBY::VARCHAR AS completed_by
        ,CREATEDAT::VARCHAR AS created_at
        ,CREATEDBY::VARCHAR AS created_by
        ,DUEAT::VARCHAR AS due_at
        ,ID::VARCHAR AS id
        ,LOCALID::VARCHAR AS local_id
        ,PAGEID::VARCHAR AS page_id
        ,SPACEID::VARCHAR AS space_id
        ,STATUS::VARCHAR AS status
        ,UPDATEDAT::VARCHAR AS updated_at
        ,_AIRBYTE_EXTRACTED_AT::TIMESTAMP_TZ AS _airbyte_extracted_at
        ,_AIRBYTE_GENERATION_ID::INT AS _airbyte_generation_id
        ,_AIRBYTE_META::VARIANT AS _airbyte_meta
        ,_AIRBYTE_RAW_ID::VARCHAR AS _airbyte_raw_id
FROM 
        confluence_tasks
  );

