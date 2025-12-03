
  
    

create or replace transient table AV_EDM.AV_CX_PS.fact_ps_project_task_backlog
    
    
    
    as (--Task will exist on a day, if it's not finished on the day (open) or it was finished the previous day

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
), ps_task AS (
    SELECT * FROM AV_EDM.AV_CX_PS.ps_project_task
), ps_project AS (
    SELECT * FROM AV_EDM.AV_CX_PS.ps_project
), daily_facts AS (
    SELECT * FROM AV_EDM.AV_CX_PS.fact_ps_project_task_metrics_daily
), dim_oa_project_dates AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_project_dates
), derived_project_dates AS (
    select id
        ,LEAST_IGNORE_NULLS(start_date,first_time_entry,first_creation_snapshot_date)::DATE as derived_start_date
        ,GREATEST_IGNORE_NULLS(GREATEST(close_completed_date,last_time_entry))::DATE as derived_end_date
    from dim_oa_project_dates
    where LEAST_IGNORE_NULLS(start_date,first_time_entry,first_creation_snapshot_date)::DATE > '1/1/2023' 
                OR first_creation_snapshot_date is not null
), quarterly_facts AS (
    SELECT df.date
        ,'Quarterly' AS period_type
        ,dd.year_quarter AS period
        ,LAG(df.date) OVER (PARTITION BY project_task_id ORDER BY df.date asc)::DATE as prev_fact_date
        ,df.project_task_id
        ,df.project_id
        ,df.project_stage
        ,df.derived_start_date
        ,df.derived_end_date
        ,df.task_status
        ,df.worked_hours
        ,df.approved_hours
        ,df.worked_hours - LAG(df.worked_hours) OVER (PARTITION BY project_task_id ORDER BY df.date asc)::DECIMAL(10,2) as newly_worked_hours
        ,df.eac_hours
        ,df.eac_hours - LAG(df.eac_hours) OVER (PARTITION BY project_task_id ORDER BY df.date asc)::DECIMAL(10,2) as eac_hours_change
        ,df.task_etc_hours as task_etc_hours 
        ,LAG(df.task_etc_hours) OVER (PARTITION BY project_task_id ORDER BY df.date asc)::DECIMAL(10,2) AS prev_etc_hours
        ,df.is_first_go_live
        ,df.revised_go_live
        ,df.is_closed
        ,df.is_missing_billing_rule 
        
    FROM daily_facts df LEFT JOIN dim_date dd ON df.date = dd.date
    WHERE dd.is_last_day_of_quarter = 'true' AND dd.date >= '2024-10-17 00:00:00.000'

), weekly_facts AS (
    SELECT df.date::DATE as date
        ,'Weekly' AS period_type
        ,CONCAT(dd.the_year, '-Wk', dd.week_of_year ) AS period
        ,LAG(df.date) OVER (PARTITION BY project_task_id ORDER BY df.date asc)::DATE as prev_fact_date
        ,df.project_task_id
        ,df.project_id
        ,df.project_stage
        ,df.derived_start_date
        ,df.derived_end_date
        ,df.task_status
        ,df.worked_hours
        ,df.approved_hours
        ,df.worked_hours - LAG(df.worked_hours) OVER (PARTITION BY project_task_id ORDER BY df.date asc)::DECIMAL(10,2) as newly_worked_hours
        ,df.eac_hours
        ,df.eac_hours - LAG(df.eac_hours) OVER (PARTITION BY project_task_id ORDER BY df.date asc)::DECIMAL(10,2) as eac_hours_change
        ,df.task_etc_hours as task_etc_hours 
        ,LAG(df.task_etc_hours) OVER (PARTITION BY project_task_id ORDER BY df.date asc)::DECIMAL(10,2) AS prev_etc_hours
        ,df.is_first_go_live
        ,df.revised_go_live
        ,df.is_closed
        ,df.is_missing_billing_rule 
        FROM daily_facts df LEFT JOIN dim_date dd ON df.date = dd.date
    WHERE dd.is_last_day_of_week = 'true' AND dd.date >= '2024-10-19 00:00:00.000'

), monthly_facts AS (
    SELECT df.date::DATE as date
        ,'Monthly' AS period_type
        ,CONCAT(dd.the_year,'-',dd.month_name_abr) AS period
        ,LAG(df.date) OVER (PARTITION BY project_task_id ORDER BY df.date asc)::DATE as prev_fact_date
        ,df.project_task_id
        ,df.project_id
        ,df.project_stage
        ,df.derived_start_date
        ,df.derived_end_date
        ,df.task_status
        ,df.worked_hours
        ,df.approved_hours
        ,df.worked_hours - LAG(df.worked_hours) OVER (PARTITION BY project_task_id ORDER BY df.date asc)::DECIMAL(10,2) as newly_worked_hours
        ,df.eac_hours
        ,df.eac_hours - LAG(df.eac_hours) OVER (PARTITION BY project_task_id ORDER BY df.date asc)::DECIMAL(10,2) as eac_hours_change
        ,df.task_etc_hours as task_etc_hours 
        ,LAG(df.task_etc_hours) OVER (PARTITION BY project_task_id ORDER BY df.date asc)::DECIMAL(10,2) AS prev_etc_hours
        ,df.is_first_go_live
        ,df.revised_go_live
        ,df.is_closed
        ,df.is_missing_billing_rule 
        FROM daily_facts df LEFT JOIN dim_date dd ON df.date = dd.date
    WHERE dd.is_last_day_of_month = 'true' AND dd.date >= '2024-11-01 00:00:00.000'
)  

   
SELECT qf.date
        ,qf.period_type
        ,qf.period
        ,qf.prev_fact_date
        ,qf.project_task_id
        ,qf.project_id
        ,qf.project_stage
        ,qf.derived_start_date
        ,qf.derived_end_date
        ,dpd.derived_start_date AS derived_project_start_date
        ,dpd.derived_end_date AS derived_project_end_date
        ,qf.task_status
        ,qf.worked_hours AS task_worked_hours
        ,qf.approved_hours AS task_approved_hours
        ,qf.newly_worked_hours AS task_newly_worked_hours
        ,qf.eac_hours AS task_eac_hours
        ,qf.eac_hours_change AS task_eac_hours_change
        ,qf.prev_etc_hours AS starting_etc_hours
        ,qf.task_etc_hours AS ending_etc_hours
        ,qf.is_first_go_live
        ,qf.revised_go_live
        ,qf.is_closed
        ,qf.is_missing_billing_rule
        ,CASE WHEN 
                CONCAT(EXTRACT(QUARTER FROM dpd.derived_start_date ),EXTRACT(YEAR FROM dpd.derived_start_date )) = 
                CONCAT(EXTRACT(QUARTER FROM qf.date),EXTRACT(YEAR FROM qf.date)) THEN
                CASE WHEN IFNULL(qf.eac_hours,0) = 0 THEN qf.worked_hours
                    ELSE qf.eac_hours END ELSE 0 
                END AS new_project_eac_hours 

    FROM quarterly_facts qf LEFT JOIN dim_date dd ON qf.date = dd.date
            LEFT JOIN ps_project pp ON qf.project_id = pp.id
            LEFT JOIN derived_project_dates dpd ON qf.project_id = dpd.id



