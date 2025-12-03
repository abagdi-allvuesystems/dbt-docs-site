
  create or replace   view AV_EDM.AV_STAGING.dim_sf_customer_account_team
  
  
  
  
  as (
    WITH sf_accountteammember AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_sf_accountteammember
), dim_cust AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_customers
), sf_users AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_sf_users
)
SELECT a.id as accountteammember_id
    ,a.accountid as account_id
    ,b.name as account_name
    ,a.userid as user_id
    ,u.name AS user_name
    ,a.teammemberrole AS team_member_role
from sf_accountteammember a JOIN dim_cust b on a.accountid = b.account_id
                            LEFT JOIN sf_users u on a.userid = u.id
where a.isdeleted = 'false'
  );

