
  create or replace   view AV_EDM.AV_STAGING.dimh_openair_project
  
  
  
  
  as (
    --This blends original OpenAir snapshots with current dbt snapshots.

WITH oa_legacy_snap as (
    SELECT * FROM AV_EDM.AV_STAGING.dimh_openair_project_snapshot_rpt 
--), dbt_oa_proj_snap AS (
--    SELECT * FROM AV_EDM.AV_SYSTEM.openair_project_snapshot 
), oa_project_stage as (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_project_stage
), oa_project AS (
    SELECT id
        ,name
    FROM AV_EDM.AV_SYSTEM.openair_project
), all_snaps as (
        select ls.project_id AS id  
        ,ls.effective_date_start::DATE AS effective_date_start
        ,ls.effective_date_end AS effective_date_end
        ,op.name AS name
        ,sta.id AS project_stage_id
        ,ls.project_stage AS project_stage
        ,NULL AS project_type
        ,NULL AS segment
        ,NULL AS project_owner_id
        ,NULL AS delivery_lead_id
        ,NULL AS is_active
        ,NULL AS in_active_implementation
        ,NULL AS is_deleted
        ,ls.rag_status AS rag_overall
        ,NULL AS budget
        ,ls.budget_hours AS budget_hours
        ,CASE WHEN IFNULL(ls.eac_hours,0) = 0 THEN ls.budget_hours
            ELSE ls.eac_hours
            END AS eac_hours
        ,ls.approved_hours AS approved_hours_field
        ,NULL AS is_rev_drain_current
        ,NULL AS is_on_invoicing_hold
        ,NULL AS special_billing_situation
        ,NULL AS start_date
        ,NULL AS finish_date
        ,NULL AS planned_go_live
        ,NULL AS revised_go_live
        ,NULL AS close_completed_date
    from oa_legacy_snap ls
        LEFT JOIN oa_project_stage sta ON ls.project_stage = sta.name
        LEFT JOIN oa_project op ON ls.project_id = op.id

  --  UNION
--
  --  SELECT ps.id AS id  
  --      ,ps.snapshot_valid_from AS effective_date_start
  --      ,ps.snapshot_valid_to AS effective_date_end
  --      ,ps.name AS name
  --      ,ps.project_stage_id AS project_stage_id
  --      ,sta.name AS project_stage
  --      ,ps.custom_151 AS project_type
  --      ,ps.custom_309 AS segment
  --      ,ps.user_id AS project_owner_id
  --      ,ps.custom_245 AS delivery_lead_id
  --      ,ps.active AS is_active
  --      ,ps.custom_365 AS in_active_implementation
  --      ,ps.deleted AS is_deleted
  --      ,ps.custom_200 AS rag_overall
  --      ,ps.budget AS budget
  --      ,ps.budget_hours AS budget_hours
  --      ,CASE WHEN IFNULL(ps.custom_236,0) = 0 THEN ps.budget_hours
  --          ELSE ps.custom_236
  --          END AS eac_hours
  --      ,ps.custom_318 AS approved_hours_field
  --      ,ps.custom_329 AS is_rev_drain_current
  --      ,ps.custom_189 AS is_on_invoicing_hold
  --      ,ps.custom_183 AS special_billing_situation
  --      ,ps.start_date AS start_date
  --      ,ps.finish_date AS finish_date
  --      ,ps.custom_90 AS planned_go_live
  --      ,ps.custom_91 AS revised_go_live
  --      ,ps.custom_327 AS close_completed_date
  --  from dbt_oa_proj_snap ps
  --      LEFT JOIN oa_project_stage sta ON ps.project_stage_id = sta.id
)
    
SELECT 
    id
    ,effective_date_start
    ,COALESCE(
        effective_date_end, 
        LEAD(effective_date_start) OVER (PARTITION BY id ORDER BY effective_date_start)
    ) AS effective_date_end
    ,CASE 
        WHEN effective_date_end IS NULL AND LEAD(effective_date_start) OVER (PARTITION BY id ORDER BY effective_date_start) IS NULL 
        THEN TRUE 
        ELSE FALSE END::BOOLEAN AS is_current
    ,name
    ,project_stage_id
    ,project_stage
    ,project_type
    ,segment
    ,project_owner_id
    ,delivery_lead_id
    ,is_active
    ,in_active_implementation
    ,is_deleted
    ,rag_overall
    ,budget
    ,budget_hours
    ,eac_hours
    ,approved_hours_field
    ,is_rev_drain_current
    ,is_on_invoicing_hold
    ,special_billing_situation
    ,start_date
    ,finish_date
    ,planned_go_live
    ,revised_go_live
    ,close_completed_date
    ,ROW_NUMBER() OVER (PARTITION BY id ORDER BY effective_date_start) AS snapshot_rank
    ,CASE WHEN ROW_NUMBER() OVER (PARTITION BY id ORDER BY effective_date_start) = 1 THEN true ELSE false END::BOOLEAN as is_first_snapshot
FROM all_snaps
  );

