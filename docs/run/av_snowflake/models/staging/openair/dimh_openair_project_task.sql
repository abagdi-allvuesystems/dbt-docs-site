
  create or replace   view AV_EDM.AV_STAGING.dimh_openair_project_task
  
  
  
  
  as (
    --A project task is considered anything that is not marked as a phase.
WITH oa_proj_task_tasks AS (
    SELECT id, custom_352 AS scope_hours FROM AV_EDM.AV_SYSTEM.openair_project_task where is_a_phase = false
), oa_proj_task_snap AS (
    SELECT * FROM av_edm_snapshots.openair.openair_project_task_snapshot 
)
SELECT pts.id AS project_task_id
    ,pts.dbt_valid_from AS effective_date_start
    ,pts.dbt_valid_to AS effective_date_end
    ,CASE WHEN pts.dbt_valid_to IS NULL THEN true ELSE false END::BOOLEAN as is_current
    ,pts.parent_id AS parent_id
    ,pts.name AS name
    ,pts.id_number AS id_number
    ,pts.custom_154 AS task_status
    ,pts.custom_290 AS product
    ,pts.custom_291 AS sub_product
    ,CASE WHEN pts.custom_352 = 0 THEN tsk.scope_hours
        ELSE pts.custom_352
        END AS eac_hours
    ,pts.custom_315 AS actual_hours__field
    ,pts.start_date AS start_date
    ,pts.custom_370 AS is_first_go_live
    ,pts.custom_372 AS revised_actual_go_live_date
    ,pts.custom_374 AS is_missing_billing_rule
    ,pts.deleted as is_deleted
    ,pts.closed as is_closed
    ,ROW_NUMBER() OVER (PARTITION BY pts.id ORDER BY pts.dbt_valid_from) AS snapshot_rank
    ,CASE WHEN ROW_NUMBER() OVER (PARTITION BY pts.id ORDER BY pts.dbt_valid_from) = 1 THEN true ELSE false END::BOOLEAN as is_first_snapshot
FROM oa_proj_task_snap pts JOIN oa_proj_task_tasks tsk on pts.id = tsk.id
  );

