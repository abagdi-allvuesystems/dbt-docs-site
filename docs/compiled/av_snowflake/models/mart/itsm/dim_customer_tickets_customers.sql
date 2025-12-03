WITH jira_tick_cust AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets_customers
), sys_map AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_av_customer_system_mapping
), cust_tickets AS (
    SELECT * FROM AV_EDM.AV_ITSM.dim_customer_tickets
)
select MD5(CONCAT(ct.id,sm.av_customer_id)) as id
    ,ct.id as customer_ticket_id
    ,sm.av_customer_id as customer_id
    ,jtc.customer_name as customer_ticket_customer_name
from jira_tick_cust jtc LEFT JOIN sys_map sm ON jtc.customer_option_id = sm.jira_customer_field_id
                        LEFT JOIN cust_tickets ct on jtc.issue_id = ct.system_ticket_id and source_system = 'jira'