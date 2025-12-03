
  
    

create or replace transient table AV_EDM.AV_ITSM.dim_customer_tickets_system_agents
    
    
    
    as (WITH dim_jira_customer_tickets AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets
), dim_jira_users AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_users
), cust_ticket_assignees AS (
    SELECT distinct assignee:accountId::varchar as sys_account_id
        ,assignee:accountType::varchar as source_system
    FROM dim_jira_customer_tickets
    where assignee:accountId is not null
)
select MD5(sys_account_id) as agent_id
    ,MD5(ju.emailaddress) as employee_id
    ,cta.sys_account_id as sys_account_id
    ,cta.source_system as source_system
    ,ju.active as is_active
    ,ju.displayName as display_name
    ,ju.emailaddress as email_address
from cust_ticket_assignees cta LEFT JOIN dim_jira_users ju on cta.sys_account_id = ju.account_id
    )
;


  