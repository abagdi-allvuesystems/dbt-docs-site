

WITH workitems_current_story_points AS (
    SELECT 
            issue_id
            ,issue_story_points as story_points
            ,sys_created

    FROM AV_EDM.AV_STAGING.dim_jira_workitems
), changelog_story_points as (
    select issue_id
            ,history_id
            ,sys_created
            ,account_id
            ,account_display_name
            ,from_string
            ,to_string
    from AV_EDM.AV_SYSTEM.jira_issue_changelog 
    where FIELD_ID = 'customfield_10028'
), changelog_row_num AS (
    SELECT 
            ISSUE_ID
            ,ROW_NUMBER() OVER (PARTITION BY ISSUE_ID ORDER BY SYS_CREATED) AS ROW_NUMBER_ASC
            ,LEAD(SYS_CREATED) OVER (PARTITION BY ISSUE_ID ORDER BY SYS_CREATED) AS LEAD
            ,LAG(SYS_CREATED) OVER (PARTITION BY ISSUE_ID ORDER BY SYS_CREATED) AS LAG
            ,SYS_CREATED
            ,from_string
            ,to_string

    FROM changelog_story_points
), story_point_hist AS (
    SELECT 
            crn.ISSUE_ID
            ,COALESCE(crn.LAG,wc.sys_created) AS effective_date_start
            ,crn.sys_created AS effective_date_end
            ,crn.from_string as story_points

    FROM changelog_row_num crn JOIN workitems_current_story_points wc ON crn.issue_id = wc.issue_id
), latest_change AS (
    SELECT 
            issue_id
            ,MAX(SYS_CREATED) AS latest_change

    FROM changelog_story_points
    GROUP BY issue_id
), current_issue_story_points AS (
    SELECT 
            cwsp.issue_id
            ,COALESCE(lc.latest_change,cwsp.sys_created) AS effective_date_start
            ,'9999-12-31'::TIMESTAMP_TZ AS effective_date_end
            ,cwsp.story_points as story_points
            
    FROM workitems_current_story_points cwsp LEFT JOIN latest_change lc ON cwsp.issue_id = lc.issue_id
)

SELECT
        issue_id
        ,story_points
        ,effective_date_start
        ,effective_date_end

FROM 
        current_issue_story_points

UNION

SELECT
        issue_id::INT as issue_id
        ,story_points::INT as story_points
        ,effective_date_start
        ,effective_date_end

FROM 
        story_point_hist