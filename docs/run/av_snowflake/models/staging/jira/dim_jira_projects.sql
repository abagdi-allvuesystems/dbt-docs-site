
  create or replace   view AV_EDM.AV_STAGING.dim_jira_projects
  
  
  
  
  as (
    WITH jira_projects AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_projects
)

SELECT 
        id
        ,key
        ,name
        ,projecttypekey AS type
        ,CASE WHEN DELETED IS NULL AND ARCHIVED IS NULL THEN 'true' ELSE 'false' END::BOOLEAN AS is_active
        ,raw_updated

FROM 
        jira_projects
  );

