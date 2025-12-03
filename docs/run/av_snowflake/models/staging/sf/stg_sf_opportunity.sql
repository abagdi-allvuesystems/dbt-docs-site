
  create or replace   view AV_EDM.AV_STAGING.stg_sf_opportunity
  
  
  
  
  as (
    WITH sf_opportunity AS (
    SELECT * 
    FROM AV_EDM.AV_SYSTEM.sys_sf_opportunity
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
        title AS user_title,
        department AS user_department
    FROM AV_EDM.AV_SYSTEM.sys_sf_users
)

SELECT
    -- Opportunity core fields
    opp.id AS opportunity_id,
    opp.name AS opportunity_name,
    opp.stage_name,
    opp.type,
    opp.amount,
    opp.close_date,
    opp.created_at,
    opp.last_modified_at,
    opp.account_id,
    opp.owner_id,
    opp.fiscal_quarter,
    opp.fiscal_year,
    opp.lead_source,
    opp.isclosed,
    opp.iswON,
    opp.arr,
    opp.ssp_arr,
    opp.active_arr,
    opp.qs_order_sub_type,
    opp.exclude_from_hitting_bookings_target,
    opp.cONtract_term,
    opp.sales_bookings_type,
    opp.total_cONtract_value,
    opp.sales_vp_forecast_category,
    opp.sales_vp_arr,
    opp.uplift_arr,
    opp.average_arr,
    opp.new_cONtract_arr,
    opp.ending_cONtract_arr,    
    opp.regiON,
    opp.segment,
    opp.sub_team,
    opp.market_segment, 
    opp.forecast_category,
    opp.forecast_category_name,
    opp.is_first_deal,
    opp.is_secONd_deal,
    opp.is_at_risk,
    opp.is_selected_vendor,

    -- Account enrichment
    acct.account_name,
    acct.account_type,
    acct.industry AS account_industry,
    acct.account_owner_id,

    -- Owner enrichment
    usr.user_name AS owner_name,
    usr.user_title AS owner_title,
    usr.user_department AS owner_department,

    -- Helpful derived fields
    CASE WHEN opp.isWON = true THEN 'WON'
         WHEN opp.isClosed = true THEN 'Lost'
         ELSE 'Open' END AS opportunity_status,

    DATE_TRUNC('month', opp.close_date) AS close_month,
    DATE_TRUNC('quarter', opp.close_date) AS close_quarter

FROM sf_opportunity opp
LEFT JOIN sf_account acct
    ON opp.account_id = acct.account_id
LEFT JOIN sf_user usr
    ON opp.owner_id = usr.user_id
  );

