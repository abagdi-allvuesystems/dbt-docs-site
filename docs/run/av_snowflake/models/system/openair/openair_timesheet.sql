
  create or replace   view AV_EDM.AV_SYSTEM.openair_timesheet
  
  
  
  
  as (
    WITH timesheet AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_timesheet
)

SELECT 
    id::INT AS id
    ,CASE WHEN date_start = '0000-00-00' THEN NULL
                ELSE date_start END::DATE AS date_start
    ,CASE WHEN date_end = '0000-00-00' THEN NULL
                ELSE date_end END::DATE AS date_end
    ,duration::VARCHAR AS duration
    ,name::VARCHAR AS name
    ,user_id::INT AS user_id
    ,status::VARCHAR AS status
    ,total::decimal(10,2) AS total
    ,CASE WHEN date_submitted = '0000-00-00' THEN NULL
                ELSE date_submitted END::DATE AS date_submitted
    ,CASE WHEN date_approved = '0000-00-00' THEN NULL
                ELSE date_approved END::DATE AS date_approved
    ,CASE WHEN date_archived = '0000-00-00' THEN NULL
                ELSE date_archived END::DATE AS date_archived
    ,notes::VARCHAR AS notes
    ,history::VARCHAR AS history
    ,default_customer::INT AS default_customer
    ,default_project::INT AS default_project
    ,submit_warning::BOOLEAN AS submit_warning
    ,IFNULL(deleted,false)::BOOLEAN AS deleted
    ,created::TIMESTAMP_NTZ AS created
    ,updated::TIMESTAMP_NTZ AS updated
    ,CASE WHEN acct_date = '0000-00-00' THEN NULL
                ELSE acct_date END::DATE AS acct_date
    ,start_end_month_ts::VARCHAR AS start_end_month_ts
    ,associated_tm_id::INT AS associated_tm_id

FROM timesheet
  );

