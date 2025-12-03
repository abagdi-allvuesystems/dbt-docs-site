
  create or replace   view AV_EDM.AV_STAGING.dim_openair_time_entries
  
  
  
  
  as (
    WITH oa_tasks AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_task
), oa_user AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_user
), oa_time_sheet AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_timesheet
), dim_project_task AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_project_task
)
SELECT ot.id as task_id
    ,ot.customer_id as customer_id
    ,ot.project_id as project_id
    ,MD5(CONCAT(ot.project_id::VARCHAR
        ,IFNULL(pt.product,'(Not Identified)') ))
        AS proj_prod_key
    ,ot.project_task_id as project_task_id
    ,pt.product
    ,pt.sub_product
    ,ot.user_id as user_id
    ,ou.name as user_name
    ,ot.slip_id as slip_id
    ,ot.timesheet_id as timesheet_id
    ,ot.date as time_entry_date
    ,ot.hour as hour
    ,ot.minute as minute
    ,ot.hour::INT + (ot.minute::INT/60) AS decimal_hour
    ,ot.notes as notes
    ,CASE WHEN ts.status = 'A' THEN 'approved'
          WHEN ts.status = 'S' THEN 'submitted'
          WHEN ts.status = 'O' THEN 'open'
          WHEN ts.status = 'R' THEN 'rejected'
          ELSE null END::VARCHAR as status_name
    ,CASE WHEN ts.status = 'A' THEN true ELSE false END::BOOLEAN as is_approved
    ,ts.name as timesheet_name
    ,ts.date_submitted as date_submitted
    ,ts.date_approved as date_approved
    ,ot.acct_date as acct_date
    ,ot.created as created
    ,ot.updated as updated
    ,ot.deleted as deleted
from oa_tasks ot LEFT JOIN oa_user ou ON ot.user_id = ou.id
                 LEFT JOIN oa_time_sheet ts on ot.timesheet_id = ts.id
                 LEFT JOIN dim_project_task pt ON ot.project_task_id = pt.project_task_id
  );

