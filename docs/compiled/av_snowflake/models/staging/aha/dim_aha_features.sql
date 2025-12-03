WITH features AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.aha_features
), custom AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.aha_features_custom_fields
), integration as (
    SELECT * FROM AV_EDM.AV_SYSTEM.aha_features_integration_fields
)

SELECT 
        features.id::INT AS id
        ,features.name
        ,features.REFERENCE_NUM
        ,features.initiative_reference_num
        ,features.release_reference_num
        ,jira_key.VALUE AS jira_epic_issue_key
        ,TRY_CAST(jira_id.VALUE AS INT) AS jira_epic_issue_id
        ,jira_id.value
        ,features.start_date
        ,features.due_date
        ,features.product_id
        ,features.created_by_user__id AS created_by_user_id
        ,features.created_by_user__name AS created_by_user_name
        ,features.workflow_status__id AS workflow_status_id
        ,features.workflow_status__name AS workflow_status_name
        ,features.project__name AS project_name
        ,features.original_estimate
        ,features.remaining_estimate
        ,features.initial_estimate
        ,features.assigned_to_user__id AS assigned_to_user_id
        ,features.assigned_to_user__name AS assigned_to_user_name
        ,features.feature_only_original_estimate
        ,features.feature_only_remaining_estimate
        ,investment.value::VARCHAR AS investment_layers
        ,features.created_at AS sys_created
        ,features.updated_at AS sys_updated
        ,features.raw_updated

FROM 
        features
LEFT JOIN 
        integration jira_key ON jira_key.FEATURE_ID = features.ID AND jira_key.name = 'key' AND jira_key.service_name = 'jira'
LEFT JOIN 
        integration jira_id ON jira_id.FEATURE_ID = features.ID AND jira_id.name = 'id' AND jira_id.service_name = 'jira'
LEFT JOIN 
        custom investment ON investment.FEATURE_ID = features.ID AND investment.name = 'Investment Layer'