WITH dim_date AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_date
), dim_oa_project AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_project
), dimh_oa_project AS (
    SELECT * FROM AV_EDM.AV_STAGING.dimh_openair_project
), dim_oa_timeentry AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_time_entries
), first_last_time_entry AS (
    select p.id
        ,min(time_entry_date) as first_time_entry
        ,max(time_entry_date) as last_time_entry
    from dim_oa_project p JOIN dim_oa_timeentry t on p.id = t.project_id
    group by p.id
), snap_creation_date AS (
    select id
        ,min(effective_date_start)::timestamp_NTZ as first_creation_snapshot_date
        ,max(effective_date_end)::timestamp_NTZ as last_snapshot_date
    from dimh_oa_project
    --where is_first_snapshot = true
    group by id
)
select dop.id
    ,dop.start_date as start_date
    ,dop.close_completed_date as close_completed_date
    ,te.first_time_entry as first_time_entry
    ,te.last_time_entry as last_time_entry
    ,scd.first_creation_snapshot_date as first_creation_snapshot_date
    ,scd.last_snapshot_date as last_snapshot_date
from dim_oa_project dop LEFT JOIN first_last_time_entry te on dop.id = te.id
                        LEFT JOIN snap_creation_date scd on dop.id = scd.id
where dop.backlog_trend_group != 'na'