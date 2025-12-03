
  create or replace   view AV_EDM.AV_SYSTEM.sys_confluence_pages
  
  
  
  
  as (
    WITH confluence_pages AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_confluence_pages
)
SELECT
        ID::INT AS page_id
        ,TITLE::VARCHAR AS page_name
        ,SPACEID::INT AS space_id
        ,PARENTID::INT AS parent_id
        ,PARENTTYPE::VARCHAR AS parent_type
        ,CREATEDAT::TIMESTAMP_TZ AS created_date
        ,AUTHORID::VARCHAR AS created_by_id
        ,BODY::VARCHAR AS body
        ,OWNERID::VARCHAR AS owner_id
        ,LASTOWNERID::VARCHAR AS last_modified_by_id
        ,POSITION::INT AS position
        ,SOURCETEMPLATEENTITYID::VARCHAR AS source_template_entity_id
        ,STATUS::VARCHAR AS status
        ,VERSION::VARCHAR AS version
        ,_AIRBYTE_EXTRACTED_AT::TIMESTAMP_TZ AS _airbyte_extracted_at
        ,_AIRBYTE_GENERATION_ID::INT AS _airbyte_generation_id
        ,_AIRBYTE_META::VARIANT AS _airbyte_meta
        ,_AIRBYTE_RAW_ID::VARCHAR AS _airbyte_raw_id
        
FROM 
        confluence_pages
  );

