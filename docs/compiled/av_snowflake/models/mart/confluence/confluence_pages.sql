WITH pages AS (
    SELECT * FROM AV_EDM.AV_STAGING.stg_confluence_pages
)
SELECT 
       page_id AS page_id
       ,page_name as page_name
       ,space_id as space_id
       ,parent_page_id as parent_page_id
       ,parent_page_type as parent_page_type
       ,created_date AS created_date
       ,created_by_id AS created_by_id
       ,owner_id as owner_id
       ,last_modified_by_id AS last_modified_by_id
       ,position as position
       ,source_template_entity_id as source_template_entity_id
       ,status as status
       ,last_updated_by_id AS last_updated_by_id
       ,last_updated_date AS last_updated_date
       ,last_updated_version_message AS last_updated_version_message
       ,last_updated_version_number AS last_updated_version_number

FROM pages