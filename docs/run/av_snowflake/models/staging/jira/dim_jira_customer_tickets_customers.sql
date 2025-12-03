
  create or replace   view AV_EDM.AV_STAGING.dim_jira_customer_tickets_customers
  
  
  
  
  as (
    WITH dim_cust_tickets AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets
)
select issue_id
    ,customer.value:id::INT as customer_option_id
    ,customer.value:value::VARCHAR as customer_name
from dim_cust_tickets,
        LATERAL FLATTEN( INPUT => customers ) AS customer
  );

