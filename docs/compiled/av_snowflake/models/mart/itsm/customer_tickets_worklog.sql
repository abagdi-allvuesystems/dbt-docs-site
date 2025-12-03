WITH dim_cust_tickets AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets
)
select issue_id
    ,worklogs.value:author:accountId::VARCHAR as author_account_id
    ,worklogs.value:author:displayName::VARCHAR as author_display_name
    ,concat(substring(worklogs.value:created,0,len(worklogs.value:created)-2),':',substring(worklogs.value:created,len(worklogs.value:created)-1,len(worklogs.value:created)))::TIMESTAMP_TZ as created
    ,concat(substring(worklogs.value:started,0,len(worklogs.value:started)-2),':',substring(worklogs.value:started,len(worklogs.value:started)-1,len(worklogs.value:started)))::TIMESTAMP_TZ as started
    ,concat(substring(worklogs.value:updated,0,len(worklogs.value:updated)-2),':',substring(worklogs.value:updated,len(worklogs.value:updated)-1,len(worklogs.value:updated)))::TIMESTAMP_TZ as updated
    ,worklogs.value:timeSpentSeconds as time_spent_seconds
    ,ROUND(worklogs.value:timeSpentSeconds / (60 * 60),2) as time_spent_hours
from dim_cust_tickets,
        LATERAL FLATTEN( INPUT => worklog:worklogs ) AS worklogs