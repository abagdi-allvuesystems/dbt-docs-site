
  
    

create or replace transient table AV_EDM.AV_ENG_ANALYTICS.team_sprint
    
    
    
    as (WITH jira_sprint AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_sprints --6311
), agile_team_board AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_litheo_agile_team_boards --28
), corp_sprint AS (
    SELECT * FROM AV_EDM.AV_ENG_ANALYTICS.corp_sprint --104
)


SELECT
        js.id AS id
        ,atb.agile_team_id
        ,js.board_id AS scrum_board_id
        ,cs.id AS corp_sprint_id
        ,js.name AS name
        ,js.state AS status
        ,js.start_date
        ,js.end_date
        ,js.complete_date AS completed_date
        ,js.sys_created
        ,js.raw_updated


FROM 
        jira_sprint js
FULL OUTER JOIN 
        agile_team_board atb ON js.board_id = atb.jira_board_id
LEFT JOIN 
        corp_sprint cs ON js.start_date BETWEEN cs.sprint_start_begin AND cs.sprint_start_end
WHERE 
        js.board_id = js.origin_board_id
    )
;


  