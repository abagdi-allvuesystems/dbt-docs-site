
  create or replace   view AV_EDM.AV_SYSTEM.jira_projects
  
  
  
  
  as (
    WITH raw_projects AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_jira_projects
)
SELECT 
        id::INT AS id
        ,key::VARCHAR AS key
        ,name::VARCHAR AS name
        ,lead:accountId::VARCHAR AS lead__accountid
        ,lead:displayName::VARCHAR AS lead__displayname
        ,style::VARCHAR AS style
        ,projecttypekey::VARCHAR AS projecttypekey
        ,deleted::BOOLEAN AS deleted
        ,archived::BOOLEAN AS archived
        ,description::VARCHAR AS description
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated

FROM 
        raw_projects
  );

