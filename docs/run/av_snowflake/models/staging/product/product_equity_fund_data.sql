
  create or replace   view AV_EDM.AV_STAGING.product_equity_fund_data
  
  
  
  
  as (
    WITH feb_24 AS (
    SELECT * FROM AV_EDM.AV_SOURCE.equity_aum_2024_02_07
)
SELECT '2024-02-07'::TIMESTAMP_TZ AS as_of_date
    ,db_is_fund_admin AS db_is_fund_admin
    ,parent_db AS parent_db
    ,database_name AS database_name
    ,fund_name AS fund_name
    ,num_of_funds::NUMBER AS num_of_funds
    ,amt_of_contributions::NUMBER AS amt_of_contributions
    ,amt_of_distributions::NUMBER AS amt_of_distributions
    ,capital_account_balance::NUMBER AS capital_account_balance
    ,num_of_investors::NUMBER AS num_of_investors
    ,num_portfolio_companies::NUMBER AS num_portfolio_companies
    ,total_commitment::NUMBER AS total_commitment
    ,CASE WHEN UPPER(fund_name) LIKE '%TEST%' OR UPPER(fund_name) like '%DEMO%' THEN 'true' ELSE 'false' END::BOOLEAN AS fund_flagged_as_test
FROM feb_24
where 
    parent_db != 'VistaEquityPartnersDWFund' AND
    fund_name != 'Bond Partners, LLC' AND
    parent_db != 'USBANKDWFund' AND
    database_name != 'RSMRSMUSDWFund' AND
    database_name != 'RSMDWFund' AND
    database_name != 'StandishABCPartnersDWFund' AND
    database_name != 'JGMCPAIQEQDWFund' AND
    database_name != 'GPFSDWFund'
  );

