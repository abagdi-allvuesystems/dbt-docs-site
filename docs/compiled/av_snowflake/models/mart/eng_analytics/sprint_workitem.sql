WITH litheo_jira_sprint_items AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_litheo_jira_sprint_items
)

SELECT 
        jira_sprint_id AS team_sprint_id
        ,jira_issue_id AS workitem_id
        ,CASE WHEN jira_sprint_itm_comp_status = 'CompletedIssues' THEN true ELSE false END::BOOLEAN AS completed_in_sprint
        ,CASE WHEN jira_sprint_itm_comp_status = 'puntedIssues' THEN true ELSE false END::BOOLEAN AS punted_from_sprint
        ,IFNULL(jira_issue_key_added_during_sprint,'false')::BOOLEAN AS added_during_sprint
        ,jira_issue_story_points_initial::NUMBER AS sprint_accepted_story_points
        ,jira_issue_story_points_current::NUMBER AS sprint_final_story_points
        ,CASE WHEN jira_sprint_itm_comp_status = 'CompletedIssues' THEN jira_issue_story_points_current END::NUMBER AS sprint_completed_story_points
        ,CASE WHEN IFNULL(jira_issue_key_added_during_sprint,'false') != 'true' THEN jira_issue_story_points_initial ELSE NULL END AS sprint_planned_accepted_points
        ,CASE WHEN IFNULL(jira_issue_key_added_during_sprint,'false') != 'true' AND jira_sprint_itm_comp_status = 'CompletedIssues' THEN jira_issue_story_points_initial ELSE NULL END AS sprint_planned_accepted_completed_points
        ,CASE WHEN jira_issue_key_added_during_sprint = 'true' THEN jira_issue_story_points_initial END::NUMBER AS sprint_sprint_churn_points_added
        ,CASE WHEN jira_sprint_itm_comp_status = 'puntedIssues' THEN jira_issue_story_points_current END AS sprint_churn_points_removed
        ,ABS(IFNULL(jira_issue_story_points_current,0) - IFNULL(jira_issue_story_points_initial,0)) AS sprint_churn_scope_altered
        ,IFNULL(CASE WHEN jira_issue_key_added_during_sprint = 'true' THEN jira_issue_story_points_initial END,0)
            + IFNULL(CASE WHEN jira_sprint_itm_comp_status = 'puntedIssues' THEN jira_issue_story_points_current END,0)
            + ABS(IFNULL(jira_issue_story_points_current,0) - IFNULL(jira_issue_story_points_initial,0)) AS sprint_churn_total_points
        ,jira_issue_key AS sprint_report_issue_key
        ,jira_issue_type_name AS sprint_report_sr_issue_type
        ,jira_issue_parent_issue_key AS sprint_report_parent_issue_id

FROM 
        litheo_jira_sprint_items
WHERE 
        jira_issue_type_name NOT IN ('Test','Sub-defect','Epic','Initiative')