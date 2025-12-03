
  
    

create or replace transient table AV_EDM.AV_ITSM.customer_tickets_consultation
    
    
    
    as (WITH dim_cust_tickets_consultation AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets
)
SELECT
    ct.issue_id AS issue_id,
    ct.issue_key AS issue_key,
    COALESCE(
        NULLIF(PARSE_JSON(il.value):inwardIssue:id::STRING, ''), 
        NULLIF(PARSE_JSON(il.value):outwardIssue:id::STRING, '')
    ) AS consulted_issue_id,
    COALESCE(
        NULLIF(PARSE_JSON(il.value):inwardIssue:key::STRING, ''), 
        NULLIF(PARSE_JSON(il.value):outwardIssue:key::STRING, '')
    ) AS consulted_issue_key,
    COALESCE(
        NULLIF(PARSE_JSON(il.value):type:outward::STRING, ''), 
        NULLIF(PARSE_JSON(il.value):type:inward::STRING, '')
    ) AS consulted_status,
    ct.consultation_assignment_group_name as consultation_assignment_group,
    COALESCE(
        NULLIF(PARSE_JSON(il.value):inwardIssue:fields:summary::STRING, ''), 
        NULLIF(PARSE_JSON(il.value):outwardIssue:fields:summary::STRING, '')
    ) AS consulted_Desc
FROM 
    dim_cust_tickets_consultation ct,
    LATERAL FLATTEN(input => ct.issue_links) il
WHERE consulted_status = 'Consulted By'
    )
;


  