WITH jsm_issues AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_jsm_issues
)
select id AS issue_id
    ,jsm_issues.key AS issue_key
    ,il.value:id::INT AS id
    ,il.value:type:id::INT as type_id
    ,il.value:type:name::VARCHAR as type_name
    ,CASE WHEN il.value:outwardIssue:fields is not null then 'outward'
          WHEN il.value:inwardIssue:fields is not null then 'inward' END as direction
    ,CASE WHEN il.value:outwardIssue:fields is not null then il.value:type:outward::VARCHAR
          WHEN il.value:inwardIssue:fields is not null then il.value:type:inward::VARCHAR END as direction_name
    ,COALESCE(il.value:outwardIssue:id,il.value:inwardIssue:id)::INT as linked_issue_id
    ,COALESCE(il.value:outwardIssue:key,il.value:inwardIssue:key)::VARCHAR as linked_issue_key   
from jsm_issues,
    LATERAL FLATTEN(input => fields:issuelinks) AS il