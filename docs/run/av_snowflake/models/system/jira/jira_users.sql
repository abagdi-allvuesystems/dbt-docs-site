
  create or replace   view AV_EDM.AV_SYSTEM.jira_users
  
  
  
  
  as (
    WITH users_raw AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_jira_users
)
SELECT accountid AS accountid
    ,active::BOOLEAN AS active
    ,displayname AS displayname
    ,accounttype AS accounttype
    ,emailaddress AS emailaddress
    ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM users_raw
  );

