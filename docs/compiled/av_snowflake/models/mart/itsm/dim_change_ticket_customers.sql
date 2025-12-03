WITH jira_change_tickets_customers AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_change_customers
),sys_map AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_av_customer_system_mapping
), change_tickets AS (
    SELECT * FROM AV_EDM.AV_ITSM.fact_change_tickets
)
select MD5(CONCAT(ct.id,sm.av_customer_id)) as id
    ,ct.id as change_ticket_id
    ,sm.av_customer_id as customer_id
    ,jtc.customer_field_option_value as change_ticket_customer_name
from jira_change_tickets_customers jtc LEFT JOIN sys_map sm ON jtc.customer_field_option_id = sm.jira_customer_field_id
                                       LEFT JOIN change_tickets ct on jtc.issue_id = ct.system_ticket_id and source_system = 'jira'