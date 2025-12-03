WITH ab_sf_users AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_users
)
SELECT id::VARCHAR AS id
    ,name::VARCHAR AS name
    ,email::VARCHAR AS email
    ,title::VARCHAR AS title
    ,isactive::BOOLEAN AS isactive
    ,firstname::VARCHAR AS firstname
    ,lastname::VARCHAR AS lastname
    ,usertype::VARCHAR AS usertype
    ,username::VARCHAR AS username
    ,accountid::VARCHAR AS accountid
    ,badgetext::VARCHAR AS badgetext
    ,contactid::VARCHAR AS contactid
    ,adp_workerid__c::VARCHAR AS adp_workerid__c
    ,managerid::VARCHAR AS managerid
    ,profileid::VARCHAR AS profileid
    ,region__c::VARCHAR AS region__c
    ,department::VARCHAR AS department
    ,userroleid::VARCHAR AS userroleid
    ,countrycode::VARCHAR AS countrycode
    ,createddate::TIMESTAMP_TZ AS createddate
    ,lastlogindate::TIMESTAMP_TZ AS lastlogindate
    ,systemmodstamp::TIMESTAMP_TZ AS systemmodstamp
    ,lastmodifiedbyid::VARCHAR AS lastmodifiedbyid
    ,lastmodifieddate::TIMESTAMP_TZ AS lastmodifieddate
    ,netsuite_id__c::INT AS netsuite_id__c
    ,timezonesidkey::VARCHAR AS timezonesidkey
from ab_sf_users