
  create or replace   view AV_EDM.AV_SYSTEM.sys_sf_quote
  
  
  
  
  as (
    WITH raw_quote AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_quote
)

SELECT
    -- identifiers
    id AS quote_id,
    accountid AS account_id,
    contactid AS contact_id,
    opportunityid AS opportunity_id,
    pricebook2id AS pricebook_id,
    ownerid AS owner_id,
    recordtypeid AS record_type_id,

    -- core attributes
    name AS quote_name,
    status AS status,
    quotenumber AS quote_number,
    description AS description,
    currencyisocode AS currency_iso_code,
    contractid AS contract_id,

    -- financials
    subtotal AS subtotal,
    discount AS discount,
    discount__c AS discount_custom,
    grandtotal AS grand_total,
    totalprice AS total_price,
    shippinghandling AS shipping_handling,
    services_total__c AS services_total,
    software_total__c AS software_total,
    prior_total_price__c AS prior_total_price,
    escalator__c AS escalator,
    escalator_2__c AS escalator_2,
    contract_term__c AS contract_term_months,
    prior_escalator__c AS prior_escalator,
    auto_renew_term_months__c AS auto_renew_term_months,
    contract_term_in_years__c AS contract_term_years,
    initial_contract_years__c AS initial_contract_years,
    subscription_term__c AS subscription_term_months,
    subscription_term_in_years__c AS subscription_term_years,
    prior_contract_term_in_months__c AS prior_contract_term_months,

    -- dates
    createddate AS created_at,
    lastmodifieddate AS last_modified_at,
    lastvieweddate AS last_viewed_at,
    lastreferenceddate AS last_referenced_at,
    expirationdate AS expiration_date,
    start_date__c AS start_date,
    subscription_start_date__c AS subscription_start_date,
    subscription_end_date__c AS subscription_end_date,
    pricing_approval_date__c AS pricing_approval_date,
    quote_resubmitted__c AS quote_resubmitted_at,

    -- contact info
    email AS email,
    phone AS phone,
    fax AS fax,

    -- billing address
    billingcity AS billing_city,
    billingstate AS billing_state,
    billingcountry AS billing_country,
    billingpostalcode AS billing_postal_code,

    -- shipping address
    shippingcity AS shipping_city,
    shippingstate AS shipping_state,
    shippingcountry AS shipping_country,
    shippingpostalcode AS shipping_postal_code,

    -- quote-to address
    quotetocity AS quote_to_city,
    quotetostate AS quote_to_state,
    quotetocountry AS quote_to_country,
    quotetopostalcode AS quote_to_postal_code,

    -- additional address
    additionalcity AS additional_city,
    additionalstate AS additional_state,
    additionalcountry AS additional_country,
    additionalpostalcode AS additional_postal_code,

    -- QS address fields
    qs_bill_to_city__c AS qs_bill_to_city,
    qs_ship_to_city__c AS qs_ship_to_city,
    qs_bill_to_state__c AS qs_bill_to_state,
    qs_ship_to_state__c AS qs_ship_to_state,
    qs_bill_to_country__c AS qs_bill_to_country,
    qs_ship_to_country__c AS qs_ship_to_country,
    qs_bill_to_zip_postal_code__c AS qs_bill_to_zip_code,
    qs_ship_to_zip_postal_code__c AS qs_ship_to_zip_code,

    -- operational flags
    isdeleted AS is_deleted,
    issyncing AS is_syncing,
    cancreatequotelineitems AS can_create_quote_line_items,
    finance_pricing_approved__c AS finance_pricing_approved,

    -- business fields
    payment_terms__c AS payment_terms,
    year_inflator_starts__c AS year_inflator_starts,
    escalator_fixed_or_variable__c AS escalator_fixed_or_variable,
    prior_escalator_fixed_or_variable__c AS prior_escalator_fixed_or_variable,
    qs_bill_to_attention_to__c AS qs_bill_to_attention_to,
    qs_ship_to_attention_to__c AS qs_ship_to_attention_to,
    opportunity_name_formula__c AS opportunity_name_formula,

    _airbyte_extracted_at AS raw_updated

FROM raw_quote
  );

