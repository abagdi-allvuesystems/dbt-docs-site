
  create or replace   view AV_EDM.AV_STAGING.dimh_openair_project_snapshot_rpt
  
  
  
  
  as (
    --This model's intent is to standardize type 2 dimension concepts for the existing Project Snapshot report data.
--As of 10/19 OpenAir's project and project task snapshots should take over for the use of this data
--A big assumption on the effective dates is that the snapshot was only done once a week. The effective date window
--   makes the attributes true for the week time period but the details were obviously subject to change daily
WITH oa_legacy_snap AS (
    SELECT * from AV_EDM.AV_SYSTEM.openair_rpt_issue_project_snapshot where project_id is not null -- order by snapshot_date desc
), proj_stage AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_project_stage
)
select project_id
    ,snapshot_date::TIMESTAMP_NTZ as effective_date_start
    ,LAG(snapshot_date) OVER (PARTITION BY project_id ORDER BY snapshot_date desc)::TIMESTAMP_NTZ as effective_date_end
    ,project_stage
    ,budget_hours
    ,eac_hours
    ,approved_hours
    ,worked_hours
    ,etc_hours
    ,rag_status
    ,ROW_NUMBER() OVER (PARTITION BY project_id ORDER BY snapshot_date) AS snapshot_rank
    ,CASE WHEN ROW_NUMBER() OVER (PARTITION BY project_id ORDER BY snapshot_date) = 1 THEN true ELSE false END::BOOLEAN as is_initial_snapshot
    ,CASE WHEN snapshot_date > '2025-04-14' then TRUE
        WHEN snapshot_date < '2025-03-01' AND snapshot_date > '2024-10-13' then TRUE      --during this time period the dbt snapshots were not working so we need to rely on oa snaps instead.
        ELSE FALSE END::BOOLEAN AS overlap_w_dbt_snaps
from oa_legacy_snap
  );

