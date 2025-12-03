WITH dim_date AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_date
), ps_project AS (
    SELECT * FROM AV_EDM.AV_CX_PS.ps_project
), daily_facts AS (
    SELECT * FROM AV_EDM.AV_CX_PS.fact_ps_project_metrics_daily 
), dim_oa_project_dates AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_project_dates
), derived_project_dates AS (
    select id
        ,LEAST_IGNORE_NULLS(start_date,first_time_entry,first_creation_snapshot_date)::DATE as derived_start_date
        ,GREATEST_IGNORE_NULLS(GREATEST(close_completed_date,last_time_entry))::DATE as derived_end_date
    from dim_oa_project_dates
    where LEAST_IGNORE_NULLS(start_date,first_time_entry,first_creation_snapshot_date)::DATE > '1/1/2023' 
                OR first_creation_snapshot_date is not null
), fact_periods AS (
    SELECT df.date
        ,df.project_id
        ,df.etc_hours
        ,df.newly_worked_hours
        ,df.eac_hours_change
        ,df.project_stage
        ,dd.start_of_week
        ,dd.end_of_week
        ,CONCAT(YEAROFWEEKISO(dd.start_of_week), '-Wk', WEEKISO(dd.start_of_week)) AS week_period
        ,dd.first_date_of_month
        ,dd.last_date_of_month
        ,CONCAT(dd.the_year, '-', dd.month_name_abr ) AS month_period
        ,dd.first_date_of_quarter
        ,dd.last_date_of_quarter
        ,dd.year_quarter AS quarter_period
    FROM daily_facts df LEFT JOIN dim_date dd ON df.date = dd.date
                        
),

--assemble facts from the beginning and end of the week, then combine them into weekly facts.

week_summary AS (
    SELECT df.project_id
        ,df.start_of_week
        ,df.end_of_week
        ,df.week_period AS period
        ,MIN(df.date) AS first_fact
        ,MAX(df.date) AS last_fact
        ,SUM(df.newly_worked_hours) AS newly_worked_hours
        ,SUM(df.eac_hours_change) AS eac_change_hours
    FROM fact_periods df WHERE df.end_of_week <= GETDATE() 
    
    GROUP BY df.project_id, df.week_period, df.start_of_week, df.end_of_week
), weekly_facts AS (
    SELECT fs.project_id
        ,fs.start_of_week AS fact_effective_start
        ,fs.end_of_week AS fact_effective_end
        ,'Weekly' AS period_type
        ,fs.period
        ,fs.first_fact
        ,fs.last_fact
        ,dp.derived_start_date
        ,dp.derived_end_date
        ,IFNULL(fp.etc_hours,0) AS starting_etc_hours
        ,IFNULL(fep.etc_hours,0) AS ending_etc_hours
        ,fs.newly_worked_hours
        ,fs.eac_change_hours        
        ,fp.project_stage AS starting_project_stage
        ,fep.project_stage AS ending_project_stage
        ,CASE WHEN dp.derived_start_date >= fs.start_of_week THEN TRUE
            ELSE FALSE END::BOOLEAN AS new_in_period
        ,CASE WHEN dp.derived_end_date <= fs.end_of_week THEN TRUE
            ELSE FALSE END::BOOLEAN AS ended_in_period
    FROM week_summary fs LEFT JOIN fact_periods fp ON fs.project_id = fp.project_id AND fs.start_of_week = fp.date  --join on daily facts only to find the facts on the start of the week
                        LEFT JOIN fact_periods fep ON fs.project_id = fep.project_id AND fs.end_of_week = fep.date  --join on daily facts only to find the facts on the end of the week
                        LEFT JOIN derived_project_dates dp ON fs.project_id = dp.id

),

--assemble facts from the beginning and end of the month, then combine them into monthly facts.

