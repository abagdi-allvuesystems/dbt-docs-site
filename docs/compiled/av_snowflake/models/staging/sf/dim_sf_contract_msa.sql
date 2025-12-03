WITH sf_contract AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_sf_contract
)
SELECT id AS contract_id
    ,contractnumber AS contract_number
    ,contract_record_type AS contract_record_type
    ,accountid AS account_id
    ,status AS status
    ,startdate AS initial_contract_term_start_date
    ,enddate AS current_contract_term_end_date
    ,name AS contract_name
    ,msa_deployment_type__c AS msa_deployment_type
    ,payment_terms__c AS payment_terms
    ,description AS description
    ,customersigneddate AS customer_signed_date
    ,companysigneddate AS company_signed_date
    ,data_rights__c AS data_rights
    ,data_rights_last_updated__c AS data_rights_last_updated
    ,data_rights_language__c as data_rights_language
    ,CASE WHEN data_rights__c IN ('Clause B', 'Clause C', 'Clause D', 'Clause E', 'Clause F') THEN true ELSE false END AS has_data_rights
    ,createddate AS sys_created
    ,lastmodifieddate AS sys_updated
    ,raw_updated AS raw_updated
FROM sf_contract
WHERE contract_record_type = 'Master Agreement'