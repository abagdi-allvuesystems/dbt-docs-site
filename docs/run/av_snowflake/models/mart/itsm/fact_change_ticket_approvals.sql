
  
    

create or replace transient table AV_EDM.AV_ITSM.fact_change_ticket_approvals
    
    
    
    as (WITH jira_app AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_change_approvals
), jira_users AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_users where emailaddress is not null
), change_ticket AS (
    SELECT * FROM AV_EDM.AV_ITSM.fact_change_tickets
)
select MD5(a.issue_approval_id) as approval_id
    ,ct.id as change_ticket_id
    ,MD5(u.emailaddress) as decision_employee_id
    ,a.issue_id as system_ticket_id
    ,a.issue_key as system_ticket_key
    ,a.approval_name
    ,a.final_decision
    ,a.created_date
    ,a.completed_date
    ,a.decision_time_hours
    ,a.decision_account_display_name
from jira_app a LEFT JOIN jira_users u on a.decision_account_id = u.account_id
                JOIN change_ticket ct on a.issue_id = ct.system_ticket_id
    )
;


  