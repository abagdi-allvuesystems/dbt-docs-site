WITH confluence_users AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_confluence_users
)
SELECT
        BREADCRUMBS::VARCHAR AS breadcrumbs
        ,ENTITYTYPE::VARCHAR AS entity_type
        ,EXCERPT::VARCHAR AS excerpt
        ,ICONCSSCLASS::VARCHAR AS icon_css_class
        ,LASTMODIFIED::VARCHAR AS last_modified
        ,SCORE::INT AS score
        ,TITLE::VARCHAR AS title
        ,URL::VARCHAR AS url
        ,USER::VARCHAR AS user
        ,_AIRBYTE_EXTRACTED_AT::TIMESTAMP_TZ AS _airbyte_extracted_at
        ,_AIRBYTE_GENERATION_ID::INT AS _airbyte_generation_id
        ,_AIRBYTE_META::VARIANT AS _airbyte_meta
        ,_AIRBYTE_RAW_ID::VARCHAR AS _airbyte_raw_id
FROM 
        confluence_users