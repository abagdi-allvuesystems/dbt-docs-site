WITH jira_users AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_users
), jira_user_domain AS (
    SELECT account_id AS account_id 
        ,SPLIT_PART(emailaddress, '@', 2) AS domain
        ,REVERSE(SPLIT_PART(REVERSE(SPLIT_PART(emailaddress, '@', 2)), '.', 2)) || '.' || 
            REVERSE(SPLIT_PART(REVERSE(SPLIT_PART(emailaddress, '@', 2)), '.', 1)) AS root_domain
    FROM jira_users
), sf_contacts AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_contacts_all
), sf_contacts_domain AS (
    SELECT contact_id AS contact_id 
        ,SPLIT_PART(email, '@', 2) AS domain
        ,REVERSE(SPLIT_PART(REVERSE(SPLIT_PART(email, '@', 2)), '.', 2)) || '.' || 
            REVERSE(SPLIT_PART(REVERSE(SPLIT_PART(email, '@', 2)), '.', 1)) AS root_domain
    FROM sf_contacts
), internal_domains AS (
    SELECT column1 AS domain 
    FROM VALUES 
        ('allvueservices.com'), 
        ('allvuesystems.com'), 
        ('allvueconsultant.com'),
        ('blkmtnhosting.com') AS t(column1)
), portal_users AS (
    SELECT COALESCE(sfc.name,ju.displayname) AS contact_name
            ,COALESCE(ju.emailaddress,sfc.email) AS contact_email
            ,COALESCE(jud.domain,sfcd.domain) AS contact_email_domain
            ,COALESCE(jud.root_domain,sfcd.root_domain) AS contact_root_domain
            ,CASE WHEN ju.account_id IS NOT NULL THEN true ELSE false END AS is_jira_user
            ,CASE WHEN ju.account_id IS NOT NULL AND ju.active = true THEN true ELSE false END AS is_active_jira_user
            ,CASE WHEN sfc.contact_id IS NOT NULL THEN true ELSE false END AS is_sf_contact
            ,sfc.is_jsm_portal_user AS sf_is_portal_user
            ,ju.is_portal_only_user AS jira_is_portal_only_user
            ,ju.account_id AS jira_account_id
            ,sfc.contact_id AS sf_contact_id
            ,sfc.account_id AS sf_account_id
            ,sfc.is_customer_contact AS sf_is_customer_contact
            ,sfc.is_active_customer_contact AS sf_is_active_customer_contact
            ,sfc.is_active_contact AS sf_is_active_contact
            ,sfc.assets_id AS sf_assets_id
            ,ju.portal_user_last_login AS jira_portal_user_last_login
            ,ju.portal_user_last_login_update AS jira_portal_user_last_login_update
    FROM jira_users ju LEFT JOIN jira_user_domain jud on ju.account_id = jud.account_id
                    FULL OUTER JOIN sf_contacts sfc on ju.emailaddress = sfc.email
                    LEFT JOIN sf_contacts_domain sfcd ON sfc.contact_id = sfcd.contact_id
    where ju.account_id IS NOT NULL OR sfc.is_jsm_portal_user = true
)
select pu.contact_name AS contact_name
    ,pu.contact_email AS contact_email
    ,pu.contact_email_domain AS contact_email_domain
    ,CASE WHEN id.domain IS NOT NULL THEN true ELSE false END::BOOLEAN AS is_internal_domain
    ,pu.is_jira_user AS is_jira_user
    ,pu.is_active_jira_user AS is_active_jira_user
    ,pu.is_sf_contact AS is_sf_contact
    ,pu.sf_is_portal_user AS sf_is_portal_user
    ,pu.jira_is_portal_only_user AS jira_is_portal_only_user
    ,pu.jira_account_id AS jira_account_id
    ,pu.sf_contact_id AS sf_contact_id
    ,pu.sf_account_id AS sf_account_id
    ,pu.sf_is_customer_contact AS is_sf_customer_contact
    ,pu.sf_is_active_customer_contact AS is_sf_active_customer_contact
    ,pu.sf_is_active_contact as is_sf_active_contact
    ,pu.sf_assets_id AS sf_assets_id
    ,pu.jira_portal_user_last_login AS jira_portal_user_last_login
    ,pu.jira_portal_user_last_login_update AS jira_portal_user_last_login_updatedate
from portal_users pu LEFT JOIN internal_domains id on pu.contact_root_domain = id.domain