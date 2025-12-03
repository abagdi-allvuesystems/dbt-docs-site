
  create or replace   view AV_EDM.AV_SYSTEM.jira_sprints
  
  
  
  
  as (
    WITH raw_sprints AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_jira_sprints
)
SELECT 
        id::INT AS id
        ,name::VARCHAR AS name
        ,state::VARCHAR AS state
        ,originboardid::INT AS originboardid
        ,boardid::INT AS boardid
        ,startdate::TIMESTAMP_TZ AS startdate
        ,enddate::TIMESTAMP_TZ AS enddate
        ,completedate::TIMESTAMP_TZ AS completedate
        ,createddate::TIMESTAMP_TZ AS sys_created
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated

FROM raw_sprints
  );

