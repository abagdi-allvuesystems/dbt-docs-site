
  create or replace   view AV_EDM.AV_STAGING.dimh_openair_project_phase
  
  
  
  
  as (
    --Projects can have phases which exist as phases of other phases. This model is meant to "collapse" or to
-- only capture the level directly above the Project Task (non-phase)
WITH oa_proj_task_phases AS (
    SELECT distinct id FROM AV_EDM.AV_SYSTEM.openair_project_task where is_a_phase = true
), oa_proj_task_snap AS (
    SELECT * FROM av_edm_snapshots.openair.openair_project_task_snapshot
)
    select pts.id AS project_task_phase_id
        ,pts.dbt_valid_from AS effective_start_date
        ,pts.dbt_valid_to AS effective_end_date
        ,CASE WHEN pts.dbt_valid_to IS NULL THEN true else false END::BOOLEAN AS is_current
        ,pts.parent_id AS parent_id
        ,pts.name AS name
        ,pts.start_date AS start_date
        ,pts.deleted AS is_deleted
        ,pts.closed AS is_closed
        ,pts.custom_369 AS is_first_go_live
        ,pts.custom_213 AS planned_go_live_date
        ,pts.custom_212 AS revised_go_live_date
    FROM oa_proj_task_snap pts JOIN oa_proj_task_phases ph on pts.id = ph.id
  );

