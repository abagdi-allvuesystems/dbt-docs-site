WITH corp_pi AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_litheo_corp_pis
)

SELECT
        id
        ,name
        ,pi_state AS status
        ,start_date
        ,end_date
        ,pi_readiness_date
        ,epic_readiness_date
        ,raw_updated

FROM 
        corp_pi pi