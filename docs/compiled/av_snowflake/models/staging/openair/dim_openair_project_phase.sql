WITH hist_dim_phase AS (
    SELECT * FROM AV_EDM.AV_STAGING.dimh_openair_project_phase where is_current = true
), sys_proj_task AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_project_task
)
select dph.project_task_phase_id AS project_phase_id
    ,dph.parent_id as parent_id
    ,pt.project_id AS project_id
    ,dph.name AS name
    ,dph.start_date AS start_date
    ,dph.is_deleted AS is_deleted
    ,dph.is_closed AS is_closed
    ,dph.is_first_go_live AS is_first_go_live
    ,dph.planned_go_live_date AS planned_go_live_date
    ,dph.revised_go_live_date AS revised_go_live_date
    ,pt.fnlt_date AS fnlt_date
    ,pt.created AS sys_created
    ,pt.updated AS sys_updated
from hist_dim_phase dph JOIN sys_proj_task pt on dph.project_task_phase_id = pt.id