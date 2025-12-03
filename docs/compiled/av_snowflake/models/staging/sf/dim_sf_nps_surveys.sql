WITH sys_surveys AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_sf_survey_response__c
), sf_acct AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_sf_account
), sf_contact AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_sf_contact
)
select s.id as survey_response_id
    ,s.name as name
    ,s.account__c as account_id
    ,a.name as account_name
    ,s.contact__c as contact_id
    ,c.name as contact_name
    ,c.email as contact_email
    ,s.completed_at__c as completion_date
    ,s.how_likely_to_recommend_allvue__c AS how_likely_to_recommend_allvue
    ,CASE WHEN s.promotor__c = 1 then true ELSE false END::BOOLEAN as is_promotor
    ,CASE WHEN s.passive__c = 1 then true ELSE false END::BOOLEAN as is_passive
    ,CASE WHEN s.detractor__c = 1 then true ELSE false END::BOOLEAN as is_detractor
    ,s.promotor__c as count_promotor
    ,s.passive__c as count_passive
    ,s.detractor__c as count_detractor
    ,s.nps_score_f__c as nps_score_state
    ,s.closed_loop_notes__c as closed_loop_notes
from sys_surveys s LEFT JOIN sf_acct a on s.account__c = a.id
                   LEFT JOIN sf_contact c on s.contact__c = c.id