WITH agile_group AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_litheo_agile_groups
)

SELECT
        ID
        ,NAME
        ,RAW_UPDATED

FROM 
        agile_group