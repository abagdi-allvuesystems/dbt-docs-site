WITH jsm_assignee_name AS (
    SELECT * FROM AV_EDM.AV_STAGING.dimh_jira_jsm_issues_assignee
), customer_tickets AS (
    SELECT * FROM AV_EDM.AV_ITSM.dim_customer_tickets where resolution_date is not null
)
 SELECT ct.id as customer_ticket_id
        ,jan.issue_id as issue_id
        ,jan.assignee_display_name as assignee_display_name
    FROM customer_tickets ct LEFT JOIN jsm_assignee_name jan on jan.issue_id = ct.system_ticket_id