
  create or replace   view AV_EDM.AV_SYSTEM.sys_confluence_spaces
  
  
  
  
  as (
    WITH confluence_spaces AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_confluence_spaces
)
SELECT
        AUTHORID::VARCHAR AS author_id
        ,CREATEDAT::TIMESTAMP_TZ AS created_at
        ,CURRENTACTIVEALIAS::VARCHAR AS current_active_alias
        ,HOMEPAGEID::VARCHAR AS homepage_id
        ,ID::VARCHAR AS space_id
        ,KEY::VARCHAR AS space_key
        ,NAME::VARCHAR AS space_name
        ,SPACEOWNERID::VARCHAR AS space_owner_id
        ,STATUS::VARCHAR AS status
        ,TYPE::VARCHAR AS type
        ,_AIRBYTE_EXTRACTED_AT::TIMESTAMP_TZ AS _airbyte_extracted_at
        ,_AIRBYTE_GENERATION_ID::INT AS _airbyte_generation_id
        ,_AIRBYTE_META::VARIANT AS _airbyte_meta
        ,_AIRBYTE_RAW_ID::VARCHAR AS _airbyte_raw_id
        ,_LINKS::VARCHAR AS _links
FROM 
        confluence_spaces
  );

