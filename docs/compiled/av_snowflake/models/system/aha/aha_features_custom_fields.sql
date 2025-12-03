WITH features AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_aha_features
)
SELECT 
        id::INT AS feature_id
        ,custom.value:id::INT AS ID
        ,custom.value:key::VARCHAR AS key
        ,custom.value:name::VARCHAR AS name
        ,custom.value:value AS value
        ,custom.value:type::VARCHAR AS type
        ,custom.value:updatedAt::TIMESTAMP_TZ AS updated_at
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated

FROM 
        features
        ,LATERAL FLATTEN(custom_fields) custom