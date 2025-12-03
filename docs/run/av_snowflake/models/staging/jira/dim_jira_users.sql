
  create or replace   view AV_EDM.AV_STAGING.dim_jira_users
  
  
  
  
  as (
    WITH portal_users AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_portal_only_customers
), managed_users AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_managed_users
), users_all AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_users
)
SELECT ua.accountid AS account_id
    ,ua.active AS active
    ,COALESCE(pu.full_name,ua.displayname) AS displayname
    ,ua.accounttype AS accounttype
    ,COALESCE(ua.emailaddress,mu.email,pu.email) AS emailaddress
    ,CASE WHEN ua.accounttype = 'atlassian' THEN true ELSE false END::BOOLEAN as is_managed_user
    ,mu.last_active AS managed_user_last_activity_date
    ,mu.account_status AS managed_user_account_status
    ,CASE WHEN ua.accounttype = 'customer' THEN true ELSE false END::BOOLEAN AS is_portal_only_user
    ,pu.last_login AS portal_user_last_login
    ,pu.raw_updated AS portal_user_last_login_update
FROM users_all ua LEFT JOIN managed_users mu ON ua.accountid = mu.account_id
                  LEFT JOIN portal_users pu ON ua.accountid = pu.username
  );

