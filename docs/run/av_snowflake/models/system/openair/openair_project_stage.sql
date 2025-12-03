
  create or replace   view AV_EDM.AV_SYSTEM.openair_project_stage
  
  
  
  
  as (
    WITH project_stage AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_project_stage
)

SELECT 
        id::INT AS id
        ,name::VARCHAR AS name
        ,position::INT AS position
        ,CASE WHEN created = '0000-00-00 00:00:00' THEN NULL
                ELSE created END::TIMESTAMP_NTZ AS created
        ,CASE WHEN updated = '0000-00-00 00:00:00' THEN NULL
                ELSE updated END::TIMESTAMP_NTZ AS updated 
FROM 
        project_stage
  );

