WITH product_equity_fund_data AS (
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
        ,db_is_fund_admin AS aum_data_is_fund_admin
        ,num_of_funds AS num_of_funds
        ,amt_of_contributions AS amt_of_contributions
        ,amt_of_distributions AS amt_of_distributions
        ,capital_account_balance AS capital_account_balance
        ,num_of_investors AS num_of_investors
        ,num_portfolio_companies AS num_portfolio_companies
        ,total_commitment AS total_commitment
        ,fund_flagged_as_test AS fund_flagged_as_test
        ,fd.as_of_date AS raw_data_extracted_date
FROM product_equity_fund_data fd LEFT JOIN assets_equitydwh ae ON fd.parent_db = ae.warehouse_database_name
                                 LEFT JOIN assets_orgs ao ON ae.client = ao.object_key