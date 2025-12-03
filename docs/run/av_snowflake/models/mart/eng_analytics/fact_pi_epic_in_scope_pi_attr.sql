
  
    

create or replace transient table AV_EDM.AV_ENG_ANALYTICS.fact_pi_epic_in_scope_pi_attr
    
    
    
    as (

WITH dim_date AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_date
), pis AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_litheo_corp_pis where id = 7
), epic_pi_attr as (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_pi_epic
)
SELECT distinct d.date
        ,p.id as pi_id
        ,pa.issue_id as epic_id
FROM dim_date d JOIN pis p on d.date >= p.start_date AND d.date <= p.end_date
                LEFT JOIN epic_pi_attr pa ON p.jira_pi_name = pa.pi_name
                                            AND d.last_datetime_of_day >= pa.effective_date_start
                                            AND d.first_datetime_of_day <= pa.effective_date_end
    )
;


  