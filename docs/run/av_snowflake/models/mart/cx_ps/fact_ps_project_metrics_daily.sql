
  
    

create or replace transient table AV_EDM.AV_CX_PS.fact_ps_project_metrics_daily
    
    
    
    as (--Project will exist on a day, if it's not closed on the day (open) or it was closed the previous day
-- Creation, Finance Review, 
-- Fact table will start showing values on the earlier event of
--   Start Date on Project
--   First Time Entry
--   First time we see the project on the rpt snapshot
--   First time we see the project move to creation the daily dbt snapshots (which hopefully is also the startdate)

-- Last Date
--   Closed Date
--   Date marked inactive
--   Completed Date
--   Last Time Entry

WITH dim_date AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_date
), dim_oa_project AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_project
), dimh_oa_project AS (
    SELECT * FROM AV_EDM.AV_STAGING.dimh_openair_project
), dim_oa_timeentry AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_time_entries where deleted = false
), dim_oa_project_dates AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_project_dates
), dim_oa_issues AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_issue
), dim_oa_proj AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_project
), dim_customer AS (
    SELECT * FROM AV_EDM.AV_SALES.dim_customer
), project_customer_mapping AS (  -- Join dim_oa_proj and dim_customer to extract av_customer_id
    SELECT 
        dp.id AS project_id,
        dc.customer_id AS av_customer_id
    FROM dim_oa_proj dp LEFT JOIN dim_customer dc ON dp.customer_id = dc.oa_customer_id
), derived_project_dates AS (
    select id
        ,LEAST_IGNORE_NULLS(start_date,first_time_entry,first_creation_snapshot_date)::DATE as derived_start_date
        ,GREATEST_IGNORE_NULLS(GREATEST(close_completed_date,last_time_entry,last_snapshot_date))::DATE as derived_end_date
    from dim_oa_project_dates
    where LEAST_IGNORE_NULLS(start_date,first_time_entry,first_creation_snapshot_date)::DATE > '1/1/2023' 
                OR first_creation_snapshot_date is not null
), fact_ids as (
    select dd.date as date
        ,dfd.id as project_id
        ,dfd.derived_start_date
        ,dfd.derived_end_date
    from dim_date dd LEFT JOIN derived_project_dates dfd on dd.date >= dfd.derived_start_date
                                                        AND (dfd.derived_end_date is null or dd.date <= dateadd(day,8,dfd.derived_end_date))
    where (dfd.derived_start_date is not null or dfd.derived_end_date is not null) and dd.date >= '1/1/2023' and dd.date <= GETDATE()
    

), worked_hours AS (
    select fi.date
            ,fi.project_id
            ,sum(te.decimal_hour) as worked_hours
    from fact_ids fi LEFT JOIN dim_oa_timeentry te on fi.project_id = te.project_id AND te.time_entry_date <= fi.date
    group by fi.date,fi.project_id
), approved_hours AS (
        select fi.date
            ,fi.project_id
            ,sum(tea.decimal_hour) as approved_hours
    from fact_ids fi LEFT JOIN dim_oa_timeentry tea on fi.project_id = tea.project_id and tea.date_approved <= fi.date
    group by fi.date,fi.project_id
), newly_worked_hours AS (
    select fi.date
            ,fi.project_id
            ,sum(te.decimal_hour) as worked_hours
    from fact_ids fi LEFT JOIN dim_oa_timeentry te on fi.project_id = te.project_id AND te.time_entry_date = fi.date
    group by fi.date,fi.project_id
),issue_metrics AS (
    SELECT  project_id AS id
            ,COUNT(id) AS count_of_issues
            ,AVG(days_to_resolution) AS avg_issue_resolution_days
    FROM dim_oa_issues GROUP BY project_id
), daily_facts AS (
    select fi.date
        ,fi.project_id
        ,fi.derived_start_date
        ,fi.derived_end_date
        ,eps.project_stage AS project_stage
        ,IFNULL(wh.worked_hours,0)::DECIMAL(10,2) as worked_hours
        ,IFNULL(ah.approved_hours,0)::DECIMAL(10,2) as approved_hours
        ,IFNULL(nwh.worked_hours,0)::DECIMAL(10,2) as newly_worked_hours
        ,eps.rag_overall AS current_rag_status
        ,eps.budget_hours as current_budget_hours
        ,eps.eac_hours as current_eac_hours
        ,eps.budget AS current_budget_dollars
        ,(IFNULL(eps.eac_hours,0) - IFNULL(wh.worked_hours,0))::DECIMAL(10,2) as etc_hours
        ,eps.revised_go_live AS revised_go_live
        ,im.count_of_issues
        ,im.avg_issue_resolution_days
    from fact_ids fi LEFT JOIN worked_hours wh on fi.date = wh.date and fi.project_id = wh.project_id
                    LEFT JOIN approved_hours ah on fi.date = ah.date and fi.project_id = ah.project_id
                    LEFT JOIN newly_worked_hours nwh on fi.date = nwh.date and fi.project_id = nwh.project_id
                    LEFT JOIN dimh_oa_project eps on fi.project_id = eps.id AND fi.date >= DATE_TRUNC('DAY', eps.effective_date_start) AND (fi.date < DATE_TRUNC('DAY', eps.effective_date_end) OR eps.effective_date_end IS NULL)
                    LEFT JOIN dim_oa_project dop on fi.project_id = dop.id
                    LEFT JOIN issue_metrics im ON fi.project_id = im.id


), eac_changes AS (
    SELECT date
        ,project_id
        ,current_eac_hours
        ,LAG(current_eac_hours) OVER (PARTITION BY project_id ORDER BY date) AS prev_eac_hours
        ,CASE WHEN current_eac_hours <> (LAG(current_eac_hours) OVER (PARTITION BY project_id ORDER BY date)) 
            AND (LAG(current_eac_hours) OVER (PARTITION BY project_id ORDER BY date)) <> 0 
            AND (LAG(current_eac_hours) OVER (PARTITION BY project_id ORDER BY date)) IS NOT NULL
            THEN 1 
            ELSE 0 END AS is_eac_change
    FROM daily_facts
)

SELECT df.date
    ,df.project_id
    ,df.derived_start_date
    ,df.derived_end_date
    ,df.project_stage
    ,df.worked_hours
    ,df.approved_hours
    ,df.newly_worked_hours
    ,df.current_budget_hours
    ,df.current_eac_hours
    ,df.current_budget_dollars
    ,df.current_rag_status
    ,df.count_of_issues
    ,df.avg_issue_resolution_days
    ,df.revised_go_live
    ,ecc.prev_eac_hours
    ,ecc.is_eac_change
    ,CASE WHEN ecc.is_eac_change = 1 THEN ecc.current_eac_hours - ecc.prev_eac_hours ELSE 0 END AS eac_hours_change
    ,df.etc_hours
    ,pcm.av_customer_id -- The added column for AV Customer ID
FROM daily_facts df LEFT JOIN eac_changes ecc ON df.project_id = ecc.project_id AND df.date = ecc.date
                    LEFT JOIN project_customer_mapping pcm ON df.project_id = pcm.project_id
    )
;


  