month_summary AS (
    SELECT df.project_id
        ,df.first_date_of_month
        ,df.last_date_of_month
        ,df.month_period AS period
        ,MIN(df.date) AS first_fact
        ,MAX(df.date) AS last_fact
        ,SUM(df.newly_worked_hours) AS newly_worked_hours
        ,SUM(df.eac_hours_change) AS eac_change_hours
    FROM fact_periods df WHERE df.last_date_of_month <= GETDATE() 
    
    GROUP BY df.project_id, df.month_period, df.first_date_of_month, df.last_date_of_month
), monthly_facts AS (
    SELECT fs.project_id
        ,fs.first_date_of_month AS fact_effective_start
        ,fs.last_date_of_month AS fact_effective_end
        ,'Monthly' AS period_type
        ,fs.period
        ,fs.first_fact
        ,fs.last_fact
        ,dp.derived_start_date
        ,dp.derived_end_date
        ,IFNULL(fp.etc_hours,0) AS starting_etc_hours
        ,IFNULL(fep.etc_hours,0) AS ending_etc_hours
        ,fs.newly_worked_hours
        ,fs.eac_change_hours        
        ,fp.project_stage AS starting_project_stage
        ,fep.project_stage AS ending_project_stage
        ,CASE WHEN dp.derived_start_date >= fs.first_date_of_month THEN TRUE
            ELSE FALSE END::BOOLEAN AS new_in_period
        ,CASE WHEN dp.derived_end_date <= fs.last_date_of_month THEN TRUE
            ELSE FALSE END::BOOLEAN AS ended_in_period
    FROM month_summary fs LEFT JOIN fact_periods fp ON fs.project_id = fp.project_id AND fs.first_date_of_month = fp.date  --join on daily facts only to find the facts on the start of the month
                        LEFT JOIN fact_periods fep ON fs.project_id = fep.project_id AND fs.last_date_of_month = fep.date  --join on daily facts only to find the facts on the end of the month
                        LEFT JOIN derived_project_dates dp ON fs.project_id = dp.id
),


--assemble facts from the beginning and end of the quarter, then combine them into quarterly facts.

quarter_summary AS (
    SELECT df.project_id
        ,df.first_date_of_quarter
        ,df.last_date_of_quarter
        ,df.quarter_period AS period
        ,MIN(df.date) AS first_fact
        ,MAX(df.date) AS last_fact
        ,SUM(df.newly_worked_hours) AS newly_worked_hours
        ,SUM(df.eac_hours_change) AS eac_change_hours
    FROM fact_periods df WHERE df.last_date_of_quarter <= GETDATE() 
    
    GROUP BY df.project_id, df.quarter_period, df.first_date_of_quarter, df.last_date_of_quarter
), quarterly_facts AS (
    SELECT fs.project_id
        ,fs.first_date_of_quarter AS fact_effective_start
        ,fs.last_date_of_quarter AS fact_effective_end
        ,'Quarterly' AS period_type
        ,fs.period
        ,fs.first_fact
        ,fs.last_fact
        ,dp.derived_start_date
        ,dp.derived_end_date
        ,IFNULL(fp.etc_hours,0) AS starting_etc_hours
        ,IFNULL(fep.etc_hours,0) AS ending_etc_hours
        ,fs.newly_worked_hours
        ,fs.eac_change_hours        
        ,fp.project_stage AS starting_project_stage
        ,fep.project_stage AS ending_project_stage
        ,CASE WHEN dp.derived_start_date >= fs.first_date_of_quarter THEN TRUE
            ELSE FALSE END::BOOLEAN AS new_in_period
        ,CASE WHEN dp.derived_end_date <= fs.last_date_of_quarter THEN TRUE
            ELSE FALSE END::BOOLEAN AS ended_in_period
    FROM quarter_summary fs LEFT JOIN fact_periods fp ON fs.project_id = fp.project_id AND fs.first_date_of_quarter = fp.date  --join on daily facts only to find the facts on the start of the month
                        LEFT JOIN fact_periods fep ON fs.project_id = fep.project_id AND fs.last_date_of_quarter = fep.date  --join on daily facts only to find the facts on the end of the month
                        LEFT JOIN derived_project_dates dp ON fs.project_id = dp.id
)

--assemble all three periods in one table.

SELECT 'Weekly' AS period_type
    ,pf.period
    ,pf.project_id
    ,pp.av_customer_id
    ,pf.fact_effective_start 
    ,pf.fact_effective_end
    ,IFNULL(pf.starting_etc_hours,0) AS starting_etc_hours
    ,CASE WHEN pf.new_in_period = TRUE THEN 
        CASE WHEN pf.ending_etc_hours <= 0 THEN pf.newly_worked_hours
            WHEN pf.ending_etc_hours IS NULL then pf.newly_worked_hours
            ELSE pf.ending_etc_hours END
        ELSE pf.ending_etc_hours END AS ending_etc_hours
    ,IFNULL(pf.newly_worked_hours,0) AS newly_worked_hours
    ,CASE WHEN pf.new_in_period = TRUE THEN 0
        ELSE IFNULL(pf.eac_change_hours,0) END AS eac_change_hours
    ,pf.new_in_period
    ,CASE WHEN pf.new_in_period = TRUE THEN 
        CASE WHEN pp.original_budget_hours = 0 THEN 
            CASE WHEN pp.original_eac_hours = 0 THEN pf.newly_worked_hours
                ELSE pp.original_eac_hours END
            ELSE pp.original_budget_hours END 
        ELSE 0 END AS new_project_hours
    ,dp.derived_start_date AS project_start_date
    ,dp.derived_end_date AS project_end_date
    ,pf.starting_project_stage
    ,pf.ending_project_stage
