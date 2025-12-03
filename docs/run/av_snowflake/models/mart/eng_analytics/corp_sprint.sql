
  
    

create or replace transient table AV_EDM.AV_ENG_ANALYTICS.corp_sprint
    
    
    
    as (WITH corp_sprint AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_litheo_corp_sprints
)

SELECT
        id
        ,corp_pi_id
        ,name
        ,sprint_state AS status
        ,sprint_start_begin
        ,sprint_start_end
        ,pi_sprint_num AS pi_sprint_number
        ,raw_updated

FROM 
        corp_sprint pi
    )
;


  