UNION       


SELECT wf.date
        ,wf.period_type
        ,wf.period
        ,wf.prev_fact_date
        ,wf.project_task_id
        ,wf.project_id
        ,wf.project_stage
        ,wf.derived_start_date
        ,wf.derived_end_date
        ,dpd.derived_start_date AS derived_project_start_date
        ,dpd.derived_end_date AS derived_project_end_date
        ,wf.task_status
        ,wf.worked_hours AS task_worked_hours
        ,wf.approved_hours AS task_approved_hours
        ,wf.newly_worked_hours AS task_newly_worked_hours
        ,wf.eac_hours AS task_eac_hours
        ,wf.eac_hours_change AS task_eac_hours_change
        ,wf.prev_etc_hours AS starting_etc_hours
        ,wf.task_etc_hours AS ending_etc_hours
        ,wf.is_first_go_live
        ,wf.revised_go_live
        ,wf.is_closed
        ,wf.is_missing_billing_rule
        ,CASE WHEN 
                CONCAT(EXTRACT(WEEK FROM dpd.derived_start_date),EXTRACT(YEAR FROM dpd.derived_start_date)) = 
                CONCAT(EXTRACT(WEEK FROM wf.date),EXTRACT(YEAR FROM wf.date)) THEN
                CASE WHEN IFNULL(wf.eac_hours,0) = 0 THEN wf.worked_hours
                    ELSE wf.eac_hours END 
                ELSE 0 END AS new_project_eac_hours

    FROM weekly_facts wf LEFT JOIN dim_date dd ON wf.date = dd.date
            LEFT JOIN ps_project pp ON wf.project_id = pp.id
            LEFT JOIN derived_project_dates dpd ON wf.project_id = dpd.id



UNION

SELECT mf.date
        ,mf.period_type
        ,mf.period
        ,mf.prev_fact_date
        ,mf.project_task_id
        ,mf.project_id
        ,mf.project_stage
        ,mf.derived_start_date
        ,mf.derived_end_date
        ,dpd.derived_start_date AS derived_project_start_date
        ,dpd.derived_end_date AS derived_project_end_date
        ,mf.task_status
        ,mf.worked_hours AS task_worked_hours
        ,mf.approved_hours AS task_approved_hours
        ,mf.newly_worked_hours AS task_newly_worked_hours
        ,mf.eac_hours AS task_eac_hours
        ,mf.eac_hours_change AS task_eac_hours_change
        ,mf.prev_etc_hours AS starting_etc_hours
        ,mf.task_etc_hours AS ending_etc_hours
        ,mf.is_first_go_live
        ,mf.revised_go_live
        ,mf.is_closed
        ,mf.is_missing_billing_rule
        ,CASE WHEN 
                CONCAT(EXTRACT(MONTH FROM dpd.derived_start_date ),EXTRACT(YEAR FROM dpd.derived_start_date )) = 
                CONCAT(EXTRACT(MONTH FROM mf.date),EXTRACT(YEAR FROM mf.date)) THEN
                CASE WHEN IFNULL(mf.eac_hours,0) = 0 THEN mf.worked_hours
                    ELSE mf.eac_hours END 
                ELSE 0 END AS new_project_eac_hours

    FROM monthly_facts mf LEFT JOIN dim_date dd ON mf.date = dd.date
            LEFT JOIN ps_project pp ON mf.project_id = pp.id
            LEFT JOIN derived_project_dates dpd ON mf.project_id = dpd.id
    )
;


  