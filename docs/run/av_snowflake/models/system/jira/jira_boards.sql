
  create or replace   view AV_EDM.AV_SYSTEM.jira_boards
  
  
  
  
  as (
    WITH raw_boards AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_jira_boards
)
SELECT 
        id::INT AS id
        ,name::VARCHAR AS name
        ,type::VARCHAR AS type
        ,location
        ,TRY_CAST(projectid as INT) AS projectid
        ,projectkey::VARCHAR AS projectkey
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated

FROM 
        raw_boards
  );

