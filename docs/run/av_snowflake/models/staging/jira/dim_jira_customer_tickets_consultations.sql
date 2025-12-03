
  create or replace   view AV_EDM.AV_STAGING.dim_jira_customer_tickets_consultations
  
  
  
  
  as (
    WITH jira_jsm_issues AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_jsm_issues
), jira_issues AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_issues
), dim_jira_customer_tickets AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets
), jira_jsm_issue_issuelinks AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_jsm_issue_issuelinks
)
select jji.id as issue_id
    ,jji.key as issue_key
    ,ct.issue_id as jira_cust_ticket_issue_id
    ,ct.issue_key as jira_cust_ticket_issue_key
    ,jji.issue_type_id AS issue_type_id
    ,jji.issue_type_name AS issue_type_name
    ,jji.request_type_id AS request_type_id
    ,jji.request_type_name AS request_type_name
    ,jji.fields:summary::VARCHAR AS summary
    ,jji.fields:reporter AS reporter
    ,jji.fields:reporter:accountId::VARCHAR AS reporter_user_account_id
    ,jji.fields:reporter:displayName::VARCHAR AS reporter_user_display_name
    ,jji.fields:assignee AS assignee
    ,jji.fields:assignee:accountId::VARCHAR AS assignee_user_account_id
    ,jji.fields:assignee:displayName::VARCHAR AS assignee_user_display_name
    ,jji.fields:customfield_10169:id::INT AS assignment_group_option_id
    ,jji.fields:customfield_10169:value::VARCHAR AS assignment_group_name
    ,jji.fields:status:id::INT AS status_id
    ,jji.fields:status:name::VARCHAR AS status_name
    ,jji.fields:priority:name::VARCHAR AS priority_name
    ,jji.fields:customfield_10060 AS time_to_first_response
    ,ROUND(jji.fields:customfield_10060:completedCycles[0]:elapsedTime:millis::INT / (1000 * 60 * 60 * 24), 2) AS time_to_first_response_elapsed_days
    ,ROUND(jji.fields:customfield_10060:completedCycles[0]:goalDuration:millis::INT / (1000 * 60 * 60 * 24), 2) AS time_to_first_response_goal_days
    ,jji.fields:customfield_10059 AS time_to_resolution
    ,ROUND(jji.fields:customfield_10059:completedCycles[0]:elapsedTime:millis::INT / (1000 * 60 * 60 * 24), 2) AS time_to_resolution_elapsed_days
    ,ROUND(jji.fields:customfield_10059:completedCycles[0]:goalDuration:millis::INT / (1000 * 60 * 60 * 24), 2) AS time_to_resolution_goal_days
    ,jji.sys_created AS sys_created
    ,jji.sys_updated AS sys_updated
    ,concat(substring(jji.fields:resolutiondate,0,len(jji.fields:resolutiondate)-2),':',substring(jji.fields:resolutiondate,len(jji.fields:resolutiondate)-1,len(jji.fields:resolutiondate)))::TIMESTAMP_TZ as resolution_date
    ,jji.fields:customfield_10229:value::VARCHAR as consultation_rejection_reason
    ,jji.fields:customfield_10303:value::VARCHAR as cause
from dim_jira_customer_tickets ct JOIN jira_jsm_issue_issuelinks il on ct.issue_id = il.issue_id
                                  join jira_jsm_issues jji on il.linked_issue_id = jji.id
where jji.issue_type_name = 'Incident Consultation' and il.type_id = 10105 and il.direction = 'outward' and jji.request_type_name = 'Incident Consultation - External'
  );

