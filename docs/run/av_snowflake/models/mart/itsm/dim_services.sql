
  
    

create or replace transient table AV_EDM.AV_ITSM.dim_services
    
    
    
    as (WITH dim_assets_allvue_services AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_assets_allvue_services
), dim_assets_jsm_services AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_assets_services
)
select MD5(jsms.jira_service_id) as id
    ,jsms.jira_service_id as jsm_service_id
    ,COALESCE(jsms.service_name,avs.object_name) as name
    ,avs.object_id as av_service_asset_object_id
    ,avs.object_key as av_service_asset_object_key
    ,jsms.object_id as jsm_service_asset_object_id
    ,jsms.object_key as jsm_service_asset_object_key
    ,avs.internal_or_client as type
    ,avs.product_vertical as product_vertical
from dim_assets_allvue_services avs FULL OUTER JOIN dim_assets_jsm_services jsms ON avs.jsm_service_object_key = jsms.object_key
    )
;


  