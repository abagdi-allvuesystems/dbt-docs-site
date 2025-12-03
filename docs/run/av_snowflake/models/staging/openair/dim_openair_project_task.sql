
  create or replace   view AV_EDM.AV_STAGING.dim_openair_project_task
  
  
  
  
  as (
    WITH hist_dim_task AS (
    SELECT * FROM AV_EDM.AV_STAGING.dimh_openair_project_task where is_current = true
), sys_proj_task AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_project_task 
), product_xref AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_litheo_product_xref
), sys_task_type AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_project_task_type
)
select dpt.project_task_id AS project_task_id
    ,dpt.parent_id as project_phase_id
    ,pt.project_id AS project_id
    ,dpt.name AS name
    ,dpt.id_number AS id_number
    ,dpt.task_status AS task_status
    ,tt.name AS task_type
    ,IFNULL(dpt.product,'(Not Identified)') AS product
    ,IFNULL(dpt.sub_product,'(Not Identified)') AS sub_product
    ,pt.custom_253 AS scope_hours
    ,pt.custom_289 AS custom_or_standard
    ,dpt.eac_hours AS eac_hours
    ,dpt.actual_hours__field as actual_hours__field
    ,dpt.start_date AS start_date
    ,dpt.is_first_go_live AS is_first_go_live
    ,dpt.is_deleted AS is_deleted
    ,dpt.is_closed AS is_closed
    ,pt.custom_371 AS planned_go_live_date
    ,dpt.revised_actual_go_live_date AS revised_actual_go_live_date
    ,pt.fnlt_date AS finish_date
    ,pt.custom_349 AS partner_customer_id
    ,dpt.is_missing_billing_rule AS is_missing_billing_rule
    ,pt.created AS sys_created
    ,pt.updated AS sys_updated
from hist_dim_task dpt JOIN sys_proj_task pt on dpt.project_task_id = pt.id
        JOIN sys_task_type tt ON pt.projecttask_type_id = tt.id
  );

