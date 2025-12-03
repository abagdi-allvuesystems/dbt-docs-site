
  
    

create or replace transient table AV_EDM.AV_ITSM.customer_tickets_issue_links
    
    
    
    as (WITH dim_cust_tickets AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets
)
select issue_id as issue_id
    ,issue_key as issue_key
    ,issue_links.value:id::int as issue_link_id
    ,COALESCE(issue_links.value:outwardIssue:id,issue_links.value:inwardIssue:id)::int as linked_issue_id
    ,COALESCE(issue_links.value:outwardIssue:key,issue_links.value:inwardIssue:key)::VARCHAR as linked_issue_key
    ,CASE WHEN issue_links.value:outwardIssue:fields is not null then 'outward'
          WHEN issue_links.value:inwardIssue:fields is not null then 'inward' END as link_direction
    ,issue_links.value:type:id::int as issue_link_type_id
    ,issue_links.value:type:inward::varchar as issue_link_type_direction_inward_name
    ,issue_links.value:type:outward::varchar as issue_link_type_direction_outward_name
from dim_cust_tickets,
        LATERAL FLATTEN( INPUT => issue_links ) AS issue_links
    )
;


  