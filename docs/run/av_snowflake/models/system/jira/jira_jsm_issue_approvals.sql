
  create or replace   view AV_EDM.AV_SYSTEM.jira_jsm_issue_approvals
  
  
  
  
  as (
    WITH jira_jsm_issues AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_jsm_issues
)
SELECT jira_jsm_issues.id AS issue_id
    ,jira_jsm_issues.key AS issue_key
    ,app.value:id::INT AS id
    ,app.value:name::VARCHAR AS name
    ,app.value:finalDecision::VARCHAR as final_decision
    ,concat(substring(app.value:createdDate:iso8601,0,len(app.value:createdDate:iso8601)-2),':',substring(app.value:createdDate:iso8601,len(app.value:createdDate:iso8601)-1,len(app.value:createdDate:iso8601)))::TIMESTAMP_TZ AS created_date
    ,concat(substring(app.value:completedDate:iso8601,0,len(app.value:completedDate:iso8601)-2),':',substring(app.value:completedDate:iso8601,len(app.value:completedDate:iso8601)-1,len(app.value:completedDate:iso8601)))::TIMESTAMP_TZ AS completed_date
    ,app.value:approvers AS approvers
FROM jira_jsm_issues,
    LATERAL FLATTEN( INPUT => fields:customfield_10041 ) AS app
  );

