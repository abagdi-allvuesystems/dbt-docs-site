
  create or replace   view AV_EDM.AV_SYSTEM.openair_work_schedule
  
  
  
  
  as (
    WITH work_schedule AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_work_schedule
)

SELECT 
        id::INT as id
        ,user_id::INT AS user_id
        ,IFNULL(use_this_schedule,false)::BOOLEAN AS use_this_schedule
        ,account_workschedule_id::INT AS account_work_schedule_id
        ,name::VARCHAR AS name
        ,created::TIMESTAMP_TZ AS created
        ,updated::TIMESTAMP_TZ AS updated
        ,_extracted_at::TIMESTAMP_TZ AS raw_updated

FROM
        work_schedule
  );

