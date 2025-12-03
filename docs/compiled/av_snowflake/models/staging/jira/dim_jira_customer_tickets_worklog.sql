WITH dim_cust_tickets AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets
)
select issue_id
    ,worklog.value:id::VARCHAR AS id
    ,worklog.value:author:accountId::VARCHAR AS author_account_id
    ,worklog.value:author:displayName::VARCHAR AS author_display_name
    ,worklog.value:timeSpentSeconds::INT AS time_spent_seconds
    ,concat(substring(worklog.value:created,0,len(worklog.value:created)-2),':',substring(worklog.value:created,len(worklog.value:created)-1,len(worklog.value:created)))::TIMESTAMP_TZ as created
    ,concat(substring(worklog.value:started,0,len(worklog.value:started)-2),':',substring(worklog.value:started,len(worklog.value:started)-1,len(worklog.value:started)))::TIMESTAMP_TZ as started
    ,concat(substring(worklog.value:updated,0,len(worklog.value:updated)-2),':',substring(worklog.value:updated,len(worklog.value:updated)-1,len(worklog.value:updated)))::TIMESTAMP_TZ as updated

from dim_cust_tickets ct,
        LATERAL FLATTEN( INPUT => ct.worklog:worklogs ) AS worklog