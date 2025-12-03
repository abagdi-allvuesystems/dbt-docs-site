WITH dim_jira_change_tickets AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_change_tickets
)
SELECT issue_id AS issue_id
    ,issue_key AS issue_key
    ,affected_services.value:id::VARCHAR AS affected_services_id
FROM dim_jira_change_tickets,
    LATERAL FLATTEN( INPUT => affected_services ) AS affected_services