WITH ab_lit_agile_team_boards AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_lit_agile_team_boards
)
SELECT 

        id::INT AS id
       ,agileteamid::INT AS agileteamid
       ,jiraboardid::INT AS jiraboardid
       ,isactive::BOOLEAN AS isactive
       ,adddate::TIMESTAMP_TZ AS adddate
       ,updatedate::TIMESTAMP_TZ AS updatedate
       ,adduser::VARCHAR AS adduser
       ,updateuser::VARCHAR AS updateuser
       ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated

FROM ab_lit_agile_team_boards