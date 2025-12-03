
  
    

create or replace transient table AV_EDM.AV_ITSM.jira_services
    
    
    
    as (WITH jsm_services AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_assets_services
), avs_services AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_assets_allvue_services
)
SELECT jss.jira_service_id as jsm_service_id
    ,jss.object_id AS jsm_serv_asset_object_id
    ,jss.object_key as jsm_serv_asset_object_key
    ,jss.service_name AS name
    ,avs.internal_or_client AS service_type
    ,avs.object_id AS avs_serv_asset_object_id
    ,avs.object_key AS avs_serv_asset_object_key
    ,avs.affected_service_field_option_id AS avs_serv_aff_service_field_option_id
FROM jsm_services jss LEFT JOIN avs_services avs ON jss.object_id = avs.jsm_service_object_id
    )
;


  