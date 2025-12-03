
  create or replace   view AV_EDM.AV_SYSTEM.sys_confluence_lables
  
  
  
  
  as (
    WITH confluence_lables AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_confluence_lables
)
SELECT 
       ID::VARCHAR AS id
       ,NAME::VARCHAR AS name
       ,PREFIX::VARCHAR AS prefix
       ,_AIRBYTE_EXTRACTED_AT::timestamp_ntz AS airbyte_extracted_at
       ,_AIRBYTE_GENERATION_ID::INT AS airbyte_generation_id
       ,_AIRBYTE_META::VARIANT AS airbyte_meta
       ,_AIRBYTE_RAW_ID::VARCHAR AS airbyte_raw_id

FROM confluence_lables
  );

