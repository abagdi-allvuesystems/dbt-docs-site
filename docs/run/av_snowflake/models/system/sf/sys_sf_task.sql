
  create or replace   view AV_EDM.AV_SYSTEM.sys_sf_task
  
  
  
  
  as (
    WITH source_task AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_task
)

select
    -- identifiers
    id as task_id,
    ownerid as owner_id,
    accountid as account_id,
    whoid as person_id,
    whatid as related_object_id,
    recordtypeid as record_type_id,

    -- core activity fields
    subject,
    type as activity_type,
    tasksubtype as sub_type,
    status,
    priority,
    calltype as call_type,
    calldisposition as call_disposition,

    -- activity dates
    createddate as created_at,
    lastmodifieddate as last_modified_at,
    activitydate,
    completeddatetime as completed_at,
    reminderdatetime as reminder_at,

    -- booleans
    isclosed as is_closed,
    isdeleted as is_deleted,
    isarchived as is_archived,
    isreminderset as is_reminder_set,
    isrecurrence as is_recurrence,
    ishighpriority as is_high_priority,

    -- business context
    description,
    next_steps__c as next_steps,
    activity_type__c as sf_activity_type,
    activity_sub_type__c as sf_activity_sub_type,
    activity_unique_id__c as unique_activity_id,
    activity_count__c as activity_count,
    follow_up_email__c as follow_up_email,

    -- call / meeting metrics
    calldurationinseconds as call_duration_seconds,
    whocount as who_count,
    whatcount as what_count,

    -- Gong fields
    gong__call_outcome__c as gong_call_outcome,
    gong__activity_source__c as gong_activity_source,
    gong__current_flow_id__c as gong_flow_id,
    gong__gong_activity_id__c as gong_activity_id,
    gong__associated_accounts__c as gong_associated_accounts,
    gong__associated_opportunities__c as gong_associated_opportunities,
    gong__gong_participants_emails__c as gong_participant_emails,
    gong__meeting_reschedule_count__c as gong_reschedule_count,
    gong__meeting_prospect_canceled__c as gong_meeting_prospect_canceled,
    gong__gong_selected_process__c as gong_selected_process,

    -- attendees
    allvue_attendees__c as vendor_attendees,
    client_attendees__c as client_attendees,

    -- QS / coaching fields
    qs_coached_by__c as coached_by,
    qs_key_action__c as key_action,
    qs_related_stage__c as related_stage,
    qs_coaching_status__c as coaching_status,
    qs_sales_plan_task__c as is_sales_plan_task,
    qs_sales_activity_type__c as sales_activity_type,
    qs_date_of_coaching__c as coaching_date,
    qs_un_translated_action__c as untranslated_action,

    -- integrations
    outreach_id__c as outreach_id,

    -- metadata
    _airbyte_extracted_at,
FROM source_task
  );

