WITH jira_sprints AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_sprints
)
SELECT 
        id
        ,name
        ,state
        ,originboardid AS origin_board_id
        ,boardid AS board_id
        ,startdate AS start_date
        ,enddate AS end_date
        ,completedate AS complete_date
        ,sys_created
        ,raw_updated

FROM jira_sprints