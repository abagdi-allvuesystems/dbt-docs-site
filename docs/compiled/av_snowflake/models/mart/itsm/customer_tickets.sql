WITH dim_cust_tickets AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets
), customer_tickets_time_in_status AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets_time_in_status
), time_in_pending AS (
    SELECT issue_id as issue_id
        ,SUM(time_in_status_hours) as time_in_status_hours
    FROM customer_tickets_time_in_status
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
), derived_type_subtype AS (
    SELECT 
        issue_id
        ,CASE WHEN request_type_name = 'User Access Request' THEN NULL
            ELSE priority_name END AS priority
        ,CASE
            WHEN ticket_type = 'Incident' AND issue_type_name = '[System] Service request' THEN 'Service Request'
            WHEN ticket_type = 'Incident' AND issue_type_name = '[System] Incident' THEN 'Incident'
            WHEN ticket_type IS NULL AND issue_type_name = '[System] Incident' THEN 'Incident'
            WHEN ticket_type IS NULL AND issue_type_name = '[System] Service request' THEN 'Service Request'
            WHEN ticket_type = 'Service Request' AND issue_type_name = '[System] Incident' THEN 'Service Request'
            WHEN ticket_type = 'Service Request' AND issue_type_name = '[System] Service request' THEN 'Service Request'
            ELSE NULL 
        END as DERIVED_TICKET_TYPE
        ,CASE WHEN request_type_name = 'User Access Request' THEN 'User Access'
                ELSE NULL END as DERIVED_TICKET_SUB_TYPE
    FROM dim_cust_tickets
), ticket_sla AS (
    SELECT dts.issue_id
        ,dts.priority AS priority
        ,dts.DERIVED_TICKET_TYPE
        ,dts.DERIVED_TICKET_SUB_TYPE
        ,ts.sla_target_hours
        ,ROUND(ts.sla_target_hours / 24, 2) AS sla_target_days
    FROM derived_type_subtype dts LEFT JOIN ttr_sla ts ON (dts.priority = ts.priority OR (dts.priority IS NULL AND ts.priority IS NULL))
                                                    AND dts.DERIVED_TICKET_TYPE = ts.ticket_type
                                                    AND (dts.DERIVED_TICKET_SUB_TYPE = ts.ticket_sub_type 
                                                    OR (dts.DERIVED_TICKET_SUB_TYPE IS NULL AND ts.ticket_sub_type IS NULL))
),resolved_tickets AS (
     SELECT issue_id
        ,MIN(sys_created) AS sys_created
        ,resolution_date
     FROM dim_cust_tickets where resolution_date is not null
     GROUP BY issue_id, resolution_date
),cust_agg AS (
    select issue_id
        ,COUNT(distinct customer_field_id) as customer_count
        ,LISTAGG(customer_field_name, '; ') as customer_concat
    from AV_EDM.AV_ITSM.customer_tickets_customers
    group by issue_id
), worklog_agg AS (
    select issue_id
        ,SUM(time_spent_hours) as time_logged_hours
    from AV_EDM.AV_ITSM.customer_tickets_worklog
    group by issue_id
), sys_gen_users AS (
    SELECT * 
    FROM AV_EDM.AV_ITSM.jira_users_all
    where is_system_generated_user = true
), derived_sys_gens AS (
    SELECT dct.issue_id
            ,dct.system_generated_ticket as sys_gen_field
            ,sgu.account_id as account_id
            ,dct.status_name as status
            ,CASE WHEN system_generated_ticket is null AND sgu.account_id is not null THEN true
              WHEN system_generated_ticket is null AND sgu.account_id is null THEN false
              ELSE system_generated_ticket END as derived_system_generated_ticket
    FROM dim_cust_tickets dct LEFT JOIN sys_gen_users sgu on dct.reporter:accountId::VARCHAR = sgu.account_id
)
SELECT MD5(t.issue_id) AS id
        ,'jira' as source_system
        ,t.issue_id as issue_id
        ,t.issue_key as issue_key
        ,t.issue_links as issue_links
        ,t.issue_type_name as issue_type
        ,t.request_type_name as request_type
        ,t.summary as summary
        ,t.assignment_group_name as assignment_group
        ,t.assignee:accountId::VARCHAR as assignee_account_id
        ,t.assignee:displayName::VARCHAR as assignee_display_name
        ,t.reporter:accountId::VARCHAR as reporter_account_id
        ,t.reporter:displayName::VARCHAR as reporter_display_name
        ,t.status_name AS status
        ,t.status_name as status_category
        ,dsg.derived_system_generated_ticket as system_generated_ticket
        ,CASE WHEN dsg.derived_system_generated_ticket = true and t.status_name = 'Canceled' THEN FALSE
                ELSE TRUE END as is_client_reportable_ticket
        ,t.priority_name AS priority
        ,t.product_area as product_area
        ,t.product_sub_area as product_sub_area
        ,t.product_base_area as product_base_area
        ,t.ticket_type as ticket_type
        ,sla.DERIVED_TICKET_TYPE
        ,sla.DERIVED_TICKET_SUB_TYPE
        ,t.consultation_assignment_group_name as consultation_assignment_group
        ,t.pending_reason:value as pending_reason
        ,cust.customer_count as count_customers
        ,cust.customer_concat as customers
        ,t.cause as cause
        ,t.resolution as resolution
        ,CASE WHEN cause = 'Allvue-Caused' THEN 'Process Related'
              WHEN cause = 'Client Caused' THEN 'Preventable Case'
              WHEN cause = 'Report Code Change' THEN 'Request'
              WHEN cause = 'Upgrade Defect​' THEN 'Upgrade Issue'
              ELSE cause
         END as cause_client_alias
        --,ROUND(time_to_resolution:completedCycles[0]:elapsedTime:millis::INT / (1000 * 60 * 60 * 24), 2) as time_to_resolution_elapsed_days
        ,ROUND(((DATEDIFF(s,rt.sys_created,rt.resolution_date)::INT / (60 * 60 * 24)) - (IFNULL(tip.time_in_status_hours,0)/24)),2) AS time_to_resolution_elapsed_days
        --,ROUND(time_to_resolution:completedCycles[0]:goalDuration:millis::INT / (1000 * 60 * 60 * 24), 2) as time_to_resolution_goal_days
        ,sla.sla_target_days AS time_to_resolution_goal_days
        ,ROUND(DATEDIFF(s,t.sys_created,t.resolution_date)::INT / (60 * 60 * 24), 2) as time_to_close_days
        ,t.sys_created as sys_created
        ,t.sys_updated as sys_updated
        ,t.resolution_date as resolution_date
        ,t.restored as restored_date
        ,wa.time_logged_hours
        ,t.description as description
        ,t.additional_comments as additional_comments
FROM dim_cust_tickets t
            LEFT JOIN cust_agg cust on t.issue_id = cust.issue_id
            LEFT JOIN worklog_agg wa on t.issue_id = wa.issue_id
            LEFT JOIN derived_sys_gens dsg on t.issue_id = dsg.issue_id
            LEFT JOIN time_in_pending tip on t.issue_id = tip.issue_id
            LEFT JOIN resolved_tickets rt on t.issue_id = rt.issue_id
            LEFT JOIN ticket_sla AS sla ON t.issue_id = sla.issue_id