WITH sf_accounts AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_account
), dim_jira_organization_mapping AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_organization_mapping
), oa_customer AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_customer
)
select MD5(CONCAT(IFNULL(sfc.account_id::VARCHAR,'')
                 ,IFNULL(jom.assets_object_id::VARCHAR,'')
                 ,IFNULL(jom.jsm_org_id::VARCHAR,'')
                 ,IFNULL(jom.jira_customer_field_id::VARCHAR,'')
                 ,IFNULL(oac.id::VARCHAR,'')
                 )) as av_customer_id
        ,sfc.account_id as sf_account_id
        ,sfc.name as sf_name
        ,jom.name as jom_name
        ,jom.assets_object_id as assets_object_id
        ,jom.assets_object_key as assets_object_key
        ,jom.jsm_org_id as jsm_org_id
        ,jom.jira_customer_field_id as jira_customer_field_id
        ,oac.id AS oa_customer_id
from sf_accounts sfc FULL OUTER JOIN dim_jira_organization_mapping jom ON sfc.account_id = jom.assets_salesforce_account_id
                      FULL OUTER JOIN oa_customer oac ON sfc.account_id = oac.sf_account_id