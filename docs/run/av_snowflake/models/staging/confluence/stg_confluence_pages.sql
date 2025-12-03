
  create or replace   view AV_EDM.AV_STAGING.stg_confluence_pages
  
  
  
  
  as (
    WITH conf_pages AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_confluence_pages
)
SELECT 
       page_id as page_id
       ,page_name as page_name
       ,space_id as space_id
       ,parent_id as parent_page_id
       ,parent_type as parent_page_type
       ,CREATED_DATE::timestamp_ntz  AS created_date
       ,created_by_id AS created_by_id
       ,body as body
       ,owner_id as owner_id
       ,last_modified_by_id AS last_modified_by_id
       ,position as position
       ,source_template_entity_id as source_template_entity_id
       ,status as status
       ,PARSE_JSON(VERSION):"authorId"::string AS last_updated_by_id
       ,PARSE_JSON(VERSION):"createdAt"::timestamp_ntz AS last_updated_date
       ,PARSE_JSON(VERSION):"message"::string AS last_updated_version_message
       ,PARSE_JSON(VERSION):"number"::int AS last_updated_version_number
       ,_airbyte_extracted_at::timestamp_ntz AS airbyte_extracted_at
       ,_airbyte_generation_id::string AS airbyte_generation_id
       ,_airbyte_meta::string AS airbyte_meta
       ,_airbyte_raw_id::string AS airbyte_raw_id

FROM conf_pages
  );

