WITH corp_pi AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_litheo_corp_pis
), epic_id_mapping AS (
    SELECT * FROM AV_EDM.AV_STAGING.epic_id_mapping
), aha_pi_feature AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_aha_features_pi_planning
), aha_corp_pi_feature AS (
    SELECT 
        a_pi.feature_id
        ,c_pi.id AS corp_pi_id
        ,c_pi.name AS corp_pi_name
        ,start_date
        ,end_date
        ,epic_readiness_date
        ,pi_readiness_date
    FROM 
        aha_pi_feature a_pi
    JOIN corp_pi c_pi ON c_pi.name = a_pi.value OR c_pi.jira_pi_name = a_pi.value
), jira_pi_epic AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_pi_epic
), jira_corp_pi_epic AS (
    SELECT 
        e_pi.issue_id
        ,c_pi.id as corp_pi_id
        ,c_pi.name as corp_pi_name
        ,start_date
        ,end_date
        ,epic_readiness_date
        ,pi_readiness_date
    FROM 
        jira_pi_epic e_pi
    JOIN 
        corp_pi c_pi ON c_pi.name = e_pi.pi_name OR c_pi.jira_pi_name = e_pi.pi_name
), corp_pi_jira_epic_mapping AS (
    SELECT 
        m.id AS epic_id
        ,e_pi.corp_pi_id 
        ,e_pi.corp_pi_name
        ,e_pi.start_date
        ,e_pi.end_date
        ,e_pi.epic_readiness_date
        ,e_pi.pi_readiness_date
    FROM jira_corp_pi_epic e_pi
    JOIN epic_id_mapping m ON e_pi.issue_id = m.issue_id
), corp_pi_feature_epic_mapping AS (
    SELECT 
        m.id AS epic_id
        ,a_pi.corp_pi_id 
        ,a_pi.corp_pi_name
        ,a_pi.start_date
        ,a_pi.end_date
        ,a_pi.epic_readiness_date
        ,a_pi.pi_readiness_date
    FROM aha_corp_pi_feature a_pi
    JOIN epic_id_mapping m ON a_pi.feature_id = m.feature_id
), workitem AS (
    SELECT * FROM AV_EDM.AV_ENG_ANALYTICS.workitem
), pi_workitem AS (
    SELECT * FROM AV_EDM.AV_ENG_ANALYTICS.pi_workitem
), pi_epic_workitem AS (
    SELECT 
        corp_pi_id
        ,epic_id
        ,planned_onto_sprint_in_team_pi_start
    FROM 
        pi_workitem pw
    JOIN 
        workitem w ON pw.workitem_id = w.id
    WHERE planned_onto_sprint_in_team_pi_start = true
), corp_pi_workitem_epic_mapping AS (
    SELECT
        epic_id
        ,c_pi.id AS corp_pi_id
        ,c_pi.name AS corp_pi_name
        ,start_date
        ,end_date
        ,epic_readiness_date
        ,pi_readiness_date
    FROM pi_epic_workitem wi
    JOIN corp_pi c_pi ON c_pi.id = wi.corp_pi_id
), pi_epic_in_scope_merge AS (
    SELECT
        epic_id
        ,corp_pi_id
        ,corp_pi_name
        ,start_date
        ,end_date
        ,epic_readiness_date
        ,pi_readiness_date
        
    FROM corp_pi_feature_epic_mapping
    UNION
    SELECT
        epic_id
        ,corp_pi_id
        ,corp_pi_name
        ,start_date
        ,end_date
        ,epic_readiness_date
        ,pi_readiness_date
        
    FROM corp_pi_jira_epic_mapping
    UNION
    SELECT
        epic_id
        ,corp_pi_id
        ,corp_pi_name
        ,start_date
        ,end_date
        ,epic_readiness_date
        ,pi_readiness_date
        
    FROM corp_pi_workitem_epic_mapping
    WHERE
        epic_id IS NOT NULL
)

SELECT 
DISTINCT
    epic_id
    ,corp_pi_id
    ,corp_pi_name
    ,start_date
    ,end_date
    ,epic_readiness_date
    ,pi_readiness_date

FROM
    pi_epic_in_scope_merge