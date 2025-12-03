
  create or replace   view AV_EDM.AV_SYSTEM.sys_sf_contacthistory
  
  
  
  
  as (
    WITH raw_contact_history AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_contacthistory
)
select id AS id
    ,field AS field
    ,datatype AS datatype
    ,newvalue AS new_value
    ,oldvalue AS old_value
    ,contactid as account_id
    ,isdeleted::BOOLEAN AS is_deleted
    ,createdbyid AS created_by_id
    ,createddate::TIMESTAMP_TZ AS created_date
    ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM raw_contact_history
  );

