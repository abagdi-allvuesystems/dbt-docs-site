
  create or replace   view AV_EDM.AV_SYSTEM.sys_sf_campaignmember
  
  
  
  
  as (
    WITH raw_campaign_member AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_campaignmember
)
SELECT id::VARCHAR AS id
    ,campaignid::VARCHAR AS campaignid
    ,leadid::VARCHAR AS leadid
    ,contactid::VARCHAR AS contactid
    ,account_type__c::VARCHAR AS account_type
    ,campaign_start_date__c::DATE AS campaign_start_date
    ,campaign_end_date__c::DATE AS campaign_end_date
    ,campaign_status__c::VARCHAR AS campaign_status
    ,companyoraccount::VARCHAR AS companyoraccount
    ,city::VARCHAR as city
    ,state::VARCHAR AS state
    ,country::VARCHAR AS country    
    ,currencyisocode::VARCHAR AS currencyisocode
    ,description::VARCHAR AS description
    ,email::VARCHAR AS email
    ,fax::VARCHAR AS fax
    ,firstname::VARCHAR AS firstname
    ,lastname::VARCHAR AS lastname
    ,phone::VARCHAR AS phone
    ,hasoptedoutofemail::BOOLEAN AS hasoptedoutofemail
    ,hasoptedoutoffax::BOOLEAN AS hasoptedoutoffax
    ,hasresponded::BOOLEAN AS hasresponded
    ,salutation::VARCHAR AS salutation
    ,title::VARCHAR AS title
    ,type::VARCHAR AS type
    ,status::VARCHAR AS status
    ,isdeleted::BOOLEAN AS isdeleted
    ,createdbyid::VARCHAR AS createdbyid
    ,createddate::TIMESTAMP_NTZ AS createddate
    ,lastmodifiedbyid::VARCHAR AS lastmodifiedbyid
    ,lastmodifieddate::TIMESTAMP_NTZ AS lastmodifieddate
    ,systemmodstamp::TIMESTAMP_NTZ AS systemmodstamp
    ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM raw_campaign_member
  );

