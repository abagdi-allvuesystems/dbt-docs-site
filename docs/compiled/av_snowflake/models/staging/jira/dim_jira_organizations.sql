WITH jsm_orgs AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_organizations    
)
SELECT id AS id
    ,name AS name
    ,TO_TIMESTAMP_TZ(LEFT(created:jira::VARCHAR, 26) || ':' || RIGHT(created:jira::VARCHAR, 2)) AS sys_created
    ,raw_updated AS raw_updated
FROM jsm_orgs