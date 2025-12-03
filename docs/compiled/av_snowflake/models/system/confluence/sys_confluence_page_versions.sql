WITH confluence_page_versions AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_confluence_page_versions
)
SELECT 
       AUTHORID::VARCHAR AS author_id
       ,CREATEDAT::timestamp_ntz AS created_at
       ,MESSAGE::VARCHAR AS message
       ,MINOREDIT::BOOLEAN AS minor_edit
       ,NUMBER::FLOAT AS number
       ,PAGE::VARIANT AS page
       ,_AIRBYTE_EXTRACTED_AT::timestamp_ntz AS airbyte_extracted_at
       ,_AIRBYTE_GENERATION_ID::INT AS airbyte_generation_id
       ,_AIRBYTE_META::VARCHAR AS airbyte_meta
       ,_AIRBYTE_RAW_ID::VARCHAR AS airbyte_raw_id

FROM confluence_page_versions