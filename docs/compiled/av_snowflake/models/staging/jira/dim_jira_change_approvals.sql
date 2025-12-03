WITH dim_jira_change_tickets AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_change_tickets
), jsm_approvals AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_jsm_issue_approvals
), jsm_approvers AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_jsm_issue_approval_approvers
), full_set AS (
SELECT app.issue_id as issue_id
    ,app.issue_key as issue_key
    ,app.id as approval_id
    ,app.name as approval_name
    ,app.final_decision as final_decision
    ,app.created_date as created_date
    ,app.completed_date as completed_date
    ,apr.account_id as account_id
    ,apr.account_display_name as account_display_name
    ,apr.decision as decision
    ,row_number() OVER (partition by approval_id order by approval_id) as rn
FROM dim_jira_change_tickets dct JOIN jsm_approvals app ON dct.issue_id = app.issue_id
                                 JOIN jsm_approvers apr on app.id = apr.issue_approval_id
where app.final_decision = apr.decision
)
select issue_id
    ,issue_key
    ,approval_id as issue_approval_id
    ,approval_name
    ,final_decision
    ,created_date
    ,completed_date
    ,ROUND(DATEDIFF(s,created_date,completed_date) / 60.0 / 60.0,2) as decision_time_hours
    ,account_id as decision_account_id
    ,account_display_name as decision_account_display_name
from full_set
where rn = 1