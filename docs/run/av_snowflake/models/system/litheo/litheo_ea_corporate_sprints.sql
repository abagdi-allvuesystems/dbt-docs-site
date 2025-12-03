
  create or replace   view AV_EDM.AV_SYSTEM.litheo_ea_corporate_sprints
  
  
  
  
  as (
    WITH ab_lit_corp_sprints AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_lit_corporate_sprints
)
SELECT 

        id::INT AS id
        ,name::VARCHAR AS name
        ,sprintstartbegin::DATE AS sprintstartbegin
        ,sprintstartend::DATE AS sprintstartend
        ,sprintstate::VARCHAR AS sprintstate
        ,corporatepiid::INT AS corporatepiid
        ,adddate::TIMESTAMP_TZ AS adddate
        ,updatedate::TIMESTAMP_TZ AS updatedate
        ,adduser::VARCHAR AS adduser
        ,updateuser::VARCHAR AS updateuser
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated

FROM ab_lit_corp_sprints
  );

