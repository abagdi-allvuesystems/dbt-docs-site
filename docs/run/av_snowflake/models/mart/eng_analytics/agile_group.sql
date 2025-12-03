
  
    

create or replace transient table AV_EDM.AV_ENG_ANALYTICS.agile_group
    
    
    
    as (WITH agile_group AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_litheo_agile_groups
)

SELECT
        ID
        ,NAME
        ,RAW_UPDATED

FROM 
        agile_group
    )
;


  