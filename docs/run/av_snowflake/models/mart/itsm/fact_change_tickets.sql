
  
    

create or replace transient table AV_EDM.AV_ITSM.fact_change_tickets
    
    
    
    as (WITH jira_change_tickets AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_change_tickets
), jira_change_labels AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_change_labels
), cab_hold AS (
    SELECT issue_id
    from jira_change_labels
    where label_name = 'CAB_Hold'
), system_test AS (
    SELECT issue_id
    from jira_change_labels
    where label_name = 'jira_system_test'
), unauthorized AS (
    SELECT issue_id
    from jira_change_labels
    where label_name = 'Unauthorized_Change'
)
SELECT MD5(jct.issue_id) AS id
        ,'jira' AS source_system
        ,jct.issue_id AS system_ticket_id
        ,jct.issue_key AS system_ticket_key
        ,jct.summary As summary
        ,jct.request_type_name as request_type_name
        ,jct.reporter_account_id as initiator_sys_account_id
        ,jct.reporter_display_name as initiator_display_name
        ,jct.assignee_account_id as implementer_sys_account_id
        ,jct.assignee_display_name as implementer_display_name
        ,jct.assignment_group_name as impelementation_team_name
        ,jct.change_risk as risk
        ,CASE WHEN jct.request_type_id = 148 THEN 'Standard' ELSE jct.change_type END::VARCHAR as type
        ,jct.status_name as status
        ,jct.sys_created as created
        ,jct.resolution_date as resolution_date
        ,jct.resolution_date::DATE as resolution_date_id
        ,jct.change_completion_date as implementation_date
        ,jct.planned_start_date as planned_implementation_start_date
        ,jct.planned_end_date as planned_implementation_end_date
        ,CASE WHEN cab_hold.issue_id is not null then TRUE else FALSE END::BOOLEAN as had_cab_hold
        ,CASE WHEN unauthorized.issue_id is not null then TRUE else FALSE END::BOOLEAN as is_unauthorized
FROM jira_change_tickets jct LEFT JOIN cab_hold on jct.issue_id = cab_hold.issue_id
                             LEFT JOIN system_test on jct.issue_id = system_test.issue_id
                             LEFT JOIN unauthorized on jct.issue_id = unauthorized.issue_id
where system_test.issue_id is null
    )
;


  