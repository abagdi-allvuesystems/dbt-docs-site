WITH sf_cust AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_customers
), asset_orgs AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_assets_organizations
), jsm_orgs AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_organizations
), sf_accts AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_sf_account
), mapped_orgs AS (
SELECT COALESCE(sfa.name,ao.organization_name,jo.name) AS org_name
        ,sfa.id AS sf_account_id
        ,sfa.name AS sf_org_name
        ,sfa.type AS sf_account_type
        ,CASE WHEN sfc.account_id IS NOT NULL THEN true ELSE false END::BOOLEAN AS sf_is_customer
        ,sfc.is_active AS sf_is_active_customer
        ,sfc.date_inactive AS sf_cust_date_inactive
        ,ao.object_key AS assets_object_key
        ,ao.organization_name AS assets_organization_name
        ,ao.salesforce_account_id AS assets_salesforce_account_id
        ,ao.jsm_id AS assets_jsm_id
        ,jo.id AS jsm_id
        ,jo.name AS jsm_name
FROM sf_cust sfc FULL OUTER JOIN asset_orgs ao ON sfc.account_id = ao.salesforce_account_id
                 FULL OUTER JOIN jsm_orgs jo ON ao.jsm_id = jo.id
                 LEFT JOIN sf_accts sfa on sfa.id = ao.salesforce_account_id
)

--asset orgs not matched to sf_customer
SELECT org_name AS orgname
        ,sf_account_id AS sf_account_id
        ,sf_org_name AS sf_org_name
        ,sf_account_type AS sf_account_type
        ,sf_is_customer AS sf_is_customer
        ,sf_is_active_customer AS sf_is_active_customer
        ,sf_cust_date_inactive AS sf_cust_date_inactive
        ,assets_object_key AS assets_object_key
        ,assets_organization_name AS assets_organization_name
        ,assets_salesforce_account_id AS assets_salesforce_account_id
        ,assets_jsm_id AS assets_jsm_id
        ,jsm_id AS jsm_id
        ,jsm_name AS jsm_name
FROM mapped_orgs
ORDER BY org_name


--Future conditions to check
-- Asset Orgs not associated to JSM Org
-- Active Salesforce Accounts without Assets