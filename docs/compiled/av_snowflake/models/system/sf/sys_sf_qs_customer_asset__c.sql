WITH QS_CUSTOMER_ASSET__C AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_qs_customer_asset__c
)
SELECT id AS id
    ,name AS name
    ,isdeleted as isdeleted
    ,segment__c as segment__c
    ,createdbyid as createdbyid
    ,createddate as createddate
    ,qs_account__c as qs_account__c
    ,qs_product__c as qa_product__c
    ,lastvieweddate
    ,opportunity__c
    ,qs_end_date__c
    ,qs_quantity__c
    ,systemmodstamp
    ,currencyisocode
    ,product_line__c
    ,lastmodifiedbyid
    ,lastmodifieddate
    ,qs_start_date__c
    ,rider_contract__c
    ,segment_rollup__c
    ,lastreferenceddate
    ,qs_asset_status__c
    ,expired_quantity__c
    ,master_opportunity__c
    ,pending_renewal_quantity__c
    ,pending_activation_quantity__c
    ,qs_annual_recurring_revenue__c
    ,qs_customer_asset_name_value__c
    ,qs_product_description_value__c
    ,pending_decommission_quantity__c
    ,qs_effective_decommision_date__c
    ,active_subscriptions_with_zero__c
    ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM QS_CUSTOMER_ASSET__C