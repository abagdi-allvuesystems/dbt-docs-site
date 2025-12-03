WITH conf_spaces AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_confluence_spaces
)
SELECT 
       space_id as space_id
       ,space_name as space_name
       ,space_key as space_key
       ,current_active_alias as current_active_alias
       ,homepage_id as home_page_id
       ,space_owner_id as space_owner_id
       ,author_Id as author_Id
       ,created_At::timestamp_ntz AS created_date
       ,status as status
       ,type as type
       ,_links::string AS links
       ,_airbyte_extracted_at::timestamp_ntz AS airbyte_extracted_at
       ,_airbyte_generation_id::INT AS airbyte_generation_id
       ,_airbyte_meta::string AS airbyte_meta
       ,_airbyte_raw_id::string AS airbyte_raw_id

FROM conf_spaces