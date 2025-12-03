WITH dim_oa_phase AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_project_phase 
)
select project_phase_id AS project_phase_id
    ,parent_id as parent_id
    ,project_id as project_id
    ,name as name
    ,start_date as start_date
    ,is_deleted as is_deleted
    ,is_closed as is_closed
    ,is_first_go_live as is_first_go_live
    ,planned_go_live_date as planned_go_live_date
    ,revised_go_live_date as revised_go_live_date
    ,fnlt_date as fnlt_date
    ,sys_created as sys_created
    ,sys_updated as sys_updated
from dim_oa_phase