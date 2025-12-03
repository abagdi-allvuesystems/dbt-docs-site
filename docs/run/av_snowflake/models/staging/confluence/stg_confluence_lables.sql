
  create or replace   view AV_EDM.AV_STAGING.stg_confluence_lables
  
  
  
  
  as (
    WITH confluence_lables AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_confluence_lables
)
SELECT 
       id AS id
       ,name AS name
       ,prefix AS prefix
       ,airbyte_extracted_at as airbyte_extracted_at
       ,airbyte_generation_id as airbyte_generation_id
       ,airbyte_meta as airbyte_meta
       ,airbyte_raw_id as airbyte_raw_id

FROM confluence_lables
  );

