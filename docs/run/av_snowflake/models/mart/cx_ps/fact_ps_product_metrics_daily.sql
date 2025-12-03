
  
    

create or replace transient table AV_EDM.AV_CX_PS.fact_ps_product_metrics_daily
    
    
    
    as (WITH daily_facts AS (
    SELECT * FROM AV_EDM.AV_CX_PS.fact_ps_project_task_metrics_daily
), task_eac_changes AS (
    SELECT date
        ,project_task_id
        ,eac_hours - LAG(eac_hours) OVER (PARTITION BY project_task_id ORDER BY date) AS eac_change_hours
    FROM daily_facts
), proj_prod AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_project_product
), proj_prod_totals AS (
    SELECT df.date
        ,df.proj_prod_key  
        ,df.project_id 
        ,df.project_stage   
        ,sum(df.worked_hours) AS worked_hours  
        ,sum(df.newly_worked_hours) AS newly_worked_hours
        ,sum(df.eac_hours) AS eac_hours
        ,sum(te.eac_change_hours) AS eac_change_hours
        ,sum(df.task_etc_hours) AS etc_hours
    FROM daily_facts df
        LEFT JOIN proj_prod pp ON df.proj_prod_key = pp.proj_prod_key
        LEFT JOIN task_eac_changes te ON df.project_task_id = te.project_task_id AND df.date = te.date
    GROUP BY df.date, df.proj_prod_key, df.project_id, df.project_stage
)

SELECT pt.date
    ,pt.project_id
    ,pt.proj_prod_key
    ,pp.product
    ,pp.product_family
    ,pt.project_stage
    ,pt.worked_hours
    ,pt.newly_worked_hours
    ,pt.eac_hours
    ,pt.eac_change_hours
    ,pt.etc_hours 
FROM proj_prod_totals pt LEFT JOIN proj_prod pp ON pt.proj_prod_key = pp.proj_prod_key
    )
;


  