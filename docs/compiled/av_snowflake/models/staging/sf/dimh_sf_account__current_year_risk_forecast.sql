WITH sf_acct AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_sf_account
), sf_acct_his AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_sf_accounthistory
)
select  created_date as effective_date_start
        ,IFNULL(LAG(created_date) OVER (PARTITION BY account_id,field ORDER BY created_date desc),'9999-12-31')::TIMESTAMP_NTZ as effective_date_end
        ,CASE WHEN LAG(created_date) OVER (PARTITION BY account_id,field ORDER BY created_date desc) IS NULL THEN true else false END::BOOLEAN as is_current
        ,account_id as account_id
        ,new_value as current_year_risk_forecast_percent
from sf_acct_his
where field = 'current_year_risk_forecast'