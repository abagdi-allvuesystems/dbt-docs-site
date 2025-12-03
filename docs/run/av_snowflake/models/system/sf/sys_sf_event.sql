
  create or replace   view AV_EDM.AV_SYSTEM.sys_sf_event
  
  
  
  
  as (
    WITH raw_event AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_event
)
SELECT id AS id
    ,accountid::VARCHAR AS accountid
    ,type::VARCHAR AS type
    ,eventsubtype::VARCHAR AS eventsubtype
    ,startdatetime::TIMESTAMP_TZ AS startdatetime
    ,enddatetime::TIMESTAMP_TZ AS enddatetime
    ,location::VARCHAR AS location
    ,description::VARCHAR AS description
    ,department__c::VARCHAR AS department
    ,durationinminutes::INT AS durationinminutes
    ,account_last_contact_date__c::DATE AS account_last_contact_date
    ,activitydate::DATE AS activitydate
    ,activitydatetime::TIMESTAMP_TZ AS activitydatetime
    ,activity_count__c::FLOAT AS activity_count_c
    ,activity_count__c::FLOAT AS activity_count_int
    ,activity_sub_type__c::VARCHAR AS activity_sub_type
    ,activity_type__c::VARCHAR AS activity_type
    ,activity_unique_id__c::VARCHAR AS activity_unique_id
    ,allvue_attendees__c::VARCHAR AS allvue_attendees
    ,client_attendees__c::VARCHAR AS client_attendees
    ,gong__activity_source__c::VARCHAR AS gong_activity_source
    ,gong__associated_accounts__c::VARCHAR AS gong_associated_accounts
    ,gong__associated_opportunities__c::VARCHAR AS gong_associated_opportunities
    ,groupeventtype::VARCHAR AS groupeventtype
    ,isalldayevent::BOOLEAN AS isalldayevent
    ,isarchived::BOOLEAN AS isarchived
    ,ischild::BOOLEAN AS ischild
    ,isdeleted::BOOLEAN AS isdeleted
    ,isgroupevent::BOOLEAN AS isgroupevent
    ,isprivate::BOOLEAN AS isprivate
    ,isrecurrence::BOOLEAN AS isrecurrence
    ,isrecurrence2::BOOLEAN AS isrecurrence2
    ,isrecurrence2exception::BOOLEAN AS isrecurrence2exception
    ,isrecurrence2exclusion::BOOLEAN AS isrecurrence2exclusion
    ,isreminderset::BOOLEAN AS isreminderset
    ,isvisibleinselfservice::BOOLEAN AS isvisibleinselfservice
    ,make_primary_note__c::BOOLEAN AS make_primary_note
    ,next_steps__c::VARCHAR AS next_steps
    ,outreach_id__c::VARCHAR AS outreach_id
    ,past_due__c::BOOLEAN AS past_due
    ,qs_coached_by__c::VARCHAR AS qs_coached_by
    ,qs_coaching_status__c::VARCHAR AS qs_coaching_status
    ,qs_date_of_coaching__c::DATE AS qs_date_of_coaching
    ,qs_key_action__c::BOOLEAN AS qs_key_action
    ,recurrence2patternstartdate::VARCHAR AS recurrence2patternstartdate
    ,recurrenceactivityid::VARCHAR AS recurrenceactivityid
    ,recurrencedayofmonth::INT AS recurrencedayofmonth
    ,recurrencedayofweekmask::INT AS recurrencedayofweekmask
    ,recurrenceenddateonly::DATE AS recurrenceenddateonly
    ,recurrencetype::VARCHAR AS recurrencetype
    ,reminderdatetime::TIMESTAMP_TZ AS reminderdatetime
    ,whatcount::INT AS whatcount
    ,whatid::VARCHAR AS whatid
    ,whocount::INT AS whocount
    ,whoid::VARCHAR AS whoid
    ,ownerid::VARCHAR AS ownerid
    ,createddate::TIMESTAMP_TZ AS createddate
    ,lastmodifiedbyid::VARCHAR AS lastmodifiedbyid
    ,lastmodifieddate::TIMESTAMP_TZ AS lastmodifieddate
    ,systemmodstamp::TIMESTAMP_TZ AS systemmodstamp
    ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM raw_event
  );

