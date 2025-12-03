WITH dim_jira_customer_tickets_consultations AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets_consultations
), dim_customer_tickets AS (
    SELECT * FROM AV_EDM.AV_ITSM.dim_customer_tickets
), internal_tickets_time_in_status AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_internal_tickets_time_in_status 
), time_in_pending AS (
    SELECT issue_id as issue_id
       ,SUM(time_in_status_hours) as time_in_status_hours
    FROM internal_tickets_time_in_status
    WHERE workflow_status_name in ('Pending','Pending Client','Pending Release','Awaiting Approval','Waiting for Approval')
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
)
select MD5(ctc.issue_id) as id
    ,ct.id as customer_ticket_id
    ,ctc.issue_id as source_system_id
    ,ctc.issue_key as source_system_key
    ,'jira' as source_system
    ,ctc.reporter_user_display_name as reporter_display_name
    ,ctc.assignee_user_display_name as assignee_display_name
    ,ctc.assignment_group_name as assgined_team_name
    ,ctc.status_name as status
    ,ctc.priority_name as priority
    ,ctc.time_to_first_response_elapsed_days
    ,ctc.time_to_first_response_goal_days
    ,ctc.time_to_resolution_elapsed_days
    ,ctc.time_to_resolution_goal_days
    ,sla.sla_target_hours AS time_to_resolution_target_hours
    ,ROUND(
         COALESCE(DATEDIFF(s, ctc.sys_created, ctc.resolution_date), 0)::INT / (60 * 60), 2
      ) - IFNULL(tip.time_in_status_hours, 0) AS time_to_resolution_hours
    ,CASE WHEN sla.sla_target_hours is NULL then NULL
          WHEN ROUND(DATEDIFF(s,ct.sys_created,ct.resolution_date)::INT / (60 * 60 ), 2) - IFNULL(tip.time_in_status_hours,0) <= 
                        sla.sla_target_hours THEN true
          ELSE false END::BOOLEAN as time_to_resolution_sla_met
    ,ROUND(ROUND(DATEDIFF(s,ct.sys_created,ct.resolution_date)::INT / (60 * 60 ), 2) - IFNULL(tip.time_in_status_hours,0)) 
        / NULLIF(sla.sla_target_hours,0) AS time_to_resolution_percent_of_target
    ,ROUND(ctc.time_to_resolution:completedCycles[0]:elapsedTime:millis::INT / (1000 * 60 * 60), 2) as time_to_resolution_internal_sla_hours
    ,ROUND(ctc.time_to_resolution:completedCycles[0]:goalDuration:millis::INT / (1000 * 60 * 60), 2) as time_to_resolution_internal_sla_target_hours
    ,CASE WHEN ROUND(ctc.time_to_resolution:completedCycles[0]:goalDuration:millis::INT / (1000 * 60 * 60), 2) is NULL then NULL
          WHEN ROUND(ctc.time_to_resolution:completedCycles[0]:goalDuration:millis::INT / (1000 * 60 * 60), 2) >= 
                        ROUND(ctc.time_to_resolution:completedCycles[0]:elapsedTime:millis::INT / (1000 * 60 * 60), 2) THEN true
          ELSE false END::BOOLEAN as time_to_resolution_internal_sla_met
    ,ROUND(ctc.time_to_resolution:completedCycles[0]:elapsedTime:millis::INT / (1000 * 60 * 60), 2) 
        / NULLIF(ROUND(ctc.time_to_resolution:completedCycles[0]:goalDuration:millis::INT / (1000 * 60 * 60), 2),0) AS time_to_resolution_internal_sla_percent_of_target
    ,ctc.resolution_date as resolution_date
    ,ctc.consultation_rejection_reason as rejection_reason
    ,ctc.cause as cause
    ,ctc.sys_created as created
    ,ctc.sys_updated as updated
from dim_jira_customer_tickets_consultations ctc JOIN dim_customer_tickets ct on ct.system_ticket_id = ctc.jira_cust_ticket_issue_id and source_system = 'jira'
                                                 LEFT JOIN time_in_pending as tip ON ctc.issue_id = tip.issue_id
                                                 LEFT JOIN ttr_sla AS sla ON ct.ticket_type = sla.ticket_type 
                                                            AND (ct.ticket_sub_type = sla.ticket_sub_type OR sla.ticket_sub_type is NULL)
                                                            AND (ct.priority = sla.priority OR sla.priority is NULL)