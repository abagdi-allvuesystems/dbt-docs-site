
  create or replace   view AV_EDM.AV_STAGING.dim_jira_enterprise_tickets_time_in_status
  
  
  
  
  as (
    WITH dim_enterprise_tickets AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_enterprise_tickets
), dimh_jira_issues_status AS (
    SELECT * FROM AV_EDM.AV_STAGING.dimh_jira_jsm_issues_status
), dimh_enterprise_tickets_time_in_statuses AS (
    SELECT it.issue_id
        ,jis.status_id
        ,jis.status_name
        ,jis.effective_date_start
        ,jis.effective_date_end
        ,DATEDIFF('millisecond', jis.effective_date_start, jis.effective_date_end) AS time_in_status_milliseconds
    FROM dim_enterprise_tickets it LEFT JOIN dimh_jira_issues_status jis ON it.issue_id = jis.issue_id
), total_time_in_statuses AS (
    SELECT issue_id
        ,status_id
        ,SUM(time_in_status_milliseconds) AS time_in_status_milliseconds
        ,SUM(time_in_status_milliseconds) / (1000 * 60 * 60) AS time_in_status_hours
        ,COUNT(*) AS count_times_in_status
    FROM dimh_enterprise_tickets_time_in_statuses GROUP BY issue_id, status_id
), wf_statuses AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_workflow_statuses
)
SELECT tt.issue_id as issue_id
    ,tt.status_id as workflow_status_id
    ,wf.name as workflow_status_name
    ,tt.count_times_in_status as count_times_in_status
    ,tt.time_in_status_milliseconds as time_in_status_milliseconds
    ,tt.time_in_status_hours as time_in_status_hours
FROM total_time_in_statuses tt LEFT JOIN wf_statuses wf ON tt.status_id = wf.id
  );

