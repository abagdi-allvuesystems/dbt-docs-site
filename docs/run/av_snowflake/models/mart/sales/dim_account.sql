
  
    

create or replace transient table AV_EDM.AV_SALES.dim_account
    
    
    
    as (WITH dim_account AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_account
), sf_users AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_users
), equity_owner AS (
    SELECT da.sales_equity_owner_id AS id
    ,su.name AS sales_equity_owner_name
    FROM dim_account da LEFT JOIN sf_users su ON da.sales_equity_owner_id = su.id
), credit_owner AS (
    SELECT dac.sales_credit_owner_id AS id
    ,sfu.name AS sales_credit_owner_name
    FROM dim_account dac LEFT JOIN sf_users sfu ON dac.sales_credit_owner_id = sfu.id
)
SELECT distinct
    acct.account_id AS account_id,
    acct.name AS name,
    acct.is_active AS is_active,
    acct.account_type AS account_type,
    acct.client_vertical AS client_vertical,
    acct.segment AS segment,
    acct.segmentation AS segmentation,
    acct.finance_arr AS finance_arr,
    acct.health_score AS health_score,
    acct.nps_score AS nps_score,
    acct.arr_by_customer_asset AS arr_by_customer_asset,
    acct.netsuite_id AS netsuite_id,
    acct.openair_id AS openair_id,
    acct.sys_updated AS sys_updated,
    acct.sys_created AS sys_created,
    acct.csm_id AS csm_id,
    acct.csm_name AS csm_name,
    acct.sales_account_manager_id AS sales_account_manager_id,
    acct.sales_account_manager_name AS sales_account_manager_name,
    acct.sales_credit_owner_id AS sales_credit_owner_id,
    co.sales_credit_owner_name AS sales_credit_owner_name,
    acct.sales_equity_owner_id AS sales_equity_owner_id,
    eo.sales_equity_owner_name AS sales_equity_owner_name
FROM dim_account acct LEFT JOIN equity_owner eo ON acct.sales_equity_owner_id = eo.id
                      LEFT JOIN credit_owner co ON acct.sales_credit_owner_id = co.id
    )
;


  