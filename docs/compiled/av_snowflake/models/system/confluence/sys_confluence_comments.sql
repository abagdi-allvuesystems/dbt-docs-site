WITH confluence_comments AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_confluence_comments
)
SELECT
        ARI::Varchar AS ari
        ,BASE64ENCODEDARI::Varchar AS base64encodedari
        ,EXTENSIONS::VARCHAR AS extensions
        ,ID::Varchar AS id
        ,MACRORENDEREDOUTPUT::VARCHAR AS macrorenderedoutput
        ,STATUS::Varchar AS status
        ,TITLE::Varchar AS title
        ,TYPE::Varchar AS type
        ,_AIRBYTE_EXTRACTED_AT::Timestamp_TZ AS _airbyte_extracted_at
        ,_AIRBYTE_GENERATION_ID::INT AS _airbyte_generation_id
        ,_AIRBYTE_META::Variant AS _airbyte_meta
        ,_AIRBYTE_RAW_ID::Varchar AS _airbyte_raw_id
        ,_EXPANDABLE::VARCHAR AS _expandable
        ,_LINKS::VARCHAR AS _links

FROM 
        confluence_comments