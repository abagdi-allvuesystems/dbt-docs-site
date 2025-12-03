WITH jira_issues AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_issues
)
SELECT 
        id AS issue_id
        ,ap.value:id::INT as associated_products_field_id
        ,ap.value:value::VARCHAR AS associated_products_field_value
FROM 
        jira_issues,
        LATERAL FLATTEN( INPUT => fields:customfield_10596 ) AS ap