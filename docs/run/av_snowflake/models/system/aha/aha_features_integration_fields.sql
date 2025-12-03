
  create or replace   view AV_EDM.AV_SYSTEM.aha_features_integration_fields
  
  
  
  
  as (
    WITH features as (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_aha_features
)
SELECT 
    ID::INT as FEATURE_ID
    ,integration.VALUE:id::INT as ID
    ,integration.VALUE:name::VARCHAR as NAME
    ,integration.VALUE:value::VARCHAR as VALUE
    ,integration.VALUE:integration_id::INT as INTEGRATION_ID
    ,integration.VALUE:service_name::VARCHAR as SERVICE_NAME
    ,integration.VALUE:created_at::TIMESTAMP_TZ as CREATED_AT
    ,_AIRBYTE_EXTRACTED_AT::TIMESTAMP_TZ as RAW_UPDATED
FROM features
,LATERAL FLATTEN(INTEGRATION_FIELDS) integration
  );

