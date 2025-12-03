
  
    

create or replace transient table AV_EDM.AV_DATA_RIGHTS.credit_portfolio_rollup
    
    
    
    as (WITH assets_fo_serv AS (
    SELECT *
    ,REPLACE(EVEREST_APP_SERVER,'.BLKMTNHOSTING.COM','') AS hostname 
    FROM AV_EDM.AV_STAGING.dim_assets_ism_clientserv_frontoffice 
), credit_aum AS (
    SELECT * FROM AV_EDM.AV_STAGING.product_credit_portfolio_data WHERE PARRC > 50.0
), assets_orgs AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_assets_organizations
)
SELECT ca.server_name AS aum_server_name
      ,fos.client AS assets_org_key
      ,ao.salesforce_account_id AS salesforce_account_id
      ,fos.name AS assets_service_name
      ,fos.key AS assets_service_object_key
      ,COUNT(portfolio_id) AS total_portfolios
      ,ROUND(SUM(MVRC),2) AS total_mvrc
      ,ROUND(SUM(PARRC),2) AS total_parrc
      ,ROUND(SUM(ABS(mvrc)),2) AS abs_mvrc
      ,ROUND(SUM(ABS(parrc)),2) AS abs_parrc
FROM credit_aum ca LEFT JOIN assets_fo_serv fos ON ca.server_name = fos.hostname
                   LEFT JOIN assets_orgs ao ON fos.client = ao.object_key
WHERE portfolio_flagged_as_test = false
GROUP BY ca.server_name,fos.client,ao.salesforce_account_id,fos.name,fos.key
    )
;


  