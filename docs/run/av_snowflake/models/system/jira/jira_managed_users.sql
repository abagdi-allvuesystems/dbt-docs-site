
  create or replace   view AV_EDM.AV_SYSTEM.jira_managed_users
  
  
  
  
  as (
    WITH man_users_raw AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_jira_admin_managed_users
)
SELECT name AS name
    ,email AS email
    ,account_id AS account_id
    ,last_active::TIMESTAMP_TZ AS last_active
    ,account_type AS account_type
    ,account_status AS account_status
    ,product_access AS product_access
    ,access_billable AS access_billable
    ,_airbyte_extracted_at AS raw_updated
FROM man_users_raw
  );

