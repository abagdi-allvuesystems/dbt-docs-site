WITH assets_fo_serv AS (
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
      ,ca.portfolio_id AS aum_data_portfolio_id
      ,ca.portfolio_name AS aum_data_portfolio_name
      ,ca.portfolio_abbrev_name AS aum_data_portfolio_abbrev_name
      ,ca.MVRC AS mvrc
      ,ca.PARRC AS parrc
      ,ca.portfolio_flagged_as_test AS portfolio_flagged_as_test
      ,ca.as_of_date AS raw_data_extracted_date
FROM credit_aum ca LEFT JOIN assets_fo_serv fos ON ca.server_name = fos.hostname
                   LEFT JOIN assets_orgs ao ON fos.client = ao.object_key