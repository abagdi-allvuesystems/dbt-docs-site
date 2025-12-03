
  create or replace   view AV_EDM.AV_SOURCE.equity_aum_2024_02_07
  
  
  
  
  as (
    WITH eu_nfa_raw AS (
    SELECT 'false'::BOOLEAN AS db_is_fund_admin,* FROM LANDING_EDM.PRODUCT_AUM_AUA.EQUITY_PORTFOLIO_DATA_EU_2024_02_07
), eu_fa_raw AS (
    SELECT 'true'::BOOLEAN AS db_is_fund_admin,* FROM LANDING_EDM.PRODUCT_AUM_AUA.EQUITY_PORTFOLIO_DATA_EU_FA_2024_02_07
), us_nfa_raw AS (
    SELECT 'false'::BOOLEAN AS db_is_fund_admin,* FROM LANDING_EDM.PRODUCT_AUM_AUA.EQUITY_PORTFOLIO_DATA_US_2024_02_07
), us_fa_raw AS (
    SELECT 'true'::BOOLEAN AS db_is_fund_admin,* FROM LANDING_EDM.PRODUCT_AUM_AUA.EQUITY_PORTFOLIO_DATA_US_FA_2024_02_07
)
SELECT *
FROM eu_nfa_raw
UNION
SELECT *
FROM eu_fa_raw
UNION
SELECT *
FROM us_nfa_raw
UNION
SELECT *
FROM us_fa_raw
  );

