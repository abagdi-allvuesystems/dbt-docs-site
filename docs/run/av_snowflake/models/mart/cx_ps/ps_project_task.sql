
  
    

create or replace transient table AV_EDM.AV_CX_PS.ps_project_task
    
    
    
    as (WITH dim_oa_task AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_project_task
), dim_oa_timeentry AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_time_entries where deleted = false
), actual_hours_cal AS (
    SELECT project_task_id as project_task_id
           ,sum(decimal_hour) as actual_hours
        FROM dim_oa_timeentry
        GROUP BY project_task_id
)
select dot.project_task_id as id
    ,'openair' as source_system
    ,dot.name as name
    ,dot.id_number as id_number
    ,dot.project_phase_id as parent_phase_id
    ,dot.project_id as project_id
    ,dot.task_status as task_status
    ,dot.task_type as task_type
    ,dot.scope_hours AS scope_hours
    ,dot.eac_hours as eac_hours
    ,ahc.actual_hours as worked_hours
    ,dot.product as product
    ,dot.sub_product as sub_product
    ,dot.custom_or_standard as custom_or_standard
    ,dot.planned_go_live_date as planned_go_live
    ,dot.sys_created AS created
    ,dot.sys_updated AS updated
FROM dim_oa_task dot LEFT JOIN actual_hours_cal ahc on dot.project_task_id = ahc.project_task_id
    )
;


  