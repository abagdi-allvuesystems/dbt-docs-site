WITH jira_issues AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_issues
)
SELECT 
        id AS issue_id
        ,key AS issue_key
        ,type_name AS issue_type_name
        ,type_id AS issue_type_id
        ,parent_type_name AS parent_issue_type
        ,parent_issue_id
        ,parent_issue_key
        ,fields:status.name::VARCHAR AS issue_status_name
        ,fields:status.id::INT AS issue_status_id
        ,fields:status.statusCategory.name::VARCHAR AS issue_status_category
        ,project_id
        ,fields:summary::VARCHAR AS issue_summary
        ,fields:customfield_10028::NUMBER AS issue_story_points
        ,fields:customfield_10001.id::VARCHAR AS issue_team_id
        ,fields:customfield_10001.name::VARCHAR AS issue_team_name
        ,fields:customfield_10020 AS issue_sprints
        ,fields:fixVersions as fix_versions
        ,fields:labels::VARCHAR AS labels
        ,fields:reporter as reporter
        ,fields:assignee as assignee
        ,TO_TIMESTAMP_TZ(LEFT(fields:resolutiondate::VARCHAR, 26) || ':' || RIGHT(fields:resolutiondate::VARCHAR, 2)) AS issue_resolutiondate
        ,sys_created
        ,sys_updated
        ,raw_updated
FROM jira_issues
WHERE TYPE_NAME IN ('Story','Bug','Task','Test Execution','Enabler','Service Request','Spark')