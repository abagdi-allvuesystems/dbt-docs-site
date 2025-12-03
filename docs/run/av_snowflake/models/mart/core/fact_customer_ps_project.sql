
  
    

create or replace transient table AV_EDM.AV_CORE.fact_customer_ps_project
    
    
    
    as (WITH ps_project AS (
    SELECT * FROM AV_EDM.AV_CX_PS.ps_project
), fact_ps_project AS (
    SELECT * FROM AV_EDM.AV_CX_PS.fact_ps_project_metrics_daily
), facts AS (
    select *
        ,row_number() over (partition by project_id order by date desc) as most_current_row
    from fact_ps_project
), latest_facts as (
    select *
    from facts
    where most_current_row = 1
), oa_customer AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_customer
)
select c.sf_account_id
    ,p.name
    ,p.project_stage_name
    ,p.project_type
    ,lf.derived_start_date
    ,lf.derived_end_date
    ,lf.worked_hours
    ,lf.approved_hours
    ,lf.current_budget_hours
    ,lf.current_eac_hours
    ,lf.etc_hours
from ps_project p LEFT JOIN latest_facts lf on p.id = lf.project_id
                  LEFT JOIN oa_customer c on p.oa_customer_id = c.id
    )
;


  