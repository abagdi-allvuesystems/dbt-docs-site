
  create or replace   view AV_EDM.AV_STAGING.dim_jira_customer_tickets_labels
  
  
  
  
  as (
    WITH dim_jira_customer_tickets AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets
)
SELECT issue_id
    ,VALUE::VARCHAR as label_name
FROM dim_jira_customer_tickets,
        LATERAL FLATTEN(INPUT => dim_jira_customer_tickets.labels)
  );

