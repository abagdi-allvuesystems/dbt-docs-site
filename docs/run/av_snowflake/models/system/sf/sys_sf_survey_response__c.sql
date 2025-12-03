
  create or replace   view AV_EDM.AV_SYSTEM.sys_sf_survey_response__c
  
  
  
  
  as (
    WITH raw AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_survey_response__c
)
    SELECT id AS id
        ,name AS name
        ,account__c AS account__c
        ,contact__c as contact__c
        ,csm__c AS csm__c
        ,name__c AS name__c
        ,email__c AS email__c
        ,title__c AS title__c
        ,isdeleted::BOOLEAN as isdeleted
        ,promotor__c AS promotor__c
        ,passive__c AS passive__c
        ,detractor__c AS detractor__c
        ,nps_score_f__c AS nps_score_f__c
        ,survey_name__c AS survey_name__c
        ,survey_role__c AS survey_role__c
        ,completed_at__c as completed_at__c
        ,how_likely_to_recommend_allvue__c
        ,closed_loop_notes__c AS closed_loop_notes__c
        ,createddate::TIMESTAMP_NTZ as createddate
        ,lastmodifieddate::TIMESTAMP_NTZ as lastmodifieddate
        ,_airbyte_extracted_at::TIMESTAMP_TZ as raw_updated
from raw
  );

