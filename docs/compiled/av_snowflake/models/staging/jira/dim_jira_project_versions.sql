WITH sys_jira_proj_versions AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_project_versions
)
SELECT id as id
    ,projectid as project_id
    ,name as name
    ,overdue as overdue
    ,archived as archived
    ,released as released
    ,startdate as start_date
    ,releasedate as release_date
    ,description as description
FROM
    sys_jira_proj_versions