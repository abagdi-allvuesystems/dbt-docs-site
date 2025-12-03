WITH features AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_aha_features
)

SELECT 
        id::INT AS id
        ,name
        ,reference_num
        ,initiative_reference_num
        ,release_reference_num
        ,start_date::TIMESTAMP_TZ AS start_date
        ,due_date::TIMESTAMP_TZ AS due_date
        ,product_id::INT AS product_id
        ,created_by_user:id::INT AS created_by_user__id
        ,created_by_user:name::VARCHAR AS created_by_user__name
        ,workflow_status:id::INT AS workflow_status__id
        ,workflow_status:name::VARCHAR AS workflow_status__name
        ,project:name::VARCHAR AS project__name
        ,original_estimate
        ,remaining_estimate
        ,initial_estimate
        ,assigned_to_user:id::INT AS assigned_to_user__id
        ,ASSIGNED_TO_USER:name::VARCHAR AS assigned_to_user__name
        ,feature_only_original_estimate
        ,feature_only_remaining_estimate
        ,custom_fields
        ,integration_fields
        ,created_at::TIMESTAMP_TZ AS created_at
        ,updated_at::TIMESTAMP_TZ AS updated_at
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS RAW_UPDATED

FROM 
        features