
  
    

create or replace transient table AV_EDM.AV_ENG_ANALYTICS.initiative
    
    
    
    as (WITH jira_epic AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_initiatives
), initiative_pi AS (
    SELECT issue_id
        ,LISTAGG(PI_VALUE,',') AS jira_pi 
    FROM AV_EDM.AV_STAGING.dim_jira_initiative_pi
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
)


SELECT je.issue_id AS initiative_id
    ,je.issue_key AS initiative_key
    ,je.issue_status_name AS status
    ,je.issue_status_category AS status_category
    ,je.project_id AS project_id
    ,je.project_key AS project_key
    ,je.issue_summary AS summary
    ,je.issue_investment_layers AS investment_layers
    ,ip.jira_pi AS initiative_pi
    ,REPLACE(REPLACE(REPLACE(je.labels, '[', ''), ']', ''), '"', '') AS jira_labels
    ,je.reporter:accountId::VARCHAR AS reporter_jira_account_id
    ,je.reporter:displayName::VARCHAR AS reporter_jira_display_name
    ,je.assignee:accountId::VARCHAR AS assignee_jira_account_id
    ,je.assignee:displayName::VARCHAR AS assignee_jira_display_name
    ,je.sys_created AS sys_created
    ,je.sys_updated AS sys_updated
    ,je.start_target AS start_target
    ,je.end_target AS end_target
    ,ms.market_segment AS market_segment
    ,ap.associated_products AS associated_products
    ,je.vertical AS vertical
    ,je.roadmap_year AS roadmap_year
    ,je.roadmap_commitment AS roadmap_commitment
    ,je.scope_complete AS scope_complete
    ,je.initial_estimate AS initial_estimate
    ,je.arch_rev_complete_approved AS arch_rev_complete_approved
    ,je.infr_rev_complete_approved AS infr_rev_complete_approved
    ,je.ui_ux_rev_complete_approved AS ui_ux_rev_complete_approved
    ,je.sec_rev_complete_approved AS sec_rev_complete_approved
    ,je.qa_rev_complete_approved AS qa_rev_complete_approved
    ,je.dev_rev_complete_approved AS dev_rev_complete_approved
    ,je.documentation_needed AS documentation_needed
    ,je.scoping_documentation AS scoping_documentation
    ,je.architecture_documentation AS architecture_documentation
    ,je.ui_ux_documentation AS ui_ux_documentation
    ,je.infrastructure_documentation AS infrastructure_documentation
    ,je.security_documentation AS security_documentation


FROM jira_epic je LEFT JOIN initiative_pi ip ON je.issue_id = ip.issue_id
                        LEFT JOIN associated_products ap ON je.issue_id = ap.issue_id
                        LEFT JOIN market_segment ms ON je.issue_id = ms.issue_id
    )
;


  