WITH jira_jsm_issues_approvals AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_jsm_issue_approvals
)
SELECT app.issue_id AS issue_id
    ,app.issue_key AS issue_key
    ,app.id AS issue_approval_id
    ,apr.value:approver:accountId::VARCHAR as account_id
    ,apr.value:approver:displayName::VARCHAR as account_display_name
    ,apr.value:approverDecision::VARCHAR as decision
FROM jira_jsm_issues_approvals app,
    LATERAL FLATTEN( INPUT => approvers ) AS apr