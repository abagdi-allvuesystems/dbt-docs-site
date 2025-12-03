
  
    

create or replace transient table AV_EDM.AV_ENG_ANALYTICS.agile_team_group
    
    
    
    as (WITH agile_team_group AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_litheo_agile_team_groups
)

SELECT
        ID
        ,AGILE_GROUP_ID
        ,AGILE_TEAM_ID
        ,RAW_UPDATED

FROM 
        agile_team_group
    )
;


  