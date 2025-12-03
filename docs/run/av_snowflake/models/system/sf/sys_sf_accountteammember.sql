
  create or replace   view AV_EDM.AV_SYSTEM.sys_sf_accountteammember
  
  
  
  
  as (
    WITH raw_account_team_member AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_accountteammember
)
select id::VARCHAR AS id
    ,title::VARCHAR AS title
    ,userid::VARCHAR AS userid
    ,accountid::VARCHAR AS accountid
    ,isdeleted::BOOLEAN AS isdeleted
    ,createdbyid::VARCHAR as createdbyid
    ,createddate::TIMESTAMP_NTZ AS createddate
    ,teammemberrole::VARCHAR AS teammemberrole
    ,accountaccesslevel::VARCHAR AS accountaccesslevel
    ,caseaccesslevel::VARCHAR AS caseaccesslevel
    ,contactaccesslevel::VARCHAR AS contactaccesslevel
    ,opportunityaccesslevel::VARCHAR AS opportunityaccesslevel
    ,currencyisocode::VARCHAR AS currencyisocode
    ,unique_id__c::VARCHAR AS unique_id
    ,systemmodstamp::TIMESTAMP_NTZ AS systemmodstamp
    ,lastmodifieddate::TIMESTAMP_NTZ AS lastmodifieddate
    ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM raw_account_team_member
  );

