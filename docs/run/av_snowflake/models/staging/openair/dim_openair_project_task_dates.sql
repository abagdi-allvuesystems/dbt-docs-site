
  create or replace   view AV_EDM.AV_STAGING.dim_openair_project_task_dates
  
  
  
  
  as (
    WITH dim_date AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_date
), dim_oa_task AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_project_task
), dimh_oa_task AS (
    SELECT * FROM AV_EDM.AV_STAGING.dimh_openair_project_task
), dim_oa_timeentry AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_time_entries
), first_last_time_entry AS (
    select t.project_task_id
        ,min(te.time_entry_date) as first_time_entry
        ,max(te.time_entry_date) as last_time_entry
    from dim_oa_task t JOIN dim_oa_timeentry te on t.project_task_id = te.project_task_id
    group by t.project_task_id
), snap_creation_date AS (
    select project_task_id
        ,min(effective_date_start)::timestamp_NTZ as first_creation_snapshot_date
    from dimh_oa_task
    where is_first_snapshot = true
    group by project_task_id
)
select dop.project_task_id
    ,dop.project_id
    ,dop.start_date as start_date
    ,dop.finish_date as finish_date
    ,te.first_time_entry as first_time_entry
    ,te.last_time_entry as last_time_entry
    ,dop.planned_go_live_date AS planned_go_live_date
    ,dop.revised_actual_go_live_date AS revised_actual_go_live_date
    ,scd.first_creation_snapshot_date as first_creation_snapshot_date
from dim_oa_task dop LEFT JOIN first_last_time_entry te on dop.project_task_id = te.project_task_id
                        LEFT JOIN snap_creation_date scd on dop.project_task_id = scd.project_task_id
  );

