
  create or replace   view AV_EDM.AV_SOURCE.src_ab_sf_qs_customer_asset__c
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.SALESFORCE.QS_CUSTOMER_ASSET__C
  );

