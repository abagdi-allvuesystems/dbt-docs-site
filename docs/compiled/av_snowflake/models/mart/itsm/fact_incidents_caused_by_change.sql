WITH sys_jira_issues_linked AS (
    SELECT * 
    FROM AV_EDM.AV_SYSTEM.jira_jsm_issue_issuelinks
    WHERE direction_name = 'is caused by'
), cust_tickets_incidents AS (
    SELECT *
    FROM AV_EDM.AV_ITSM.dim_customer_tickets
    WHERE ticket_type = 'Incident'
), change_tickets AS (
    SELECT *
    FROM AV_EDM.AV_ITSM.fact_change_tickets
)
select inc.id as incident_customer_ticket_id
    ,inc.system_ticket_id as incident_system_ticket_id
    ,inc.system_ticket_key as incident_system_ticket_key
    ,ct.id as change_ticket_id
    ,ct.system_ticket_id as change_system_ticket_id
    ,ct.system_ticket_key as change_system_ticket_key
from cust_tickets_incidents inc JOIN sys_jira_issues_linked li on inc.system_ticket_id = li.issue_id
                                JOIN change_tickets ct ON li.linked_issue_id = ct.system_ticket_id