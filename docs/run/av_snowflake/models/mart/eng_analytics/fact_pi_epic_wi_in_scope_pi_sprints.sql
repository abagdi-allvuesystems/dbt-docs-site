
  
    

create or replace transient table AV_EDM.AV_ENG_ANALYTICS.fact_pi_epic_wi_in_scope_pi_sprints
    
    
    
    as (

WITH dim_date AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_date
), pis AS (
    SELECT * FROM AV_EDM.AV_ENG_ANALYTICS.corp_pi where id = 7
), sprint_workitems as (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_sprint_workitems
), corp_sprints AS (
    SELECT * FROM AV_EDM.AV_ENG_ANALYTICS.corp_sprint
), team_sprints AS (
    SELECT * FROM AV_EDM.AV_ENG_ANALYTICS.team_sprint
), team_sprint_by_pi AS (
    SELECT pis.id as pi_id
            ,pis.name as pi_name
            ,pis.start_date as pi_start_date
            ,pis.end_date as pi_end_date
            ,cs.id as cs_id
            ,cs.name as cs_name
            ,ts.id as ts_id
            ,ts.name as ts_name
    FROM pis JOIN corp_sprints cs on pis.id = cs.corp_pi_id
            JOIN team_sprints ts on ts.corp_sprint_id = cs.id
)
SELECT d.date
    ,p.*
    ,tsp.*
FROM dim_date d JOIN pis p on d.date >= p.start_date AND d.date <= p.end_date
                JOIN team_sprint_by_pi tsp on p.id = tsp.pi_id


/*
SELECT tsp.*
    ,sw.*
FROM team_sprint_by_pi tsp JOIN sprint_workitems sw on tsp.ts_id = sw.sprint_id





                JOIN team_sprint_by_pi tsp on p.id = tsp.pi_id
                
                
                 sw ON d.last_datetime_of_day >= pa.effective_date_start
                                                AND d.first_datetime_of_day <= pa.effective_date_end
*/
    )
;


  