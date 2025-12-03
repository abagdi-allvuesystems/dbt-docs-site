WITH page_versions AS (
    SELECT * FROM AV_EDM.AV_STAGING.stg_confluence_page_versions
)
SELECT 
       page_id AS page_id
       ,page_title AS page_title
       ,version_number AS version_number
       ,comments AS comments
       ,updated_by_id AS updated_by_id
       ,updated_date AS updated_date
       ,is_minor_edit AS is_minor_edit

FROM page_versions