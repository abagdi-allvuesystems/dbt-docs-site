WITH dim_jira_change_affected_services as (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_change_affected_services
), change_tickets AS (
    SELECT * FROM AV_EDM.AV_ITSM.fact_change_tickets
), dim_services AS (
    SELECT * FROM AV_EDM.AV_ITSM.dim_services
)
SELECT MD5(CONCAT(ct.id,ds.id)) AS id 
    ,ct.id as change_ticket_id
    ,ds.id as service_id
FROM change_tickets ct JOIN dim_jira_change_affected_services cas ON ct.system_ticket_id = cas.issue_id
                       LEFT JOIN dim_services ds ON ds.jsm_service_id = cas.affected_services_id