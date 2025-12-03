--this model separates out the Snapshot issues, only.  The purpose is in case there is a need to refer to them in the future, even though the new process uses dbt snapshots.

WITH snapshot AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_issue WHERE issue_category_id = 2
)

select sp.id AS id
    ,sp.project_id AS project_id
    ,sp.custom_340 AS project_stage
    ,sp.date AS snapshot_date
    ,sp.custom_334 AS budget_hrs
    ,sp.custom_335 AS eac_hrs
    ,sp.custom_337 AS approved_hrs
    ,sp.custom_336 AS worked_hours    
    ,sp.custom_338 AS etc_hours
    ,sp.custom_339 AS rag_status
    ,sp.custom_350 AS close_date
from snapshot sp