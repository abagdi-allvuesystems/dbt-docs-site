
  create or replace   view AV_EDM.AV_STAGING.stg_confluence_page_versions
  
  
  
  
  as (
    WITH conf_page_ver AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_confluence_page_versions
)
SELECT 
       PARSE_JSON(PAGE):"id"::VARCHAR AS page_id
       ,PARSE_JSON(PAGE):"title"::VARCHAR AS page_title
       ,number AS version_number
       ,message AS comments
       ,author_id AS updated_by_id
       ,created_at AS updated_date
       ,minor_edit AS is_minor_edit
       ,airbyte_extracted_at::timestamp_ntz AS airbyte_extracted_at
       ,airbyte_generation_id::INT AS airbyte_generation_id
       ,airbyte_meta::VARCHAR AS airbyte_meta
       ,airbyte_raw_id::VARCHAR AS airbyte_raw_id

FROM conf_page_ver
  );

