
  
    

create or replace transient table AV_EDM.AV_ENG_ANALYTICS.epic
    
    
    
    as (WITH jira_epic AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_epics
), jira_epic_pis AS (
    SELECT 
            issue_id
            ,LISTAGG(PI_VALUE,',') AS jira_pi

    FROM AV_EDM.AV_STAGING.dim_jira_epic_pi_new
    GROUP BY issue_id
), associated_products AS (
    SELECT issue_id
        ,LISTAGG(associated_products_field_value,',') AS associated_products
    FROM AV_EDM.AV_STAGING.dim_jira_associated_products
    GROUP BY issue_id
), market_segment AS (
    SELECT issue_id
        ,LISTAGG(market_segement_field_value,',') AS market_segment
    FROM AV_EDM.AV_STAGING.dim_jira_market_segment
    GROUP BY issue_id
), aha_feature AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_aha_features
), aha_features_pis AS (
    SELECT 
            FEATURE_ID
            ,LISTAGG(VALUE,',') AS aha_pi

    FROM AV_EDM.AV_STAGING.dim_aha_features_pi_planning
    GROUP BY FEATURE_ID
), aha_features_with_pis AS (
    SELECT
            f.id
            ,f.name
            ,f.reference_num
            ,f.initiative_reference_num
            ,f.release_reference_num
            ,f.jira_epic_issue_key
            ,f.jira_epic_issue_id
            ,f.sys_created
            ,f.sys_updated
            ,f.start_date
            ,f.due_date
            ,f.product_id
            ,f.created_by_user_id
            ,f.created_by_user_name
            ,f.workflow_status_id
            ,f.workflow_status_name
            ,f.project_name
            ,f.original_estimate
            ,f.remaining_estimate
            ,f.initial_estimate
            ,f.assigned_to_user_id
            ,f.assigned_to_user_name
            ,f.feature_only_original_estimate
            ,f.feature_only_remaining_estimate
            ,f.investment_layers
            ,f.raw_updated
            ,fp.aha_pi

    FROM 
            aha_feature f 
    LEFT JOIN 
            aha_features_pis fp ON f.id = fp.feature_id

), jira_epics_with_pis AS (
    SELECT 
        je.issue_id
        ,je.issue_key
        ,je.issue_type_name
        ,je.issue_type_id
        ,je.issue_status_name
        ,je.issue_status_id
        ,je.issue_status_category
        ,je.parent_issue_id
        ,je.parent_issue_key
        ,je.parent_issue_type_name
        ,je.project_id
        ,je.project_key
        ,je.project_name
        ,je.issue_summary
        ,je.program_increment_old
        ,je.issue_investment_layers
        ,je.program_increment
        ,je.sys_created
        ,je.sys_updated
        ,je.raw_updated
        ,jep.jira_pi
        ,je.reporter:accountId::VARCHAR as reporter_jira_account_id
        ,je.assignee:accountId::VARCHAR as assignee_jira_account_id
        ,je.reporter:displayName::VARCHAR as reporter_jira_display_name
        ,je.assignee:displayName::VARCHAR as assignee_jira_display_name
        ,je.labels::VARCHAR as jira_labels
        ,CASE WHEN je.labels::VARCHAR like '%ai-generated%' THEN true ELSE false END as was_ai_generated
        ,je.scoping_documentation
        ,je.architecture_documentation
        ,je.ui_ux_documentation
        ,je.infrastructure_documentation
        ,je.security_documentation
        ,je.scope_complete
        ,je.arch_rev_complete
        ,je.infr_rev_complete
        ,je.ui_ux_rev_complete
        ,je.qa_rev_complete
        ,je.dev_rev_complete
        ,je.sec_rev_complete
        ,je.eng_scope_accepted
        ,je.story_points
        ,je.team
    FROM 
            jira_epic je 
    LEFT JOIN 
            jira_epic_pis jep ON je.issue_id = jep.issue_id
), epic_mapping AS (
    SELECT * FROM AV_EDM.AV_STAGING.epic_id_mapping
), solution_project_mapping AS (
    SELECT * FROM AV_EDM.AV_STAGING.solution_project_id_mapping
)

SELECT 
        em.id AS id
        ,spm.id AS solution_project_id
        ,je.issue_id AS jira_epic_id
        ,je.issue_key AS jira_epic_key
        ,af.id AS aha_feature_id
        ,af.reference_num AS aha_feature_reference_number
        ,je.issue_summary AS jira_epic_summary
        ,af.name AS aha_feature_name
        ,je.issue_status_name AS jira_epic_status
        ,af.workflow_status_name AS aha_feature_status
        ,je.issue_status_category AS jira_epic_status_category
        ,je.parent_issue_id AS jira_parent_issue_id
        ,je.parent_issue_key AS jira_parent_issue_key
        ,je.parent_issue_type_name AS jira_parent_issue_type_name
        ,je.project_id AS jira_project_id
        ,je.project_key AS jira_project_key
        ,je.project_name AS jira_project_name
        ,af.project_name AS aha_project_name
        ,af.INITIATIVE_REFERENCE_NUM AS aha_initiative_reference_number
        ,af.release_reference_num AS aha_release_reference_number
        ,af.product_id AS aha_feature_product_id
        ,af.start_date AS aha_feature_start_date
        ,af.due_date AS aha_feature_due_date
        ,je.jira_pi AS jira_epic_pi
        ,af.aha_pi AS aha_feature_pi
        ,af.investment_layers::VARCHAR AS aha_feature_investment_layers
        ,af.original_estimate AS aha_feature_original_estimate
        ,af.remaining_estimate AS aha_feature_remaining_estimate
        ,af.initial_estimate AS aha_feature_initial_estimate
        ,je.reporter_jira_account_id
        ,je.assignee_jira_account_id
        ,je.reporter_jira_display_name
        ,je.assignee_jira_display_name
        ,je.jira_labels
        ,je.was_ai_generated
        ,je.sys_created AS jira_epic_sys_created
        ,je.sys_updated AS jira_epic_sys_updated
        ,af.sys_created AS aha_feature_sys_created
        ,af.sys_updated AS aha_feature_sys_updated
        ,je.scoping_documentation
        ,je.architecture_documentation
        ,je.ui_ux_documentation
        ,je.infrastructure_documentation
        ,je.security_documentation
        ,je.scope_complete
        ,je.arch_rev_complete
        ,je.infr_rev_complete
        ,je.ui_ux_rev_complete
        ,je.qa_rev_complete
        ,je.dev_rev_complete
        ,je.sec_rev_complete
        ,je.eng_scope_accepted
        ,je.story_points
        ,je.team

FROM
        epic_mapping em
LEFT JOIN
        aha_features_with_pis af ON em.feature_id = af.id
LEFT JOIN
        jira_epics_with_pis je ON em.issue_id = je.issue_id
LEFT JOIN
        solution_project_mapping spm ON je.project_id = spm.jira_project_id
    )
;


  