
  
    

create or replace transient table AV_EDM.AV_ENG_ANALYTICS.workitem
    
    
    
    as (WITH jira_workitems AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_workitems
), jira_workitems_sprints_current as (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_sprint_workitems
    WHERE effective_date_end = '9999-12-31'
), jira_sprints AS (
    SELECT DISTINCT id,start_date,name FROM AV_EDM.AV_STAGING.dim_jira_sprints
), sprint_issue_row_num AS (
    SELECT sc.sprint_id
        ,sc.issue_id
        ,s.name
        ,ROW_NUMBER() OVER (PARTITION BY sc.ISSUE_ID ORDER BY s.START_DATE DESC) AS row_num
    FROM jira_workitems_sprints_current sc JOIN jira_sprints s ON sc.sprint_id = s.id
), sprint_issue_latest AS (
    SELECT *
    FROM sprint_issue_row_num 
    WHERE row_num = 1
), epic_mapping AS (
    SELECT * FROM AV_EDM.AV_STAGING.epic_id_mapping
), solution_project_mapping AS (
    SELECT * FROM AV_EDM.AV_STAGING.solution_project_id_mapping
), wi_fix_vers AS (
    SELECT * from AV_EDM.AV_ENG_ANALYTICS.workitem_fix_versions
), release_vers AS (
    SELECT * from AV_EDM.AV_ENG_ANALYTICS.release_versions
), wi_fix_vers_name_agg AS (
    SELECT
        wfv.jira_issue_id
        ,LISTAGG(rv.name, ',') as fix_versions
    FROM  wi_fix_vers wfv JOIN release_vers rv on wfv.jira_version_id = rv.jira_version_id
    group by wfv.jira_issue_id
), epic_parents AS (
    SELECT issue_id
        ,issue_key
        ,issue_type_name
        ,issue_type_id
        ,parent_issue_id
        ,parent_issue_key
        ,parent_issue_type_name
    FROM AV_EDM.AV_STAGING.dim_jira_epics
)

SELECT 
        wi.issue_id AS id
        ,em.id AS epic_id
        ,spm.id AS solution_project_id
        ,wi.project_id AS jira_project_id
        ,wi.issue_id AS jira_workitem_id
        ,wi.issue_key AS jira_workitem_key
        ,wi.parent_issue_id AS jira_epic_id
        ,wi.parent_issue_key AS jira_epic_key
        ,ep.parent_issue_id AS jira_initiative_id
        ,ep.parent_issue_key AS jira_initiative_key
        ,wi.issue_type_name AS type
        ,wi.issue_summary AS summary
        ,wi.issue_status_name AS status
        ,wi.issue_status_category AS status_category
        ,wi.issue_story_points AS story_points
        ,wi.issue_team_id AS team_id
        ,wi.issue_team_name AS team_name
        ,sl.sprint_id AS sprint_id_latest
        ,sl.name AS sprint_name_latest
        ,wi.issue_resolutiondate as resolution_date
        ,CASE WHEN wi.labels like '%ai-generated%' THEN true ELSE false END as was_ai_generated
        ,wfv_agg.fix_versions
        ,wi.labels as labels
        ,wi.reporter:accountId::VARCHAR as reporter_jira_account_id
        ,wi.assignee:accountId::VARCHAR as assignee_jira_account_id
        ,wi.reporter:displayName::VARCHAR as reporter_jira_display_name
        ,wi.assignee:displayName::VARCHAR as assignee_jira_display_name
        ,sys_created
        ,sys_updated
        ,raw_updated

FROM 
        jira_workitems wi 
LEFT JOIN 
        sprint_issue_latest sl ON wi.issue_id = sl.issue_id
LEFT JOIN
        epic_mapping em ON wi.parent_issue_id = em.issue_id
LEFT JOIN
        solution_project_mapping spm ON wi.project_id = spm.jira_project_id
LEFT JOIN 
        wi_fix_vers_name_agg wfv_agg ON wi.issue_id = wfv_agg.jira_issue_id
LEFT JOIN
        epic_parents ep ON wi.parent_issue_id = ep.issue_id
    )
;


  