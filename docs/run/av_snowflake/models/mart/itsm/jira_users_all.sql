
  
    

create or replace transient table AV_EDM.AV_ITSM.jira_users_all
    
    
    
    as (WITH dim_jira_users AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_users
), dim_assets_users_system AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_assets_users_system
)
SELECT dju.account_id as account_id
    ,dju.active as is_active
    ,dju.displayname as display_name
    ,dju.accounttype as account_type
    ,dju.emailaddress as email_address
    ,dju.is_managed_user as is_managed_user
    ,dju.managed_user_last_activity_date as managed_user_last_activity_date
    ,dju.managed_user_account_status as managed_user_account_status
    ,dju.is_portal_only_user as is_portal_only_user
    ,dju.portal_user_last_login as portal_user_last_login
    ,dju.portal_user_last_login_update as portal_user_last_login_last_refresh
    ,CASE WHEN us.email_address is not null THEN true ELSE false END as is_system_generated_user 
FROM dim_jira_users dju LEFT JOIN dim_assets_users_system us ON dju.emailaddress = us.email_address
    )
;


  