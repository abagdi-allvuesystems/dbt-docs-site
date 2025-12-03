WITH dim_change_tickets AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_change_tickets
), flat_tis AS (
    select issue_id
            ,issue_key
            ,TRIM(SPLIT_PART(time_in_statuses.value::VARCHAR, '_*:*_', 1)) as status_id
            ,TRIM(SPLIT_PART(time_in_statuses.value::VARCHAR, '_*:*_', 2)) as count_times_in_status
            ,TRIM(SPLIT_PART(time_in_statuses.value::VARCHAR, '_*:*_', 3)) as time_in_status_milliseconds
            ,ROUND(TRIM(SPLIT_PART(time_in_statuses.value::VARCHAR, '_*:*_', 3)) / (1000 * 60 * 60), 2) as time_in_status_hours
    from dim_change_tickets,
            LATERAL FLATTEN(input => SPLIT(time_in_status, '_*|*_')) as time_in_statuses
), wf_statuses AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_workflow_statuses
)
SELECT flat_tis.issue_id as issue_id
    ,flat_tis.issue_key as issue_key
    ,flat_tis.status_id as workflow_status_id
    ,wf_statuses.name as workflow_status_name
    ,flat_tis.count_times_in_status as count_times_in_status
    ,flat_tis.time_in_status_milliseconds as time_in_status_milliseconds
    ,flat_tis.time_in_status_hours as time_in_status_hours
FROM flat_tis LEFT JOIN wf_statuses ON flat_tis.status_id = wf_statuses.id