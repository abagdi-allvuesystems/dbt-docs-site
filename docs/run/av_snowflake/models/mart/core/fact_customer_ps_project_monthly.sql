
  
    

create or replace transient table AV_EDM.AV_CORE.fact_customer_ps_project_monthly
    
    
    
    as (WITH dim_oa_cust AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_customer
), fact_ps_project AS (
    SELECT * FROM AV_EDM.AV_CX_PS.fact_ps_project_metrics_daily
), dim_ps_project AS (
    SELECT * FROM AV_EDM.AV_CX_PS.ps_project
)
, date_dim AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_date where date >= '1/1/2023' and date <= CURRENT_TIMESTAMP()
), raw_data AS (
    select sf_account_id
        ,p.id
        ,fp.newly_worked_hours
        ,fp.worked_hours
        ,fp.current_eac_hours
        ,fp.etc_hours
        ,d.date
        ,d.first_date_of_month
        ,d.last_date_of_month
    from dim_oa_cust c JOIN dim_ps_project p on c.id = p.oa_customer_id
                    JOIN fact_ps_project fp on p.id = fp.project_id
                    JOIN date_dim d on d.date = fp.date
), monthly_agg AS (
    select sf_account_id
        ,first_date_of_month
        ,last_date_of_month
        ,count(distinct id) as count_projects
        ,SUM(newly_worked_hours) as newly_worked_hours
    from raw_data
    GROUP BY sf_account_id
        ,first_date_of_month
        ,last_date_of_month
), end_of_month AS (
    select sf_account_id
        ,first_date_of_month
        ,last_date_of_month
        ,SUM(worked_hours) as total_worked_project_hours
        ,SUM(current_eac_hours) as current_eac_hours
        ,SUM(ETC_hours) as etc_hours
    from raw_data
    group by sf_account_id
        ,first_date_of_month
        ,last_date_of_month
)
select a.sf_account_id
    ,a.first_date_of_month
    ,a.last_date_of_month
    ,a.count_projects
    ,a.newly_worked_hours as monthly_worked_hours
    ,e.total_worked_project_hours as month_end_total_worked_active_project_hours
    ,e.current_eac_hours as month_end_eac_hours
    ,e.etc_hours as month_end_etc_hours
from monthly_agg a JOIN end_of_month e on a.sf_account_id = e.sf_account_id 
                                        AND a.first_date_of_month = e.first_date_of_month
                                        AND a.last_date_of_month = e.last_date_of_month
where a.sf_account_id is not null AND e.sf_account_id is not null
    )
;


  