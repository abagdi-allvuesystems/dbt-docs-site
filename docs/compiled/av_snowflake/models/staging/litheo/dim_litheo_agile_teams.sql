WITH agile_teams as (
    select * from AV_EDM.AV_SYSTEM.litheo_ea_agile_teams
)
select 
        id
        ,name
        ,adddate as sys_created
        ,updatedate as sys_updated
        ,raw_updated
from agile_teams