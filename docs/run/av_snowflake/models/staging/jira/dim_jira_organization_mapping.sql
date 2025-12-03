
  create or replace   view AV_EDM.AV_STAGING.dim_jira_organization_mapping
  
  
  
  
  as (
    WITH asset_orgs AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_assets_organizations
), jsm_orgs AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_organizations
), jira_cust_field AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_field_customer
)
SELECT COALESCE(ao.organization_name,jsm_orgs.name,jcf.name) as name
    ,ao.object_id as assets_object_id
    ,ao.object_key as assets_object_key
    ,jsm_orgs.id as jsm_org_id
    ,ao.salesforce_account_id as assets_salesforce_account_id
    ,jcf.id as jira_customer_field_id
    ,jcf.disabled as jira_customer_field_disabled
    ,CASE WHEN ao.object_id is null OR jsm_orgs.id is null OR jcf.id is null THEN true else false END as has_discrepency
FROM asset_orgs ao FULL OUTER JOIN jsm_orgs ON ao.jsm_id = jsm_orgs.id
                   FULL OUTER JOIN jira_cust_field jcf ON ao.customer_list_item_id = jcf.id
  );

