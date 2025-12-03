
  create or replace   view AV_EDM.AV_STAGING.stg_confluence_comments
  
  
  
  
  as (
    WITH confluence_comments AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_confluence_comments
)
SELECT
        SPLIT_PART(ari, '/', 2) AS user_id
        ,SPLIT_PART(ari, ':', 4) AS page_id
        ,ari AS ari
        ,base64encodedari AS base64encodedari
        ,extensions AS extensions
        ,id AS id
        ,macrorenderedoutput AS macrorenderedoutput
        ,status AS status
        ,title AS title
        ,type AS type
        ,_airbyte_extracted_at AS airbyte_extracted_at
        ,_airbyte_generation_id AS airbyte_generation_id
        ,_airbyte_meta AS airbyte_meta
        ,_airbyte_raw_id AS airbyte_raw_id
        ,_expandable AS expandable
        ,_links AS links

FROM confluence_comments
  );

