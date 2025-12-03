
  
    

create or replace transient table AV_EDM.AV_ITSM.fact_customer_ticket_worklogs
    
    
    
    as (WITH dim_customer_tickets as (
    select * from AV_EDM.AV_ITSM.dim_customer_tickets
), dim_jira_customer_tickets_worklog AS (
    SELECT * from AV_EDM.AV_STAGING.dim_jira_customer_tickets_worklog
)
select MD5(ctw.author_account_id) as agent_id
    ,ct.id as customer_ticket_id
    ,MD5(ct.id) as worklog_id
    ,'jira' as source_system
    ,ctw.author_account_id as author_sys_account_id
    ,ctw.author_display_name as author_sys_display_name
    ,ctw.time_spent_seconds as time_spent_seconds
    ,ROUND(ctw.time_spent_seconds / 60.0 / 60.0, 2) as time_spent_hours
    ,ctw.started as start_time
    ,ctw.created as sys_created
    ,ctw.updated as sys_updated
from dim_customer_tickets ct JOIN dim_jira_customer_tickets_worklog ctw on ct.system_ticket_id = ctw.issue_id and ct.source_system = 'jira'
    )
;


  