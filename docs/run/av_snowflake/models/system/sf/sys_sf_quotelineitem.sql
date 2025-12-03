
  create or replace   view AV_EDM.AV_SYSTEM.sys_sf_quotelineitem
  
  
  
  
  as (
    WITH raw_quote_line_item AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_quotelineitem
)

SELECT
    -- identifiers
    id AS quote_line_item_id,
    quoteid AS quote_id,
    product2id AS product_id,
    pricebookentryid AS pricebook_entry_id,
    opportunitylineitemid AS opportunity_line_item_id,

    -- financials
    quantity AS quantity,
    unitprice AS unit_price,
    listprice AS list_price,
    discount AS discount,
    subtotal AS subtotal,
    totalprice AS total_price,
    escalator__c AS escalator,
    escalated_sales_price__c AS escalated_sales_price,

    -- categorization / segmentation
    product_type__c AS product_type,
    product_sub_type__c AS product_sub_type,
    bookings_type__c AS bookings_type,
    pricing_category__c AS pricing_category,
    billing_frequency__c AS billing_frequency,

    -- ordering / display fields
    sortorder AS sort_order,
    linenumber AS line_number,

    -- activity timestamps
    createddate AS created_at,
    lastmodifieddate AS last_modified_at,
    lastvieweddate AS last_viewed_at,
    lastreferenceddate AS last_referenced_at,
    servicedate AS service_date,

    -- audit
    createdbyid AS created_by_id,
    lastmodifiedbyid AS last_modified_by_id,
    isdeleted AS is_deleted,
    
    -- misc
    description AS description,
    currencyisocode AS currency_iso_code,

    -- airbyte metadata
    _airbyte_extracted_at AS raw_updated

FROM raw_quote_line_item
  );

