--Task will exist on a day, if it's not finished on the day (open) or it was finished the previous day

-- Fact table will start showing values on the earlier event of
--   Start Date on Task
--   First Time Entry
--   First time we see the task on the rpt snapshot

-- Last Date
--   Finish Date
--   Date marked inactive
--   Last Time Entry

WITH dim_date AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_date
), dim_oa_task AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_project_task
), dimh_oa_project AS(
    SELECT * FROM AV_EDM.AV_STAGING.dimh_openair_project
), ps_project AS (
    SELECT * FROM AV_EDM.AV_CX_PS.ps_project
), dimh_oa_task AS (
    SELECT * FROM AV_EDM.AV_STAGING.dimh_openair_project_task
), dim_oa_timeentry AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_time_entries where deleted = false
), dim_oa_task_dates AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_project_task_dates
), derived_fact_dates AS (
    select project_task_id
        ,project_id
        ,LEAST_IGNORE_NULLS(start_date,first_time_entry,first_creation_snapshot_date)::DATE as derived_start_date
        ,GREATEST_IGNORE_NULLS(GREATEST(finish_date,last_time_entry))::DATE as derived_end_date
    from dim_oa_task_dates
    where LEAST_IGNORE_NULLS(start_date,first_time_entry,first_creation_snapshot_date)::DATE > '1/1/2023' 
                OR first_creation_snapshot_date is not null
), fact_ids as (
    select dd.date as date
        ,dfd.project_task_id as project_task_id
        ,dfd.project_id AS project_id
        ,dfd.derived_start_date
        ,dfd.derived_end_date
    from dim_date dd LEFT JOIN derived_fact_dates dfd on dd.date >= dfd.derived_start_date
                                                        AND (dd.date <= dfd.derived_end_date or dfd.derived_end_date is null)
    where (dfd.derived_start_date is not null or dfd.derived_end_date is not null) and dd.date >= '1/1/2023' and dd.date <= GETDATE()
), worked_hours AS (
    select fi.date
            ,fi.project_task_id
            ,sum(te.decimal_hour) as worked_hours
    from fact_ids fi LEFT JOIN dim_oa_timeentry te on fi.project_task_id = te.project_task_id AND te.time_entry_date <= fi.date
    group by fi.date,fi.project_task_id
), approved_hours AS (
        select fi.date
            ,fi.project_task_id
            ,sum(tea.decimal_hour) as approved_hours
    from fact_ids fi LEFT JOIN dim_oa_timeentry tea on fi.project_task_id = tea.project_task_id and tea.date_approved <= fi.date
    group by fi.date,fi.project_task_id
), newly_worked_hours AS (
    select fi.date
            ,fi.project_task_id
            ,sum(te.decimal_hour) as worked_hours
    from fact_ids fi LEFT JOIN dim_oa_timeentry te on fi.project_task_id = te.project_task_id AND te.time_entry_date = fi.date
    group by fi.date,fi.project_task_id
)

SELECT fi.date
        ,fi.project_task_id
        ,MD5(CONCAT(fi.project_id::VARCHAR
                 ,IFNULL(dot.product,'(Not Identified)') ))
                 AS proj_prod_key
        ,fi.project_id
        ,dot.product
        ,dop.project_stage
        ,fi.derived_start_date
        ,fi.derived_end_date
        ,dot.task_status AS task_status
        ,IFNULL(wh.worked_hours,0)::DECIMAL(10,2) as worked_hours
        ,IFNULL(ah.approved_hours,0)::DECIMAL(10,2) as approved_hours
        ,IFNULL(nwh.worked_hours,0)::DECIMAL(10,2) as newly_worked_hours
        ,CASE WHEN dht.eac_hours = 0 THEN dot.scope_hours
                WHEN dht.eac_hours IS NULL THEN dot.scope_hours
                ELSE dht.eac_hours END AS eac_hours
        ,CASE WHEN dht.eac_hours = 0 THEN dot.scope_hours
                WHEN dht.eac_hours IS NULL THEN dot.scope_hours
                ELSE dht.eac_hours END - IFNULL(wh.worked_hours,0) as task_etc_hours
        ,dht.is_first_go_live AS is_first_go_live
        ,dht.revised_actual_go_live_date AS revised_go_live
        ,dht.is_closed AS is_closed
        ,dht.is_missing_billing_rule as is_missing_billing_rule
    from fact_ids fi LEFT JOIN worked_hours wh on fi.date = wh.date and fi.project_task_id = wh.project_task_id
                    LEFT JOIN approved_hours ah on fi.date = ah.date and fi.project_task_id = ah.project_task_id
                    LEFT JOIN newly_worked_hours nwh on fi.date = nwh.date and fi.project_task_id = nwh.project_task_id
                    LEFT JOIN dimh_oa_task dht on fi.project_task_id = dht.project_task_id AND fi.date >= dht.effective_date_start AND (fi.date < dht.effective_date_end OR dht.effective_date_end IS NULL)
                    LEFT JOIN dim_oa_task dot on fi.project_task_id = dot.project_task_id
                    LEFT JOIN dimh_oa_project dop ON fi.project_id = dop.id AND fi.date >= dop.effective_date_start AND (fi.date < dop.effective_date_end OR dop.effective_date_end IS NULL)
                    LEFT JOIN ps_project pp ON fi.project_id = pp.id

--where derived_start_date >= '1/1/2023' and derived_end_date <= '12/31/2023'