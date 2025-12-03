
  
    

create or replace transient table AV_EDM.AV_CORE.fact_customer_cx_trends
    
    
    
    as (WITH fact_status AS (
    SELECT * FROM AV_EDM.AV_CORE.fact_customer_status
), fact_nps_trend AS (
    SELECT * FROM AV_EDM.AV_CORE.fact_customer_nps_trend
), fact_risk_proj AS (
    SELECT * FROM AV_EDM.AV_CORE.fact_customer_risk_projection
), fact_support_metrics AS (
    SELECT * FROM AV_EDM.AV_ITSM.fact_customer_support_metrics_monthly
), totaled_support_metrics AS (
    select date
            ,sf_account_id
            ,SUM(count_backlog_issues) as count_total_begin_backlog
            ,SUM(count_opened_issues) as count_total_opened_tickets
            ,SUM(count_closed_issues) as count_total_closed_tickets
            ,ROUND(SUM(mttr*count_closed_issues) / NULLIF(SUM(count_closed_issues),0),2) AS total_mttr_hours
            ,ROUND(SUM(mttc*count_closed_issues) / NULLIF(SUM(count_closed_issues),0),2) AS total_mttc_hours
            ,SUM(count_critical_issues) as count_critical_issues
    from fact_support_metrics sm
    group by date,sf_account_id
), fact_cust_data_rights AS (
    SELECT * FROM AV_EDM.AV_DATA_RIGHTS.fact_customer_data_rights_trend
), fact_csat AS (
    SELECT * FROM AV_EDM.AV_ITSM.fact_customer_ticket_survey_monthly
), fact_customer_ps_project_monthly AS (
    SELECT * FROM AV_EDM.AV_CORE.fact_customer_ps_project_monthly
), totaled_ps_metrics AS (
    SELECT first_date_of_month
        ,sf_account_id
        ,SUM(count_projects) as count_total_ps_projects
        ,SUM(monthly_worked_hours) as sum_total_ps_proj_monthly_worked_hours
        ,SUM(month_end_total_worked_active_project_hours) as month_end_total_worked_active_project_hours
        ,SUM(month_end_eac_hours) as sum_total_month_end_eac_hours
        ,SUM(month_end_etc_hours) as sum_total_month_end_etc_hours
    from fact_customer_ps_project_monthly
    GROUP By first_date_of_month,sf_account_id
)
select s.date as date
    ,s.sf_account_id as sf_account_id
    ,s.status as status
    ,s.is_active as is_active
    ,s.count_active as count_active
    ,s.is_new_customer as is_new_customer
    ,s.count_new_customer as count_new_customer
    ,s.is_leaving_customer as is_leaving_customer
    ,s.count_leaving_customer as count_leaving_customer
    ,smt.count_total_begin_backlog as sup_count_total_begin_backlog
    ,smt.count_total_opened_tickets as sup_count_total_opened_tickets
    ,smt.count_total_closed_tickets as sup_count_total_closed_tickets
    ,smt.total_mttr_hours as sup_total_mttr_hours
    ,smt.total_mttc_hours as sup_total_mttc_hours
    ,sm_inc.count_backlog_issues as sup_count_incident_begin_backlog
    ,sm_inc.count_opened_issues as sup_count_incident_opened_tickets
    ,sm_inc.count_closed_issues as sup_count_incident_closed_tickets
    ,sm_inc.mttr as sup_incident_mttr_hours
    ,sm_inc.mttc as sup_incident_mttc_hours
    ,sm_sr.count_backlog_issues as sup_count_service_request_begin_backlog
    ,sm_sr.count_opened_issues as sup_count_service_request_opened_tickets
    ,sm_sr.count_closed_issues as sup_count_service_request_closed_tickets
    ,sm_sr.mttr as sup_service_request_mttr_hours
    ,sm_sr.mttc as sup_service_request_mttc_hours
    ,nps.count_total_surveys as nps_count_total_surveys
    ,nps.average_recommendation_score as nps_average_recommendation_score
    ,nps.count_promotor as nps_count_promotor
    ,nps.count_passive as nps_count_passive
    ,nps.count_detractor as nps_count_detractor
    ,ROUND(risk.risk_forecast_pct_current_year/100.0,2) as risk_forecast_pct_current_year
    ,ROUND(risk.risk_forecast_pct_next_year/100.0,2) as risk_forecast_pct_next_year
    ,dr.has_data_rights as has_data_rights
    ,dr.has_data_rights_count as has_data_rights_count
    ,dr.data_rights_clause as data_rights_clause
    ,IFNULL(csat.count_surveys_all,0) AS csat_count_surveys_sent
    ,IFNULL(csat.count_surveys_completed,0) AS csat_count_surveys_completed
    ,csat.csat_rating_average AS csat_rating_average
    ,psm_i.count_projects as ps_count_active_projects
    ,psm_i.monthly_worked_hours as ps_monthly_worked_hours
    ,psm_i.month_end_total_worked_active_project_hours as ps_month_end_total_project_worked_hours
    ,psm_i.month_end_eac_hours as ps_month_end_eac_hours
    ,psm_i.month_end_etc_hours as ps_month_end_etc_hours
    ,psmt.count_total_ps_projects as ps_tot_count_active_projects
    ,psmt.sum_total_ps_proj_monthly_worked_hours as ps_tot_monthly_worked_hours
    ,psmt.month_end_total_worked_active_project_hours as ps_tot_month_end_total_project_worked_hours
    ,psmt.sum_total_month_end_eac_hours as ps_tot_month_end_eac_hours
    ,psmt.sum_total_month_end_etc_hours as ps_tot_month_end_etc_hours
from fact_status s left join totaled_support_metrics smt on s.date = smt.date and s.sf_account_id = smt.sf_account_id
                   left join fact_support_metrics sm_inc on s.date = sm_inc.date and s.sf_account_id = sm_inc.sf_account_id and sm_inc.derived_ticket_type = 'Incident'
                   left join fact_support_metrics sm_sr on s.date = sm_sr.date and s.sf_account_id = sm_sr.sf_account_id and sm_sr.derived_ticket_type = 'Service Request'
                   left join fact_nps_trend nps on s.date = nps.first_date_of_month and s.sf_account_id = nps.sf_account_id
                   left join fact_risk_proj risk on s.date = risk.first_date_of_month and s.sf_account_id = risk.sf_account_id
                   LEFT JOIN fact_cust_data_rights dr on s.date= dr.date and s.sf_account_id = dr.sf_account_id
                   LEFT JOIN fact_csat csat ON s.date = csat.date_id AND s.sf_account_id = csat.sf_account_id
                   left join fact_customer_ps_project_monthly psm_i on s.date = psm_i.first_date_of_month and s.sf_account_id = psm_i.sf_account_id 
                   left join totaled_ps_metrics psmt on s.date = psmt.first_date_of_month and s.sf_account_id = psmt.sf_account_id
    )
;


  