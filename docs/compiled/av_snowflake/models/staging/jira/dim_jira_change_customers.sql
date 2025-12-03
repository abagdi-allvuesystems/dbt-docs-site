WITH dim_jira_change_tickets AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_change_tickets
)
SELECT issue_id AS issue_id
    ,issue_key AS issue_key
    ,cust.value:id::INT as customer_field_option_id
    ,cust.value:value::VARCHAR as customer_field_option_value
FROM dim_jira_change_tickets,
    LATERAL FLATTEN( INPUT => customer_field ) AS cust