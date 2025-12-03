
  create or replace   view AV_EDM.AV_SYSTEM.openair_target_utilization
  
  
  
  
  as (
    WITH target_utilization AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_target_utilization
)

SELECT  
        id::INT AS id
        ,user_id::INT AS user_id
        ,NULLIF(start_date,'0000-00-00')::DATE AS start_date
        ,NULLIF(end_date,'0000-00-00')::DATE AS end_date
        ,percentage::FLOAT AS percentage
        ,created::TIMESTAMP_TZ AS created
        ,updated::TIMESTAMP_TZ AS updated
        ,_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM
        target_utilization
  );

