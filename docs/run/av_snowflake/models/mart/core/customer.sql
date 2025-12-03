
  
    

create or replace transient table AV_EDM.AV_CORE.customer
    
    
    
    as (WITH sf_cust AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_customers
), sf_accts AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_sf_account
), assets_orgs AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_assets_organizations
), distinct_client_services AS (
    SELECT DISTINCT CLIENT FROM AV_EDM.AV_STAGING.dim_assets_ism_client_services WHERE CLIENT IS NOT NULL
), orgs_with_services AS (
    SELECT ao.object_key
        ,ao.organization_name
        ,ao.salesforce_account_id
        ,ao.salesforce_customer_inactive_override
        ,ao.customer_inactive_date
        ,ao.production_services_inactive
        ,ao.production_services_inactive_date
        ,ao.test_demo_system_account
    FROM distinct_client_services dcs LEFT JOIN assets_orgs ao ON dcs.client = ao.object_key
), accts_with_active_msa AS (
    SELECT account_id AS sf_account_id
           ,COUNT(contract_number) as count_active_msa 
    FROM AV_EDM.AV_STAGING.dim_sf_contract_msa 
    WHERE STATUS = 'Activated'
    GROUP BY account_id
), accts_with_active_pr AS (
    SELECT account_id AS sf_account_id
           ,COUNT(contract_number) as count_active_product_riders 
    FROM AV_EDM.AV_STAGING.dim_sf_contract_product_rider 
    WHERE STATUS = 'Activated'
    GROUP BY account_id
), accts_with_conditions AS (
    SELECT sfa.id AS sf_account_id
        ,sfa.name AS sf_account_name
        ,sfa.type AS sf_type
        ,sfa.segment AS sf_segment
        ,sfa.client_vertical AS sf_client_vertical
        ,sfa.deployment_type AS sf_deployment_type
        ,sfa.finance_arr AS sf_finance_arr
        ,sfa.health_score AS sf_health_score
        ,sfa.primary_investor_type AS sf_primary_investor_type
        ,CASE WHEN ows.object_key IS NOT NULL THEN true ELSE false END AS has_cmdb_service
        ,CASE WHEN sfc.is_active = true AND ows.salesforce_customer_inactive_override IS NULL THEN true ELSE false END AS is_active_customer
        ,COALESCE(sfc.date_inactive,ows.customer_inactive_date) AS date_inactive
        ,CASE WHEN msa.sf_account_id IS NOT NULL THEN true ELSE false END AS has_active_msa
        ,CASE WHEN pr.sf_account_id IS NOT NULL THEN true ELSE false END AS has_active_pr
        ,CASE WHEN msa.sf_account_id IS NOT NULL OR pr.sf_account_id IS NOT NULL THEN true else false END as has_active_contract
        --,CASE WHEN ows.production_services_inactive = true OR ows.test_demo_system_account = true OR salesforce_customer_inactive_override = true THEN FALSE ELSE TRUE END AS has_active_service
        ,CASE WHEN sfa.finance_arr > 0 AND sfa.finance_arr IS NOT NULL AND pr.sf_account_id IS NOT NULL THEN true ELSE false END AS has_active_service_per_sf
    FROM sf_accts sfa LEFT JOIN orgs_with_services ows ON sfa.id = ows.salesforce_account_id
                    LEFT JOIN sf_cust sfc ON sfa.id = sfc.account_id
                    LEFT JOIN accts_with_active_msa msa ON msa.sf_account_id = sfa.id
                    LEFT JOIN accts_with_active_pr pr ON pr.sf_account_id = sfa.id
)
SELECT sf_account_id AS sf_account_id
    ,sf_account_name AS sf_account_name
    ,sf_type AS sf_type
    ,sf_segment AS sf_segment
    ,sf_client_vertical AS sf_client_vertical
    ,sf_deployment_type AS sf_deployment_type
    ,sf_finance_arr AS sf_finance_arr
    ,sf_health_score AS sf_health_score
    ,sf_primary_investor_type as sf_primary_investor_type
    ,has_cmdb_service AS has_cmdb_service
    ,has_active_msa AS has_active_msa
    ,has_active_pr AS has_active_pr
    ,has_active_contract AS has_active_contract
FROM accts_with_conditions
WHERE SF_TYPE in ('Customer','Former Customer') OR SF_FINANCE_ARR > 0 OR has_active_contract = true
    )
;


  