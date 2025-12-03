
  
    

create or replace transient table AV_EDM.AV_CORE.dim_company
    
    
    
    as (WITH dim_sf_account AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_account
), dim_prospect AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_prospect
), dim_oa_client AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_customer
), dim_jira_org AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_organization_mapping
), dist_jira_org AS (
    SELECT distinct jsm_org_id, name FROM dim_jira_org GROUP BY jsm_org_id, name
), customer_mapping AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_av_customer_system_mapping
)

SELECT cm.av_customer_id AS av_company_id
        ,CASE WHEN oa.IS_INTERNAL = TRUE then 'Internal'
            ELSE sf.account_type END AS av_company_type
        ,sf.ACCOUNT_ID AS sf_account_id
        ,sf.NAME AS sf_name
        ,sf.IS_ACTIVE AS sf_is_active
        ,sf.ACCOUNT_TYPE AS sf_account_type
        ,sf.PRIMARY_INVESTOR_TYPE AS sf_primary_investor_type
        ,sf.CLIENT_VERTICAL AS sf_account_vertical
        ,sf.TAM AS sf_tam
        ,sf.SEGMENT AS sf_account_segment
        ,sf.SEGMENTATION AS sf_segmentation
        ,sf.DEPLOYMENT_TYPE AS sf_deployment_type
        ,sf.TIER AS sf_tier
        ,sf.CLIENT_PRIORTIZATION AS sf_client_prioritization
        ,sf.HEALTH_SCORE AS sf_health_score
        ,sf.NPS_SCORE AS sf_nps_score
        ,oa.ID AS oa_client_id
        ,oa.NAME AS oa_client_name
        ,oa.USER_NAME AS oa_client_owner
        ,oa.DELIVERY_MGR_USER_NAME AS oa_delivery_manager
        ,oa.SEGMENT AS oa_client_segment
        ,oa.IS_PRIORITY_CLIENT AS oa_priority_client
        ,oa.CLIENT_VERTICAL AS oa_client_vertical
        ,oa.IS_INTERNAL AS oa_is_internal
        ,jr.NAME AS jira_org_name
        ,jr.JSM_ORG_ID AS jira_org_id

FROM customer_mapping cm LEFT JOIN dim_sf_account sf ON cm.sf_account_id = sf.account_id
                        LEFT JOIN dim_oa_client oa ON cm.oa_customer_id = oa.id
                        LEFT JOIN dist_jira_org jr ON cm.jsm_org_id = jr.jsm_org_id
    )
;


  