WITH agile_team_board AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_scrum_boards
)
 
SELECT
        id
        ,name
        ,raw_updated
        
FROM 
        agile_team_board