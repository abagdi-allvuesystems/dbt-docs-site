WITH lit_agile_team_boards as (
    select * from AV_EDM.AV_SYSTEM.litheo_ea_agile_team_boards
)
select agileteamid as agile_team_id
        ,jiraboardid as jira_board_id
        ,isactive as is_active
        ,adddate as sys_created
        ,updatedate as sys_updated
        ,raw_updated
from lit_agile_team_boards