
  create or replace   view AV_EDM.AV_SYSTEM.sys_sf_opportunityproduct
  
  
  
  
  as (
    WITH source_opportunity_product AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_opportunityproduct
)

SELECT
    -- Primary Keys / Foreign Keys
    id AS id,
    opportunityid AS opportunity_id,
    product2id AS product_id,
    pricebookentryid AS pricebook_entry_id,

    -- Core Fields
    name AS name,
    description AS description,
    productcode AS product_code,
    currencyisocode AS currency_iso_code,
    isdeleted AS is_deleted,

    -- Pricing & Quantity
    quantity AS quantity,
    unitprice AS unit_price,
    listprice AS list_price,
    discount AS discount,
    totalprice AS total_price,
    subtotal AS subtotal,
    sortorder AS sort_order,

    -- Date Fields
    servicedate AS service_date,
    start_date__c AS start_date,
    end_date__c AS end_date,
    end_date_helper__c AS end_date_helper,
    lastvieweddate AS last_viewed_at,
    lastreferenceddate AS last_referenced_at,

    -- Product Metadata
    segment__c AS segment,
    product_type__c AS product_type,
    product_grouping__c AS product_grouping,
    product_sub_type__c AS product_sub_type,
    product_groupings__c AS product_groupings,
    product_name_hidden__c AS product_name_hidden,
    product_type_concatenated__c AS product_type_concatenated,
    product_is_pending__c AS product_is_pending,

    -- Bookings / Revenue Fields
    bookings_type__c AS bookings_type,
    bookings_amount__c AS bookings_amount,
    bookings_amount_override__c AS bookings_amount_override,
    monthly_amount__c AS monthly_amount,
    quote_discount__c AS quote_discount,
    prorated_sales_price__c AS prorated_sales_price,
    prorated_total_price__c AS prorated_total_price,
    escalated_sales_price__c AS escalated_sales_price,
    escalated_total_price__c AS escalated_total_price,
    initial_escalated_sales_price__c AS initial_escalated_sales_price,
    initial_escalated_total_price__c AS initial_escalated_total_price,
    prorated_escalated_sales_price__c AS prorated_escalated_sales_price,
    prorated_escalated_total_price__c AS prorated_escalated_total_price,

    -- Subscription / Term Fields
    subscription_term__c AS subscription_term,
    is_first_year_product__c AS is_first_year_product,
    is_multi_year_processed__c AS is_multi_year_processed,

    -- QS / ARR Fields
    qs_license_metric__c AS qs_license_metric,
    qs_non_recurring_revenue__c AS qs_non_recurring_revenue,
    qs_annual_recurring_revenue__c AS qs_arr,

    -- PS / Services Fields
    ps_hours__c AS ps_hours,
    ps_allocation__c AS ps_allocation,
    ps_allocation_type__c AS ps_allocation_type,
    ps_allocation_notes__c AS ps_allocation_notes,
    ps_allocation_override__c AS ps_allocation_override,
    delivery_method__c AS delivery_method,
    create_asset__c AS create_asset,

    -- Custom Fields
    year__c AS year,
    openair_id__c AS openair_id,
    escalator__c AS escalator,

    -- Audit Fields
    createddate AS created_at,
    createdbyid AS created_by_id,
    lastmodifieddate AS last_modified_at,
    lastmodifiedbyid AS last_modified_by_id,
    systemmodstamp AS system_modstamp,

    -- Airbyte Metadata
    _airbyte_extracted_at AS extracted_at
FROM source_opportunity_product
  );

