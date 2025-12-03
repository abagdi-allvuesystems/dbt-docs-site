
  create or replace   view AV_EDM.AV_STAGING.ea_pi_epic_detail
  
  
  
  
  as (
    WITH in_scope AS (
    SELECT * FROM AV_EDM.AV_STAGING.ea_pi_epic_in_scope
), corp_pi AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_litheo_corp_pis 
), epic_id_mapping AS (
    SELECT * FROM AV_EDM.AV_STAGING.epic_id_mapping
), jira_pi_epic AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_pi_epic
), jira_corp_pi_epic AS (
    SELECT
        e.issue_id
        ,c_pi.id AS corp_pi_id
        ,effective_date_start
        ,effective_date_end
    FROM jira_pi_epic e
    JOIN corp_pi c_pi ON e.pi_name = c_pi.name OR e.pi_name = c_pi.jira_pi_name
), jira_pi_epic_with_mapping AS (
    SELECT
        m.id AS epic_id
        ,m.issue_id
        ,corp_pi_id
        ,effective_date_start
        ,effective_date_end
    FROM 
        jira_corp_pi_epic e
    JOIN epic_id_mapping m ON m.issue_id = e.issue_id
), aha_pi_feature AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_aha_features_pi_planning
), aha_corp_pi_id_feature AS (
    SELECT
        feature_id
        ,c_pi.id AS corp_pi_id
    FROM aha_pi_feature a
    JOIN corp_pi c_pi ON a.value = c_pi.name OR a.value = c_pi.jira_pi_name
), aha_pi_feature_with_mapping AS (
    SELECT
        m.id AS epic_id
        ,a.feature_id
        ,corp_pi_id
    FROM aha_corp_pi_id_feature a
    JOIN epic_id_mapping m ON m.feature_id = a.feature_id
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
          AND epic_id IS NOT NULL
)

SELECT
        scope.epic_id
        ,af.feature_id
        ,je.issue_id
        ,scope.corp_pi_id
        ,scope.corp_pi_name
        ,scope.start_date
        ,scope.end_date
        ,scope.epic_readiness_date
        ,scope.pi_readiness_date
        ,CASE 
            WHEN scope.epic_readiness_date > SYSDATE() THEN NULL
            WHEN epic_readiness_date BETWEEN effective_date_start AND effective_date_end THEN TRUE
            ELSE FALSE
        END::BOOLEAN AS in_scope_jira_attribute_at_epic_readiness_start
        ,CASE 
            WHEN scope.pi_readiness_date > SYSDATE() THEN NULL
            WHEN pi_readiness_date BETWEEN effective_date_start AND effective_date_end THEN TRUE
            ELSE FALSE
        END::BOOLEAN AS in_scope_jira_attribute_at_pi_readiness_start
        ,CASE
            WHEN scope.epic_readiness_date > SYSDATE() THEN NULL
            WHEN effective_date_start <= pi_readiness_date AND epic_readiness_date <= IFF(effective_date_end < SYSDATE(), effective_date_end,SYSDATE()) THEN true 
            ELSE false 
        END::BOOLEAN AS in_scope_jira_attribute_between_epic_pi_readiness
        ,CASE 
            WHEN scope.pi_readiness_date > SYSDATE() THEN NULL
            WHEN effective_date_start <= start_date AND pi_readiness_date <= IFF(effective_date_end < SYSDATE(), effective_date_end,SYSDATE()) THEN true 
            ELSE false 
        END::BOOLEAN AS in_scope_jira_attribute_between_pi_readiness_start
        ,CASE
            WHEN scope.start_date > SYSDATE() THEN NULL
            WHEN effective_date_start <= end_date AND start_date <= IFF(effective_date_end < SYSDATE(), effective_date_end,SYSDATE()) THEN true 
            ELSE false 
        END::BOOLEAN AS in_scope_jira_attribute_between_pi_start_end
        ,CASE
            WHEN af2.feature_id IS NULL THEN NULL
            WHEN af.feature_id IS NOT NULL THEN true
            ELSE false
        END::BOOLEAN AS in_scope_aha_attribute
        ,CASE
            WHEN wi.planned_onto_sprint_in_team_pi_start IS NOT NULL THEN true
            ELSE false
        END::BOOLEAN AS in_scope_planned_workitems
FROM
        in_scope scope
LEFT JOIN
        jira_pi_epic_with_mapping je ON scope.epic_id = je.epic_id AND scope.corp_pi_id = je.corp_pi_id
LEFT JOIN
        aha_pi_feature_with_mapping af ON scope.epic_id = af.epic_id AND scope.corp_pi_id = af.corp_pi_id
LEFT JOIN
        aha_pi_feature_with_mapping af2 ON scope.epic_id = af2.epic_id
        
LEFT JOIN
        pi_epic_workitem wi ON scope.epic_id = wi.epic_id AND scope.corp_pi_id = wi.corp_pi_id
  );

