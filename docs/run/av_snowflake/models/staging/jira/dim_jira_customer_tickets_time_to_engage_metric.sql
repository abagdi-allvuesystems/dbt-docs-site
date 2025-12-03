
  create or replace   view AV_EDM.AV_STAGING.dim_jira_customer_tickets_time_to_engage_metric
  
  
  
  
  as (
    WITH dim_jira_customer_tickets_time_in_status AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets_time_in_status
)
select issue_id
    ,SUM(time_in_status_hours) as time_to_engage
from dim_jira_customer_tickets_time_in_status tis
where workflow_status_name in ('Open','Triaging')
group by issue_id
  );

