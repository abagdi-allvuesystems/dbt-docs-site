WITH sf_contract AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_sf_contract
)
SELECT id AS contract_id
    ,contractnumber AS contract_number
    ,contract_record_type AS contract_record_type
    ,qs_parent_contract__c AS msa_contract_id
    ,accountid AS account_id
    ,status AS status
    ,name AS contract_name
    ,ownerid AS contract_owner_id
    ,segment__c AS segment
    ,term_stage__c AS term_stage
    ,startdate AS initial_contract_term_start_date
    ,enddate AS current_contract_term_end_date
    ,current_contract_term_start_date__c AS current_contract_term_start_date
    ,contract_term__c::FLOAT AS current_term_months
    ,contract_term_in_years__c::FLOAT AS contract_term_years
    ,billing_schedule_1__c AS billing_schedule_1
    ,ROUND(active_arr__c::FLOAT,2) AS active_arr
    ,payment_terms__c AS payment_terms__c
    ,description AS description
    ,customersigneddate AS customer_signed_date
    ,companysigneddate AS company_signed_date
    ,deal_structure__c AS deal_structure
    ,auto_renew_term_months__c::NUMBER AS auto_renew_term_in_months
    ,escalator__c AS escalator_pct
    ,escalator_2__c AS escalator_2
    ,escalator_fixed_or_variable AS escalator_fixed_or_variable
    ,year_inflator_starts__c AS year_escalator_starts
    ,lm_auto_renew_comments__c AS auto_renew_comments
    ,renewal_date__c AS renewal_date
    ,createddate AS sys_created
    ,lastmodifieddate AS sys_updated
    ,raw_updated AS raw_updated
FROM sf_contract
WHERE contract_record_type = 'Product Rider'