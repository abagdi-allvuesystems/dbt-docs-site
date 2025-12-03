WITH raw_surveys AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_jsm_survey_issues
)
SELECT 
        id::INT AS id
        ,key
        ,fields:issuetype.id::INT AS issue_type_id
        ,fields:issuetype.name::VARCHAR AS issue_type_name
        ,fields:customfield_10010:requestType:id::INT AS request_type_id
        ,fields:customfield_10010:requestType:name::VARCHAR AS request_type_name
        ,fields
        ,renderedfields AS rendered_fields
        ,changelog
        ,projectid::INT AS project_id
        ,projectkey AS project_key
        ,created::TIMESTAMP_TZ AS sys_created
        ,updated::TIMESTAMP_TZ AS sys_updated
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM raw_surveys