FROM weekly_facts pf LEFT JOIN derived_project_dates dp ON pf.project_id = dp.id
            LEFT JOIN ps_project pp ON pf.project_id = pp.id
            LEFT JOIN dim_date dd ON pf.fact_effective_start = dd.date


UNION 

SELECT 'Monthly' AS period_type
    ,pf.period
    ,pf.project_id
    ,pp.av_customer_id
    ,pf.fact_effective_start 
    ,pf.fact_effective_end
    ,IFNULL(pf.starting_etc_hours,0) AS starting_etc_hours
    ,CASE WHEN pf.new_in_period = TRUE THEN 
        CASE WHEN pf.ending_etc_hours <= 0 THEN pf.newly_worked_hours
            WHEN pf.ending_etc_hours IS NULL then pf.newly_worked_hours
            ELSE pf.ending_etc_hours END
        ELSE pf.ending_etc_hours END AS ending_etc_hours
    ,IFNULL(pf.newly_worked_hours,0) AS newly_worked_hours
    ,CASE WHEN pf.new_in_period = TRUE THEN 0
        ELSE IFNULL(pf.eac_change_hours,0) END AS eac_change_hours
    ,pf.new_in_period
    ,CASE WHEN pf.new_in_period = TRUE THEN 
        CASE WHEN pp.original_budget_hours = 0 THEN 
            CASE WHEN pp.original_eac_hours = 0 THEN pf.newly_worked_hours
                ELSE pp.original_eac_hours END
            ELSE pp.original_budget_hours END 
        ELSE 0 END AS new_project_hours
    ,dp.derived_start_date AS project_start_date
    ,dp.derived_end_date AS project_end_date
    ,pf.starting_project_stage
    ,pf.ending_project_stage

FROM monthly_facts pf LEFT JOIN derived_project_dates dp ON pf.project_id = dp.id
            LEFT JOIN dim_date dd ON pf.fact_effective_start = dd.date
            LEFT JOIN ps_project pp ON pf.project_id = pp.id


UNION 

SELECT 'Quarterly' AS period_type
    ,pf.period
    ,pf.project_id
    ,pp.av_customer_id
    ,pf.fact_effective_start 
    ,pf.fact_effective_end
    ,IFNULL(pf.starting_etc_hours,0) AS starting_etc_hours
    ,CASE WHEN pf.new_in_period = TRUE THEN 
        CASE WHEN pf.ending_etc_hours <= 0 THEN pf.newly_worked_hours
            WHEN pf.ending_etc_hours IS NULL then pf.newly_worked_hours
            ELSE pf.ending_etc_hours END
        ELSE pf.ending_etc_hours END AS ending_etc_hours
    ,IFNULL(pf.newly_worked_hours,0) AS newly_worked_hours
    ,CASE WHEN pf.new_in_period = TRUE THEN 0
        ELSE IFNULL(pf.eac_change_hours,0) END AS eac_change_hours
    ,pf.new_in_period
    ,CASE WHEN pf.new_in_period = TRUE THEN 
        CASE WHEN pp.original_budget_hours = 0 THEN 
            CASE WHEN pp.original_eac_hours = 0 THEN pf.newly_worked_hours
                ELSE pp.original_eac_hours END
            ELSE pp.original_budget_hours END 
        ELSE 0 END AS new_project_hours
    ,dp.derived_start_date AS project_start_date
    ,dp.derived_end_date AS project_end_date
    ,pf.starting_project_stage
    ,pf.ending_project_stage

FROM quarterly_facts pf LEFT JOIN derived_project_dates dp ON pf.project_id = dp.id
            LEFT JOIN dim_date dd ON pf.fact_effective_start = dd.date
            LEFT JOIN ps_project pp ON pf.project_id = pp.id