

WITH workitems_current AS (
    SELECT 
            issue_id
            ,sys_created

    FROM AV_EDM.AV_STAGING.dim_jira_workitems
), sprint_workitems_current AS (
    SELECT *

    FROM AV_EDM.AV_STAGING.dim_jira_sprint_workitems_current
), workitems_sprints_current_csv AS (
    SELECT 
            issue_id
            ,LISTAGG(sprint_id,',') AS sprints_csv

    FROM sprint_workitems_current
GROUP BY issue_id
), current_workitems_sprints AS (
    SELECT 
            wc.issue_id
            ,wc.sys_created
            ,swc.sprints_csv AS sprint_ids

    FROM workitems_current wc LEFT JOIN workitems_sprints_current_csv swc ON wc.issue_id = swc.issue_id
), changelog_sprints AS (
    SELECT *

    FROM AV_EDM.AV_STAGING.jira_issue_changelog_sprints
), changelog_row_num AS (
    SELECT 
            ISSUE_ID
            ,ROW_NUMBER() OVER (PARTITION BY ISSUE_ID ORDER BY SYS_CREATED) AS ROW_NUMBER_ASC
            ,LEAD(SYS_CREATED) OVER (PARTITION BY ISSUE_ID ORDER BY SYS_CREATED) AS LEAD
            ,LAG(SYS_CREATED) OVER (PARTITION BY ISSUE_ID ORDER BY SYS_CREATED) AS LAG
            ,SYS_CREATED
            ,from_id
            ,to_id

    FROM changelog_sprints
), sprint_hist AS (
    SELECT 
            crn.ISSUE_ID
            ,COALESCE(crn.LAG,wc.sys_created) AS effective_date_start
            ,crn.sys_created AS effective_date_end
            ,REPLACE(crn.from_id,' ','') AS sprint_ids

    FROM changelog_row_num crn JOIN workitems_current wc ON crn.issue_id = wc.issue_id
), latest_change AS (
    SELECT 
            issue_id
            ,MAX(SYS_CREATED) AS latest_change

    FROM changelog_sprints
    GROUP BY issue_id
), current_issue_sprints AS (
    SELECT 
            cws.issue_id
            ,COALESCE(lc.latest_change,cws.sys_created) AS effective_date_start
            ,'9999-12-31'::TIMESTAMP_TZ AS effective_date_end
            ,cws.sprint_ids AS sprint_ids
            
    FROM current_workitems_sprints cws LEFT JOIN latest_change lc ON cws.issue_id = lc.issue_id
)

SELECT
        issue_id
        ,sprint_ids
        ,effective_date_start
        ,effective_date_end

FROM 
        current_issue_sprints

UNION

SELECT
        issue_id
        ,sprint_ids
        ,effective_date_start
        ,effective_date_end

FROM 
        sprint_hist