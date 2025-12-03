WITH ab_lit_agile_team_groups AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_lit_agile_team_groups
)
SELECT 

        id::INT AS id
        ,agilegroupid::INT AS agilegroupid
        ,agileteamid::INT AS agileteamid
        ,adddate::TIMESTAMP_TZ AS adddate
        ,updatedate::TIMESTAMP_TZ AS updatedate
        ,adduser::VARCHAR AS adduser
        ,updateuser::VARCHAR AS updateuser
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated

FROM ab_lit_agile_team_groups