
  
    

create or replace transient table AV_EDM.AV_ENG_ANALYTICS.agile_team
    
    
    
    as (WITH agile_team AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_litheo_agile_teams
)

SELECT
        id
        ,name
        ,raw_updated

FROM 
        agile_team
    )
;


  