
  create or replace   view AV_EDM.AV_STAGING.stg_confluence_users
  
  
  
  
  as (
    WITH conf_users AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_confluence_users
)
SELECT 
       SPLIT_PART(URL, '/', 3)::VARCHAR as id
       ,title as title
       ,entity_type as entity_type
       ,PARSE_JSON(USER):"accountId"::VARCHAR AS account_id
       ,PARSE_JSON(USER):"displayName"::VARCHAR AS display_name
       ,PARSE_JSON(USER):"email"::VARCHAR AS email
       ,PARSE_JSON(USER):"timeZone"::VARCHAR AS time_zone
       ,PARSE_JSON(USER):"type"::VARCHAR AS user_type
       ,PARSE_JSON(USER):"publicName"::VARCHAR AS public_name
       ,PARSE_JSON(USER):"accountType"::VARCHAR AS account_type
       ,PARSE_JSON(USER):"isExternalCollaborator"::BOOLEAN AS is_external_collaborator
       ,last_modified as last_modified_date
       ,Breadcrumbs AS breadcrumbs
       ,Excerpt AS excerpt
       ,score AS score
       ,_airbyte_extracted_at::timestamp_ntz AS airbyte_extracted_at
       ,_airbyte_generation_id::INT AS airbyte_generation_id
       ,_airbyte_meta::VARCHAR AS airbyte_meta
       ,_airbyte_raw_id::VARCHAR AS airbyte_raw_id

FROM conf_users
  );

