
  create or replace   view AV_EDM.AV_STAGING.dim_jira_change_labels
  
  
  
  
  as (
    WITH dim_jira_change_tickets AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_change_tickets
)
SELECT issue_id
    ,issue_key
    ,VALUE::VARCHAR AS label_name
FROM dim_jira_change_tickets,
        LATERAL FLATTEN(INPUT => dim_jira_change_tickets.labels)
  );

