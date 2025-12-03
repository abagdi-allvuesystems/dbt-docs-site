
  create or replace   view AV_EDM.AV_STAGING.dim_jira_change_tickets
  
  
  
  
  as (
    WITH change_issues AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_jsm_issues where issue_type_id = 10122
)

select id AS issue_id
        ,key AS issue_key
        ,request_type_id AS request_type_id
        ,request_type_name AS request_type_name
        ,fields:assignee:accountId::VARCHAR AS assignee_account_id
        ,fields:assignee:displayName::VARCHAR AS assignee_display_name
        ,fields:reporter:accountId::VARCHAR AS reporter_account_id
        ,fields:reporter:displayName::VARCHAR AS reporter_display_name
        ,fields:status:id::NUMBER AS status_id
        ,fields:status:name::VARCHAR AS status_name
        ,fields:status:statusCategory:name::VARCHAR AS status_category_name
        ,sys_created AS sys_created
        ,sys_updated AS sys_updated
        ,concat(substring(fields:resolutiondate,0,len(fields:resolutiondate)-2),':',substring(fields:resolutiondate,len(fields:resolutiondate)-1,len(fields:resolutiondate)))::TIMESTAMP_TZ AS resolution_date
        ,concat(substring(fields:customfield_10009,0,len(fields:customfield_10009)-2),':',substring(fields:customfield_10009,len(fields:customfield_10009)-1,len(fields:customfield_10009)))::TIMESTAMP_TZ AS change_completion_date
        ,concat(substring(fields:customfield_10054,0,len(fields:customfield_10054)-2),':',substring(fields:customfield_10054,len(fields:customfield_10054)-1,len(fields:customfield_10054)))::TIMESTAMP_TZ AS planned_start_date
        ,concat(substring(fields:customfield_10055,0,len(fields:customfield_10055)-2),':',substring(fields:customfield_10055,len(fields:customfield_10055)-1,len(fields:customfield_10055)))::TIMESTAMP_TZ AS planned_end_date
        ,fields:customfield_10169:id::NUMBER AS assignment_group_id
        ,fields:customfield_10169:value::VARCHAR AS assignment_group_name
        ,fields:priority:name::VARCHAR AS priority_name
        ,fields:summary::VARCHAR AS summary
        ,fields:customfield_10116 as customer_field --
        ,fields:labels AS labels --
        ,fields:customfield_10005:value::VARCHAR as change_type
        ,fields:customfield_10006:value::VARCHAR AS change_risk
        ,fields:customfield_10253:value::VARCHAR AS product_base_area
        ,fields:customfield_10048 AS affected_services --
        ,fields:customfield_10025::VARCHAR AS time_in_status
from change_issues ci
  );

