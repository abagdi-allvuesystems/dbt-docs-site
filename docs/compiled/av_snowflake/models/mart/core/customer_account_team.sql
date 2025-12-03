WITH dim_sf_cust_at AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_customer_account_team
)
SELECT MD5(accountteammember_id) AS id
    ,account_id AS sf_account_id
    ,account_name AS customer_name
    ,user_name AS user_name
    ,team_member_role AS team_member_role
FROM dim_sf_cust_at