
  create or replace   view AV_EDM.AV_SYSTEM.litheo_ea_agile_groups
  
  
  
  
  as (
    WITH ab_lit_agile_teams AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_lit_agile_groups
)

SELECT 

        id::INT AS id
       ,name::VARCHAR AS name
       ,adddate::TIMESTAMP_TZ AS adddate
       ,updatedate::TIMESTAMP_TZ AS updatedate
       ,adduser::VARCHAR AS adduser
       ,updateuser::VARCHAR AS updateuser
       ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated

FROM ab_lit_agile_teams
  );

