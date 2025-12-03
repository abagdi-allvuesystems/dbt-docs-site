
  
    

create or replace transient table AV_EDM.AV_DATA_RIGHTS.equity_fund_rollup
    
    
    
    as (WITH product_equity_fund_data AS (
    SELECT * FROM AV_EDM.AV_STAGING.product_equity_fund_data
), assets_equitydwh AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_assets_ism_clientserv_equitydwh_legacy
), assets_orgs AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_assets_organizations
)
SELECT parent_db AS parent_db
        ,ae.client AS assets_org_key
        ,ao.salesforce_account_id AS salesforce_account_id
        ,ae.name AS assets_service_name
        ,ae.key AS assets_service_object_key
        ,MAX(db_is_fund_admin) AS aum_data_is_fund_admin
        ,SUM(num_of_funds) AS total_funds
        ,SUM(amt_of_contributions) AS total_amt_of_contributions
        ,SUM(amt_of_distributions) AS total_amt_of_distributions
        ,SUM(capital_account_balance) AS total_capital_account_balance
        ,SUM(num_of_investors) AS total_investors
        ,SUM(num_portfolio_companies) AS total_portfolio_companies
        ,SUM(total_commitment) AS total_commitment
FROM product_equity_fund_data fd LEFT JOIN assets_equitydwh ae ON fd.parent_db = ae.warehouse_database_name
                                 LEFT JOIN assets_orgs ao ON ae.client = ao.object_key
WHERE fund_flagged_as_test = false
GROUP BY parent_db,ae.name,ae.client,ao.salesforce_account_id,ae.key
    )
;


  