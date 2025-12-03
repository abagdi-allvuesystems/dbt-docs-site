WITH sf_cust AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_sf_contact
), dim_sf_cust AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_customers
), sf_acct AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_sf_account
)
SELECT sfc.id AS contact_id
    ,sfc.name AS name
    ,sfc.email AS email
    ,sfc.title AS title
    ,sfc.accountid AS account_id
    ,sfa.type AS account_type
    ,CASE WHEN dc.account_id IS NOT NULL THEN true ELSE false END::BOOLEAN AS is_customer_contact
    ,CASE WHEN dc.is_active = true AND sfc.active = true THEN true ELSE false END AS is_active_customer_contact
    ,sfc.active AS is_active_contact
    ,sfc.assets_id AS assets_id
    ,sfc.jsm_portal_user AS is_jsm_portal_user
    ,sfc.createddate AS sys_created
    ,sfc.systemmodstamp AS sys_updated
    ,sfc.raw_updated AS raw_updated
FROM sf_cust sfc LEFT JOIN dim_sf_cust dc ON sfc.accountid = dc.account_id
                 LEFT JOIN sf_acct sfa ON sfc.accountid = sfa.id