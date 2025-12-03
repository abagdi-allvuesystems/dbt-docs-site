WITH ab_lit_board_sprints AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_lit_board_sprints
)

SELECT 

        sprintid::INT AS sprintid
       ,originboardid::INT AS originboardid
       ,sprintname::VARCHAR AS sprintname
       ,sprintstate::VARCHAR AS sprintstate
       ,sprintisostartdate::TIMESTAMP_TZ AS sprintisostartdate
       ,sprintisoenddate::TIMESTAMP_TZ AS sprintisoenddate
       ,sprintisocompletedate::TIMESTAMP_TZ AS sprintisocompletedate
       ,updatedate::TIMESTAMP_TZ AS updatedate
       ,sprintitemupdatedate::TIMESTAMP_TZ AS sprintitemupdatedate
       ,updateuser::VARCHAR AS updateuser
       ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated

FROM ab_lit_board_sprints