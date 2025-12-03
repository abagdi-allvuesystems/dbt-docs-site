
  create or replace   view AV_EDM.AV_SYSTEM.jira_workflow_statuses
  
  
  
  
  as (
    WITH raw_status AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_jira_workflow_statuses
)
SELECT 
        id::INT AS id
        ,name::VARCHAR AS name
        ,self::VARCHAR AS self
        ,scope
        ,description::VARCHAR AS description
        ,statuscategory
        ,untranslatedname::VARCHAR as untranslatedname
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated

FROM 
        raw_status
  );

