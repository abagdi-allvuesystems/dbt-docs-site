WITH airbyte_raw_contract AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_contract
), sf_recordtype AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_recordtype
)
SELECT c.id AS id
        ,c.accountid AS accountid
        ,c.contractnumber AS contractnumber
        ,rt.name AS contract_record_type
        ,c.name AS name
        ,c.status AS status
        ,c.qs_parent_contract__c AS qs_parent_contract__c
        ,c.startdate::TIMESTAMP_TZ AS startdate
        ,c.enddate::TIMESTAMP_TZ AS enddate
        ,c.current_contract_term_start_date__c::TIMESTAMP_TZ AS current_contract_term_start_date__c
        ,c.contract_term__c AS contract_term__c
        ,c.contract_term_in_years__c AS contract_term_in_years__c
        ,c.escalator__c AS escalator__c
        ,c.opportunity_id__c AS opportunity_id__c
        ,c.ownerid AS ownerid
        ,c.payment_terms__c AS payment_terms__c
        ,c.description AS description
        ,c.customersigneddate::TIMESTAMP_TZ AS customersigneddate
        ,c.companysigneddate::TIMESTAMP_TZ AS companysigneddate
        ,c.data_rights__c AS data_rights__c
        ,c.data_rights_last_updated__c::TIMESTAMP_TZ AS data_rights_last_updated__c
        ,c.data_rights_language__c AS data_rights_language__c
        ,c.billing_schedule_1__c AS billing_schedule_1__c
        ,c.billing_schedule_2__c AS billing_schedule_2__c
        ,c.active_arr__c AS active_arr__c
        ,c.segment__c AS segment__c
        ,c.term_stage__c AS term_stage__c
        ,c.deal_structure__c AS deal_structure__c
        ,c.auto_renew_term_months__c AS auto_renew_term_months__c
        ,c.year_inflator_starts__c AS year_inflator_starts__c
        ,c.renewal_date__c::TIMESTAMP_TZ AS renewal_date__c
        ,c.lm_auto_renew_comments__c AS lm_auto_renew_comments__c
        ,c.escalator_2__c AS escalator_2__c
        ,c.escalator_fixed_or_variable__c AS escalator_fixed_or_variable
        ,c.qs_contract_type__c AS qs_contract_type__c
        ,c.msa_deployment_type__c as msa_deployment_type__c
        ,c.createddate::TIMESTAMP_TZ AS createddate
        ,c.systemmodstamp::TIMESTAMP_TZ AS systemmodstamp
        ,c.lastmodifieddate::TIMESTAMP_TZ AS lastmodifieddate
        ,c._airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM airbyte_raw_contract c LEFT JOIN sf_recordtype rt ON c.recordtypeid = rt.id