
  
    

create or replace transient table AV_EDM.AV_STAGING.dim_jira_workitems_parent
    
    
    
    as (

WITH workitems_current_parent AS (
    SELECT 
            issue_id
            ,parent_issue_id as parent_issue_id
            ,sys_created

    FROM AV_EDM.AV_STAGING.dim_jira_workitems
), changelog_parent as (
    select  issue_id
            ,history_id
            ,sys_created
            ,account_id
            ,account_display_name
            ,from_id
            ,to_id
    from AV_EDM.AV_SYSTEM.jira_issue_changelog 
    where field_name = 'IssueParentAssociation'
), changelog_row_num AS (
    SELECT 
            ISSUE_ID
            ,ROW_NUMBER() OVER (PARTITION BY ISSUE_ID ORDER BY SYS_CREATED) AS ROW_NUMBER_ASC
            ,LEAD(SYS_CREATED) OVER (PARTITION BY ISSUE_ID ORDER BY SYS_CREATED) AS LEAD
            ,LAG(SYS_CREATED) OVER (PARTITION BY ISSUE_ID ORDER BY SYS_CREATED) AS LAG
            ,SYS_CREATED
            ,from_id
            ,to_id

    FROM changelog_parent
), parent_hist AS (
    SELECT 
            crn.issue_id
            ,COALESCE(crn.LAG,wc.sys_created) AS effective_date_start
            ,crn.sys_created AS effective_date_end
            ,crn.from_id as parent_issue_id

    FROM changelog_row_num crn JOIN workitems_current_parent wc ON crn.issue_id = wc.issue_id
), latest_change AS (
    SELECT 
            issue_id
            ,MAX(SYS_CREATED) AS latest_change

    FROM changelog_parent
    GROUP BY issue_id
), current_issue_parent AS (
    SELECT 
            cwp.issue_id
            ,COALESCE(lc.latest_change,cwp.sys_created) AS effective_date_start
            ,'9999-12-31'::TIMESTAMP_TZ AS effective_date_end
            ,cwp.parent_issue_id as parent_issue_id
            
    FROM workitems_current_parent cwp LEFT JOIN latest_change lc ON cwp.issue_id = lc.issue_id
)

SELECT
        issue_id::INT as issue_id
        ,parent_issue_id::INT as parent_issue_id
        ,effective_date_start
        ,effective_date_end

FROM 
        current_issue_parent

UNION

SELECT
        issue_id::INT as issue_id
        ,parent_issue_id::INT as parent_issue_id
        ,effective_date_start
        ,effective_date_end

FROM 
        parent_hist
    )
;


  