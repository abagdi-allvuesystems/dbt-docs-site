
  create or replace   view AV_EDM.AV_STAGING.dim_sf_account_team
  
  
  
  
  as (
    WITH sf_account_team AS (
    SELECT
        id AS account_team_id,
        accountid,
        userid,
        teammemberrole,
        createddate,
        lastmodifieddate,
        isdeleted
    FROM AV_EDM.AV_SYSTEM.sys_sf_accountteammember
),

sf_account AS (
    SELECT
        id AS account_id,
        name AS account_name,
        industry,
        type AS account_type,
        ownerid AS account_owner_id
    FROM AV_EDM.AV_SYSTEM.sys_sf_account
),

sf_user AS (
    SELECT
        id AS user_id,
        name AS user_name,
        email,
        department,
        title,
        isactive
    FROM AV_EDM.AV_SYSTEM.sys_sf_users
)

SELECT
    t.account_team_id,

    -- account info
    t.accountid AS account_id,
    a.account_name,
    a.industry,
    a.account_type,
    a.account_owner_id,

    -- team member info
    t.userid AS team_member_id,
    u.user_name AS team_member_name,
    u.email AS team_member_email,
    u.department AS team_member_department,
    u.title AS team_member_title,
    u.isactive AS team_member_is_active,

    -- role ON account team
    t.teammemberrole AS team_role,

    t.createddate,
    t.lAStmodifieddate,

    -- derived
    CASE WHEN t.userid = a.account_owner_id then 1 else 0 end AS is_account_owner

FROM sf_account_team t
left join sf_account a
    ON t.accountid = a.account_id
left join sf_user u
    ON t.userid = u.user_id
where t.isdeleted = false
  );

