
  create or replace   view AV_EDM.AV_SYSTEM.sys_sf_product2
  
  
  
  
  as (
    WITH product2 AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_product2
)
SELECT id AS id
    ,name AS name
    ,family
    ,isactive
    ,isdeleted
    ,displayurl
    ,externalid
    ,isarchived
    ,segment__c
    ,createdbyid
    ,createddate
    ,description
    ,productcode
    ,netsuiteid__c
    ,product_id__c
    ,lastvieweddate
    ,systemmodstamp
    ,create_asset__c
    ,currencyisocode
    ,product_type__c
    ,sales_status__c
    ,lastmodifiedbyid
    ,lastmodifieddate
    ,stockkeepingunit
    ,delivery_method__c
    ,lastreferenceddate
    ,pricing_category__c
    ,product_grouping__c
    ,product_sub_type__c
    ,externaldatasourceid
    ,product_unique_id__c
    ,qs_license_metric__c
    ,display_on_invoice__c
    ,quantityunitofmeasure
    ,original_product_name__c
    ,trigger_project_creation__c
    ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM product2
  );

