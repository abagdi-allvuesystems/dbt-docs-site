WITH dim_jira_cust_tickets AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_internal_tickets
), dim_jira_cust_tickets_labels AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets_labels
), dim_jira_cust_tickets_customers AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets_customers
), jira_customers_names_agg AS (
    SELECT issue_id
        ,LISTAGG(customer_name, '; ') as sys_customer_names
    FROM dim_jira_cust_tickets_customers
    GROUP BY issue_id
)/*, major_incidents AS (
    SELECT issue_id
    FROM dim_jira_cust_tickets_labels
    WHERE label_name = 'Major_Inc'
)*/, sys_gen_users AS (
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
    FROM dim_jira_cust_tickets dct LEFT JOIN sys_gen_users sgu on dct.reporter:accountId::VARCHAR = sgu.account_id
)
SELECT MD5(jct.issue_id) AS id
        ,'jira' AS source_system
        ,jct.issue_id AS system_ticket_id
        ,jct.issue_key AS system_ticket_key
        ,jct.summary AS summary
        ,jct.priority_name AS priority
        /*,CASE WHEN dsg.derived_system_generated_ticket = true THEN 'system_generated'
              WHEN dsg.derived_system_generated_ticket = false AND jct.reporter_user_display_name = 'allvue jira integration' THEN 'system_generated'
              WHEN dsg.derived_system_generated_ticket = false AND request_type_name = 'Emailed request' THEN 'user_emailed'
              WHEN dsg.derived_system_generated_ticket = false AND request_type_name = 'Report an Issue' THEN 'user_portal'
              WHEN dsg.derived_system_generated_ticket = false AND request_type_name = 'User Access Request' THEN 'user_portal' 
         END AS creation_type --system generated, email, portal*/
        ,CASE
            WHEN jct.ticket_type = 'Incident' AND jct.issue_type_name = '[System] Service request' THEN 'Service Request'
            WHEN jct.ticket_type = 'Incident' AND jct.issue_type_name = '[System] Incident' THEN 'Incident'
            WHEN jct.ticket_type IS NULL AND jct.issue_type_name = '[System] Incident' THEN 'Incident'
            WHEN jct.ticket_type IS NULL AND jct.issue_type_name = '[System] Service request' THEN 'Service Request'
            WHEN jct.ticket_type = 'Service Request' AND jct.issue_type_name = '[System] Incident' THEN 'Service Request'
            WHEN jct.ticket_type = 'Service Request' AND jct.issue_type_name = '[System] Service request' THEN 'Service Request'
            ELSE NULL
         END::VARCHAR as TICKET_TYPE
        /*,CASE WHEN jct.request_type_name = 'User Access Request' THEN 'User Access'
                ELSE NULL END::VARCHAR as TICKET_SUB_TYPE
        ,CASE WHEN mi.issue_id IS NOT NULL THEN true END::BOOLEAN AS is_major_incident*/
        ,jct.assignee_user_display_name as assigned_name
        ,reporter_user_display_name AS assigned_reporter_name
        ,MD5(jct.assignee:accountId::varchar) as agent_id
        ,jct.assignment_group_name as assigned_team_name
        ,CASE WHEN jct.initial_consultation IS NOT NULL THEN TRUE ELSE FALSE END AS had_consultation
        ,jct.consultation_assignment_group_name AS last_consultation_team_name
        ,jct.product_base_area
        ,jct.product_area
        ,jct.product_sub_area
        ,j_cust_agg.sys_customer_names as system_customer_names
        ,CASE WHEN jct.assignment_group_name in ('Credit Customer Support','Credit Cloud Ops') THEN 'Credit'
              WHEN jct.assignment_group_name in ('Equity Customer Support','Fund Admin Team','Equity Cloud Ops') THEN 'Equity'
              WHEN (jct.assignment_group_name = 'Customer Support' OR jct.assignment_group_name is null) AND jct.product_base_area = 'Credit' THEN 'Credit'
              WHEN (jct.assignment_group_name = 'Customer Support' OR jct.assignment_group_name is null) AND jct.product_base_area = 'Equity' THEN 'Equity'
              WHEN jct.assignment_group_name = 'KCS Team' THEN jct.product_base_area
         END as support_vertical
        ,jct.status_name as status
        ,CASE WHEN status_name in ('Open') THEN 'Open'
              WHEN status_name in ('Pending','Pending Client','Pending Release','Awaiting Approval','Waiting for Approval') THEN 'Pending Client'
              WHEN status_name in ('Canceled','Declined','Rejected') THEN 'Canceled'
              WHEN status_name in ('Assigned', 'Consultation','In Progress','Triaging','User Under Review') THEN 'In Progress'
              WHEN status_name in ('Client Resolved','Closed','Completed','Resolved') THEN 'Resolved'
         END::VARCHAR as status_category
        ,jct.cause as cause
        ,jct.resolution as resolution
        /*,CASE WHEN jct.cause = 'Allvue-Caused' THEN 'Process Related'
              WHEN jct.cause = 'Client Caused' THEN 'Preventable Case'
              WHEN jct.cause = 'Report Code Change' THEN 'Request'
              WHEN jct.cause = 'Upgrade Defect' THEN 'Upgrade Issue'
              WHEN jct.cause = 'Access Management' THEN 'Access'
              WHEN jct.cause = 'Database' THEN 'Database Administration'
              ELSE jct.cause
         END as cause_client_alias*/
        ,sys_created as sys_created
        ,sys_updated as sys_updated
        ,resolution_date as resolution_date
        ,restored as restored_date
FROM dim_jira_cust_tickets jct LEFT JOIN jira_customers_names_agg j_cust_agg ON j_cust_agg.issue_id = jct.issue_id
                               LEFT JOIN derived_sys_gens dsg ON jct.issue_id = dsg.issue_id