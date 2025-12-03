WITH fo_serv AS (
    SELECT ID
            ,KEY
            ,'FRONT OFFICE' AS TYPE
            ,NAME
            ,CLIENT
    FROM AV_EDM.AV_STAGING.dim_assets_ism_clientserv_frontoffice
), dwh_serv AS (
    SELECT ID
            ,KEY
            ,'EQUITY DWH (Legacy)' AS TYPE
            ,NAME
            ,CLIENT 
    FROM AV_EDM.AV_STAGING.dim_assets_ism_clientserv_equitydwh_legacy
)
SELECT ID
    ,KEY
    ,TYPE
    ,CLIENT
    ,NAME
FROM fo_serv
UNION
SELECT ID
    ,KEY
    ,TYPE
    ,CLIENT
    ,NAME
FROM dwh_serv