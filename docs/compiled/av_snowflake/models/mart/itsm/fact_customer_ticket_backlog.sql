WITH dim_date AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_date
), dim_cust_tickets AS (
    SELECT * FROM AV_EDM.AV_ITSM.dim_customer_tickets
), cust_tickets  AS (
    SELECT  id as customer_ticket_id
            ,system_ticket_id as issue_id
            ,sys_created
            ,resolution_date
    FROM dim_cust_tickets
), jsm_issue_status AS (
    SELECT *
    FROM AV_EDM.AV_STAGING.dim_jira_jsm_issues_status
), raw_fact AS (
    select d.date
        ,d.first_datetime_of_day
        ,d.last_datetime_of_day
        ,ct.customer_ticket_id
        ,ct.issue_id
        ,ct.sys_created
        ,ct.resolution_date
    from dim_date d JOIN cust_tickets ct ON d.last_datetime_of_day >= ct.sys_created 
                                                AND (d.first_datetime_of_day <= ct.resolution_date OR ct.resolution_date is NULL)
)
select rf.date
    ,rf.customer_ticket_id
    ,rf.issue_id
    ,jis.status_id
    ,jis.status_name
    ,CASE WHEN first_datetime_of_day < sys_created then TRUE else FALSE END AS is_opened
    ,CASE WHEN last_datetime_of_day > resolution_date then TRUE else FALSE END as is_closed
from raw_fact rf LEFT JOIN jsm_issue_status jis ON rf.issue_id = jis.issue_id 
                                                    AND rf.last_datetime_of_day >= jis.effective_date_start
                                                                 AND rf.last_datetime_of_day < jis.effective_date_end
where rf.date >= '1/1/2023' and rf.date <= CURRENT_TIMESTAMP()