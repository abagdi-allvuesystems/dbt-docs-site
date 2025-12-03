
  create or replace   view AV_EDM.AV_SYSTEM.sys_sf_campaign
  
  
  
  
  as (
    WITH raw_campaign AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_campaign
)
SELECT id::VARCHAR AS id
    ,name::VARCHAR AS name
    ,type::VARCHAR AS type
    ,status::VARCHAR AS status
    ,startdate::TIMESTAMP_NTZ AS startdate
    ,enddate::TIMESTAMP_NTZ AS enddate
    ,roi__c::FLOAT AS roi
    ,level__c::VARCHAR AS level
    ,region__c::VARCHAR AS region
    ,segment__c::VARCHAR AS segment
    ,subtype__c::VARCHAR AS subtype
    ,category__c::VARCHAR AS category
    ,location__c::VARCHAR AS location
    ,subregion__c::VARCHAR AS subregion
    ,numberofleads::INT AS numberofleads
    ,currencyisocode::VARCHAR AS currencyisocode
    ,expected_roi__c::FLOAT AS expectedroi
    ,expectedrevenue::FLOAT AS expectedrevenue
    ,budgetedcost::FLOAT AS budgetedcost
    ,actualcost::FLOAT AS actualcost
    ,expectedresponse::INT AS expectedresponse
    ,numberofcontacts::INT AS numberofcontacts
    ,numberofresponses::INT AS numberofresponses
    ,hierarchyactualcost::FLOAT AS hierarchyactualcost
    ,hierarchybudgetedcost::FLOAT AS hierarchybudgetedcost
    ,hierarchynumbersent::INT AS hierarchynumsent
    ,numberofopportunities::INT AS numberofopportunities
    ,amountallopportunities::FLOAT AS amountallopportunities
    ,amountwonopportunities::FLOAT AS amountwonopportunities
    ,expected_number_of_opportunities__c::FLOAT AS expectednumberofopportunities
    ,ownerid::VARCHAR AS ownerid
    ,isactive::BOOLEAN AS isactive
    ,isdeleted::BOOLEAN AS isdeleted
    ,createdbyid::VARCHAR AS createdbyid
    ,createddate::TIMESTAMP_NTZ AS createddate
    ,lastmodifiedbyid::VARCHAR AS lastmodifiedbyid
    ,lastmodifieddate::TIMESTAMP_NTZ AS lastmodifieddate
    ,systemmodstamp::TIMESTAMP_NTZ AS systemmodstamp
    ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM raw_campaign
  );

