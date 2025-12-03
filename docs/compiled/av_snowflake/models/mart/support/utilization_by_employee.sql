WITH dim_oa_time_entries AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_time_entries where status_name != 'rejected' and deleted != true
), dim_oa_user AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_user
), dim_oa_projects AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_project
), dim_project_task AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_project_task
)
SELECT dote.user_id AS user_id
    ,dote.user_name as user_name
    ,dou.department_name as user_department
    ,dou.user_delivery_org as user_functional_team
    ,dou.line_manager_name as user_manager
    ,dop.name as project_name
    ,dop.segment as project_segment
    ,dot.name as task_name
    ,dot.task_type as task_type
    ,dote.time_entry_date as time_entry_date
    ,dote.hour as hours
    ,dote.minute as minute
    ,dote.decimal_hour as decimal_hour
    ,dote.timesheet_name as timesheet_name
    ,dote.created as timesheet_createad_date
    ,dote.date_submitted as timesheet_submitted_date
    ,dote.date_approved as timesheet_apporved_date
from dim_oa_time_entries dote LEFT JOIN dim_oa_user dou ON dote.user_id = dou.id
                              LEFT JOIN dim_oa_projects dop ON dote.project_id = dop.id
                              LEFT JOIN dim_project_task dot ON dote.project_task_id = dot.project_task_id
where dou.user_delivery_org = 'Customer Support'