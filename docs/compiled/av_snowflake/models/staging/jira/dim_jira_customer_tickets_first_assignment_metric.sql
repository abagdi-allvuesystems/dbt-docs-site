WITH dim_jira_customer_tickets AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_tickets
), dimh_jira_jsm_issues_status AS (
    SELECT * FROM AV_EDM.AV_STAGING.dimh_jira_jsm_issues_status
), dimh_jira_jsm_issues_assignee AS (
    SELECT * FROM AV_EDM.AV_STAGING.dimh_jira_jsm_issues_assignee
), assignee_rn AS (
    SELECT issue_id
        ,status_name
        ,effective_date_start
        ,effective_date_end
        ,ROW_NUMBER() OVER (PARTITION BY issue_id ORDER by effective_date_start ASC) as rn
    from dimh_jira_jsm_issues_status
    where status_name = 'Assigned'
), first_assignement AS (
    SELECT issue_id
        ,effective_date_start
    FROM assignee_rn
    where rn = 1
), ct_dates AS (
    select ct.issue_id
        ,ct.issue_key
        ,ct.sys_created
        ,ct.resolution_date
        ,fa.effective_date_start as first_assignement_date
        ,COALESCE(fa.effective_date_start,ct.sys_created) as derived_first_assignment_date
    from dim_jira_customer_tickets ct LEFT JOIN first_assignement fa on ct.issue_id = fa.issue_id
)
select ct_dates.issue_id
    ,ct_dates.issue_key
    ,COUNT(DISTINCT ahist.assignee_account_id) as count_assignees
from ct_dates LEFT JOIN dimh_jira_jsm_issues_assignee ahist ON ct_dates.issue_id = ahist.issue_id AND ahist.effective_date_start >= ct_dates.derived_first_assignment_date
                                                                                                  AND ahist.effective_date_start <= ct_dates.resolution_date
group by ct_dates.issue_id,ct_dates.issue_key