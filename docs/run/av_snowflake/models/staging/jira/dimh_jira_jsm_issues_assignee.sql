
  
    

create or replace transient table AV_EDM.AV_STAGING.dimh_jira_jsm_issues_assignee
    
    
    
    as (

WITH issues_current_assignee AS (
    SELECT 
            id as issue_id
            ,fields:assignee:accountId::VARCHAR as assignee_account_id
            ,fields:assignee:displayName::VARCHAR as assignee_display_name
            ,sys_created
    FROM AV_EDM.AV_SYSTEM.jira_jsm_issues
), changelog_assignee as (
    select  issue_id
            ,history_id
            ,sys_created
            ,account_id
            ,account_display_name
            ,from_id
            ,to_id
            ,from_string
            ,to_string
            ,field_name
    from AV_EDM.AV_SYSTEM.jira_jsm_issue_changelog 
    where field_name = 'assignee'
), changelog_row_num AS (
    SELECT 
            ISSUE_ID
            ,ROW_NUMBER() OVER (PARTITION BY ISSUE_ID ORDER BY SYS_CREATED) AS ROW_NUMBER_ASC
            ,LEAD(SYS_CREATED) OVER (PARTITION BY ISSUE_ID ORDER BY SYS_CREATED) AS LEAD
            ,LAG(SYS_CREATED) OVER (PARTITION BY ISSUE_ID ORDER BY SYS_CREATED) AS LAG
            ,SYS_CREATED
            ,from_id
            ,to_id
            ,from_string
            ,to_string
    FROM changelog_assignee
), assignee_hist AS (
    SELECT 
            crn.issue_id
            ,COALESCE(crn.LAG,wc.sys_created) AS effective_date_start
            ,crn.sys_created AS effective_date_end
            ,crn.from_id as assignee_account_id
            ,crn.from_string as assignee_display_name

    FROM changelog_row_num crn JOIN issues_current_assignee wc ON crn.issue_id = wc.issue_id
), latest_change AS (
    SELECT 
            issue_id
            ,MAX(SYS_CREATED) AS latest_change

    FROM changelog_assignee
    GROUP BY issue_id
), current_issue_assignee AS (
    SELECT 
            ics.issue_id
            ,COALESCE(lc.latest_change,ics.sys_created) AS effective_date_start
            ,'9999-12-31'::TIMESTAMP_TZ AS effective_date_end
            ,ics.assignee_account_id as assignee_account_id
            ,ics.assignee_display_name as assignee_display_name
            
    FROM issues_current_assignee ics LEFT JOIN latest_change lc ON ics.issue_id = lc.issue_id
)

SELECT
        issue_id::INT as issue_id
        ,assignee_account_id as assignee_account_id
        ,assignee_display_name
        ,effective_date_start
        ,effective_date_end

FROM 
        current_issue_assignee

UNION

SELECT
        issue_id::INT as issue_id
        ,assignee_account_id as assignee_account_id
        ,assignee_display_name
        ,effective_date_start
        ,effective_date_end

FROM 
        assignee_hist
    )
;


  