
  create or replace   view AV_EDM.AV_SYSTEM.openair_task
  
  
  
  
  as (
    --Basic unit of a timesheet, multiple tasks to one timesheet
-- Will be associated to a slip if this task was billed

WITH task AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_task
)

SELECT
        id::INT AS id
        ,customer_id::INT AS customer_id
        ,project_id::INT AS project_id
        ,project_task_id::INT AS project_task_id
        ,user_id::INT AS user_id
        ,slip_id::INT AS slip_id
        ,timesheet_id::INT AS timesheet_id
        ,hour::INT AS hour
        ,minute::INT AS minute
        ,hour::INT + (minute::INT/60) AS decimal_hour
        ,description::VARCHAR AS description
        ,notes::VARCHAR AS notes
        ,CASE WHEN date = '0000-00-00' THEN NULL
                ELSE date END::DATE AS date
        ,created::TIMESTAMP_NTZ AS created
        ,updated::TIMESTAMP_NTZ AS updated
        ,IFNULL(deleted,false)::BOOLEAN AS deleted
        ,category_id::INT AS category_id
        ,projecttask_type_id::INT AS projecttask_type_id
        ,CASE WHEN acct_date = '0000-00-00' THEN NULL 
                ELSE acct_date END::DATE AS acct_date
        ,job_code_id::INT AS job_code_id
        

FROM 
        task
  );

