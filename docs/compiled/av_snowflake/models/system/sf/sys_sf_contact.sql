WITH raw_contact AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_contact
)
SELECT id AS id
    ,name::VARCHAR AS name
    ,email::VARCHAR AS email
    ,phone::VARCHAR AS phone
    ,title::VARCHAR AS title
    ,accountid::VARCHAR AS accountid
    ,active__c::BOOLEAN AS active
    ,firstname::VARCHAR AS firstname
    ,lastname::VARCHAR AS lastname
    ,affiliation_to_allvue__c::VARCHAR AS affiliation_to_allvue
    ,department::VARCHAR AS department
    ,departmentgroup::VARCHAR AS departmentgroup
    ,domain__c::VARCHAR AS domain
    ,genderidentity::VARCHAR AS genderidentity
    ,individualid::VARCHAR AS individualid
    ,leadsource::VARCHAR AS leadsource
    ,nps_value__c::FLOAT AS nps_value
    ,ownerid::VARCHAR AS ownerid
    ,unique_id__c::VARCHAR AS unique_id
    ,isdeleted::BOOLEAN AS isdeleted
    ,jsm_id__c::VARCHAR AS assets_id
    ,jsm_portal_user__c::VARCHAR AS jsm_portal_user
    ,createddate::TIMESTAMP_TZ AS createddate
    ,systemmodstamp::TIMESTAMP_TZ AS systemmodstamp
    ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM raw_contact