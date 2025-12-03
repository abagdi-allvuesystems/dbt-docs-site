
  
    

create or replace transient table AV_EDM.AV_ITSM.fact_customer_ticket_metrics
    
    
    
    as (WITH customer_tickets AS (
    SELECT * FROM AV_EDM.AV_ITSM.dim_customer_tickets where resolution_date is not null
), dim_jira_customer_tickets AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets
), customer_tickets_time_in_status AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets_time_in_status 
), time_in_pending AS (
    SELECT issue_id as issue_id
       ,SUM(time_in_status_hours) as time_in_status_hours
    FROM customer_tickets_time_in_status
    WHERE workflow_status_name in ('Pending','Pending Client','Pending Release','Awaiting Approval','Waiting for Approval')
    GROUP BY issue_id
), time_in_consultation AS (
    SELECT issue_id as issue_id
        ,SUM(time_in_status_hours) as time_in_status_hours
    FROM customer_tickets_time_in_status
    WHERE workflow_status_name in ('Consultation')
    GROUP BY issue_id
), ttr_sla AS (
    SELECT *
    FROM (
        VALUES
            ('Incident',NULL,'Critical','6.0'),
            ('Incident',NULL,'High','48.0'),
            ('Incident',NULL,'Medium','120.0'),
            ('Service Request','User Access',NULL,'48.0')
        
    ) AS ttr_sla (ticket_type,ticket_sub_type,priority,sla_target_hours)
), jsm_assignee_count AS (
    SELECT issue_id
        ,count(distinct assignee_account_id) as count_assignees
    FROM AV_EDM.AV_STAGING.dimh_jira_jsm_issues_assignee
    group by issue_id
), jsm_worklog AS (
    SELECT *
    FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets_worklog
), jsm_worklog_agg AS (
    SELECT issue_id
        ,(SUM(time_spent_seconds)) / 3600 as worklog_hours
    FROM jsm_worklog
    GROUP by issue_id
), ct_first_assignment_count AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets_first_assignment_metric
), time_to_engage AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets_time_to_engage_metric
)
SELECT ct.id as customer_ticket_id
    ,ct.resolution_date::DATE as date_id
    ,ROUND(DATEDIFF(s,ct.sys_created,ct.resolution_date)::INT / (60 * 60 ), 2) AS time_to_close_hours
    ,ROUND(DATEDIFF(s,ct.sys_created,ct.restored_date)::INT / (60 * 60 ), 2) AS time_to_restore_hours
    ,IFNULL(tip.time_in_status_hours,0) AS time_in_pending_hours
    ,ROUND(DATEDIFF(s,ct.sys_created,ct.resolution_date)::INT / (60 * 60 ), 2) - IFNULL(tip.time_in_status_hours,0) AS time_to_resolution_hours
    ,sla.sla_target_hours AS time_to_resolution_target_hours
    ,CASE WHEN sla.sla_target_hours is NULL then NULL
          WHEN ROUND(DATEDIFF(s,ct.sys_created,ct.resolution_date)::INT / (60 * 60 ), 2) - IFNULL(tip.time_in_status_hours,0) <= 
                        sla.sla_target_hours THEN true
          ELSE false END::BOOLEAN as time_to_resolution_sla_met
    ,ROUND(ROUND(DATEDIFF(s,ct.sys_created,ct.resolution_date)::INT / (60 * 60 ), 2) - IFNULL(tip.time_in_status_hours,0)) 
        / NULLIF(sla.sla_target_hours,0) AS time_to_resolution_percent_of_target
    ,ROUND(djct.time_to_resolution:completedCycles[0]:elapsedTime:millis::INT / (1000 * 60 * 60), 2) as time_to_resolution_internal_sla_hours
    ,ROUND(djct.time_to_resolution:completedCycles[0]:goalDuration:millis::INT / (1000 * 60 * 60), 2) as time_to_resolution_internal_sla_target_hours
    ,CASE WHEN ROUND(djct.time_to_resolution:completedCycles[0]:goalDuration:millis::INT / (1000 * 60 * 60), 2) is NULL then NULL
          WHEN ROUND(djct.time_to_resolution:completedCycles[0]:goalDuration:millis::INT / (1000 * 60 * 60), 2) >= 
                        ROUND(djct.time_to_resolution:completedCycles[0]:elapsedTime:millis::INT / (1000 * 60 * 60), 2) THEN true
          ELSE false END::BOOLEAN as time_to_resolution_internal_sla_met
    ,ROUND(djct.time_to_resolution:completedCycles[0]:elapsedTime:millis::INT / (1000 * 60 * 60), 2) 
        / NULLIF(ROUND(djct.time_to_resolution:completedCycles[0]:goalDuration:millis::INT / (1000 * 60 * 60), 2),0) AS time_to_resolution_internal_sla_percent_of_target
    ,jac.count_assignees as count_assignees
    ,fac.count_assignees as count_assignees_in_window
    ,jwa.worklog_hours as worklog_hours
    ,IFNULL(tic.time_in_status_hours,0) as time_in_consultation_hours
    ,ROUND(DATEDIFF(s,ct.sys_created,djct.initial_consultation)::INT / (60 * 60 ), 2) AS time_to_initial_consultation
    ,tte.time_to_engage as time_to_engage_hours
FROM customer_tickets ct LEFT JOIN dim_jira_customer_tickets AS djct ON ct.system_ticket_id = djct.issue_id
                         LEFT JOIN time_in_pending as tip ON djct.issue_id = tip.issue_id
                         LEFT JOIN ttr_sla AS sla ON ct.ticket_type = sla.ticket_type 
                                                AND (ct.ticket_sub_type = sla.ticket_sub_type OR sla.ticket_sub_type is NULL)
                                                AND (ct.priority = sla.priority OR sla.priority is NULL)
                         LEFT JOIN jsm_assignee_count as jac ON djct.issue_id = jac.issue_id
                         LEFT JOIN jsm_worklog_agg as jwa ON djct.issue_id = jwa.issue_id
                         LEFT JOIN time_in_consultation as tic ON djct.issue_id = tic.issue_id
                         LEFT JOIN ct_first_assignment_count fac ON djct.issue_id = fac.issue_id
                         LEFT JOIN time_to_engage tte ON djct.issue_id = tte.issue_id
    )
;


  