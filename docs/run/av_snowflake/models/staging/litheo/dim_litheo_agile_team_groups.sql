
  create or replace   view AV_EDM.AV_STAGING.dim_litheo_agile_team_groups
  
  
  
  
  as (
    WITH agile_team_groups as (
    select * from AV_EDM.AV_SYSTEM.litheo_ea_agile_team_groups
)
select 
        id
        ,agilegroupid AS agile_group_id
        ,agileteamid AS agile_team_id
        ,adddate as sys_created
        ,updatedate as sys_updated
        ,raw_updated
from agile_team_groups
  );

