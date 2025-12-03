WITH jira_issues AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_issues
)

SELECT 
        id AS issue_id
        ,ms.value:id::INT AS market_segement_field_id
        ,ms.value:value::VARCHAR AS market_segement_field_value
FROM 
        jira_issues,
        LATERAL FLATTEN( INPUT => fields:customfield_10585 ) AS ms