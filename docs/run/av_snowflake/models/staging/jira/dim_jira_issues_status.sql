
  
    

create or replace transient table AV_EDM.AV_STAGING.dim_jira_issues_status
    
    
    
    as (

WITH issues_current_status AS (
    SELECT 
            id as issue_id
            ,fields:status:id::INT as status_id
            ,fields:status:name::VARCHAR as status_name
            ,sys_created
    FROM AV_EDM.AV_SYSTEM.jira_issues
), changelog_status as (
    select  issue_id
            ,history_id
            ,sys_created
            ,account_id
            ,account_display_name
            ,from_id
            ,to_id
            ,from_string
            ,to_string
    from AV_EDM.AV_SYSTEM.jira_issue_changelog 
    where field_name = 'status'
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
    FROM changelog_status
), status_hist AS (
    SELECT 
            crn.issue_id
            ,COALESCE(crn.LAG,wc.sys_created) AS effective_date_start
            ,crn.sys_created AS effective_date_end
            ,crn.from_id as status_id
            ,crn.from_string as status_name

    FROM changelog_row_num crn JOIN issues_current_status wc ON crn.issue_id = wc.issue_id
), latest_change AS (
    SELECT 
            issue_id
            ,MAX(SYS_CREATED) AS latest_change

    FROM changelog_status
    GROUP BY issue_id
), current_issue_status AS (
    SELECT 
            ics.issue_id
            ,COALESCE(lc.latest_change,ics.sys_created) AS effective_date_start
            ,'9999-12-31'::TIMESTAMP_TZ AS effective_date_end
            ,ics.status_id as status_id
            ,ics.status_name as status_name
            
    FROM issues_current_status ics LEFT JOIN latest_change lc ON ics.issue_id = lc.issue_id
)

SELECT
        issue_id::INT as issue_id
        ,status_id::INT as status_id
        ,status_name
        ,effective_date_start
        ,effective_date_end

FROM 
        current_issue_status

UNION

SELECT
        issue_id::INT as issue_id
        ,status_id::INT as status_id
        ,status_name
        ,effective_date_start
        ,effective_date_end

FROM 
        status_hist
    )
;


  