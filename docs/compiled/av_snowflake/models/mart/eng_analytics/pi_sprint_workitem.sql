WITH pi_sprint_work_item_detail AS (
    SELECT * FROM AV_EDM.AV_STAGING.ea_pi_sprint_workitem_detail
), pi_sprint_attr_agg AS (
    SELECT corp_pi_id
        ,corp_sprint_id
        ,jira_sprint_id
        ,jira_issue_id
        ,MAX(existed_at_pi_start) AS existed_at_pi_start
        ,MAX(existed_at_pi_start_ts) AS existed_at_pi_start_ts
        ,MAX(accepted_into_sprint_derived) AS accepted_into_sprint_derived
        ,MAX(existed_in_pi_window_pi_start) AS existed_in_pi_window_pi_start
        ,MAX(existed_in_pi_window_team_sprint_start) AS existed_in_pi_window_team_sprint_start
    FROM pi_sprint_work_item_detail
    GROUP BY corp_pi_id
        ,corp_sprint_id
        ,jira_sprint_id
        ,jira_issue_id
), litheo_jira_sprint_items AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.litheo_jira_sprint_items
)

SELECT 
        psaa.corp_pi_id AS corp_pi_id
        ,psaa.corp_sprint_id AS corp_sprint_id
        ,psaa.jira_sprint_id AS team_sprint_id
        ,psaa.jira_issue_id AS workitem_id
        ,psaa.existed_at_pi_start::BOOLEAN AS existed_at_corp_pi_start
        ,psaa.existed_at_pi_start_ts::BOOLEAN AS existed_at_pi_team_sprint_start
        ,psaa.existed_in_pi_window_pi_start::BOOLEAN AS existed_in_pi_window_pi_start
        ,psaa.existed_in_pi_window_team_sprint_start::BOOLEAN AS existed_in_pi_window_team_sprint_start
        ,CASE WHEN ljsi.sprintid IS NOT NULL THEN 1 ELSE IFNULL(ljsi.sprintid,0) END::BOOLEAN AS accepted_into_sprint
        ,psaa.accepted_into_sprint_derived::BOOLEAN AS accepted_into_sprint_derived

FROM 
        pi_sprint_attr_agg psaa 
LEFT JOIN 
        litheo_jira_sprint_items ljsi ON psaa.jira_sprint_id = ljsi.sprintid 
        AND psaa.jira_issue_id = ljsi.issueid