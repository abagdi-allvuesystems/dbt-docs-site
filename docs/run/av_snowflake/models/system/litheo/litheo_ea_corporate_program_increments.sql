
  create or replace   view AV_EDM.AV_SYSTEM.litheo_ea_corporate_program_increments
  
  
  
  
  as (
    WITH ab_lit_pis AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_lit_corporate_program_increments
)

SELECT 

        id::INT AS id
        ,name::VARCHAR AS name
        ,startdate::DATE AS startdate
        ,enddate::DATE AS enddate
        ,pistate::VARCHAR AS pistate
        ,epicreadinessdate::DATE AS epicreadinessdate
        ,pireadinessdate::DATE AS pireadinessdate
        ,jirapiname::VARCHAR AS jirapiname
        ,adddate::TIMESTAMP_TZ AS adddate
        ,updatedate::TIMESTAMP_TZ AS updatedate
        ,adduser::VARCHAR AS adduser
        ,updateuser::VARCHAR AS updateuser
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated

FROM ab_lit_pis
  );

