
  
    

create or replace transient table AV_EDM.AV_ENG_ANALYTICS.pi_workitem
    
    
    
    as (WITH pi_sprint_workitem AS (
    SELECT * FROM AV_EDM.AV_ENG_ANALYTICS.pi_sprint_workitem
)

SELECT corp_pi_id
       ,workitem_id
       ,MAX(existed_at_corp_pi_start) AS existed_at_corp_pi_start
       ,MAX(existed_at_pi_team_sprint_start) AS existed_at_team_pi_start
       ,MAX(accepted_into_sprint) AS accepted_sprint_in_pi
       ,MAX(existed_in_pi_window_pi_start) AS planned_onto_sprint_in_corp_pi_start
       ,MAX(existed_in_pi_window_team_sprint_start) AS planned_onto_sprint_in_team_pi_start

FROM 
        pi_sprint_workitem
GROUP BY 
        corp_pi_id,workitem_id
    )
;


  