WITH raw_conversation AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_conversation
)
SELECT id AS id
    ,name::VARCHAR AS name
    ,gong__call_brief__c::VARCHAR AS gong_call_brief
    ,gong__call_duration_sec__c::FLOAT AS gong_call_duration_sec
    ,gong__call_duration__c::VARCHAR AS gong_call_duration
    ,gong__call_end__c::TIMESTAMP_TZ AS gong_call_end
    ,gong__call_id__c::VARCHAR AS gong_call_id
    ,gong__call_key_points__c::VARCHAR AS gong_call_key_points
    ,gong__call_outcome__c::VARCHAR AS gong_call_outcome
    ,gong__call_result__c::VARCHAR AS gong_call_result
    ,gong__call_start__c::TIMESTAMP_TZ AS gong_call_start
    ,gong__direction__c::VARCHAR AS gong_direction
    ,gong__economic_pulse_occurence__c::VARCHAR AS gong_economic_pulse_occurrence
    ,gong__gong_count__c::FLOAT AS gong_gong_count
    ,gong__opportunity_stage_now__c::VARCHAR AS gong_opportunity_stage_now
    ,gong__opp_amount_time_of_call__c::FLOAT AS gong_opp_amount_time_of_call
    ,gong__opp_close_date_time_of_call__c::DATE AS gong_opp_close_date_time_of_call
    ,gong__pricing_duration__c::FLOAT AS gong_pricing_duration
    ,gong__primary_user__c::VARCHAR AS gong_primary_user
    ,gong__related_leads_json__c::VARCHAR AS gong_related_leads_json
    ,gong__related_opportunities_json__c::VARCHAR AS gong_related_opportunities_json
    ,gong__related_participants_json__c::VARCHAR AS gong_related_participants_json
    ,gong__related_scorecards_json__c::VARCHAR AS gong_related_scorecards_json
    ,gong__related_stats_json__c::VARCHAR AS gong_related_stats_json
    ,gong__related_topics_json__c::VARCHAR AS gong_related_tasks_json
    ,gong__title__c::VARCHAR AS gong_title
    ,gong__view_call__c::VARCHAR AS gong_view_call
    ,ownerid::VARCHAR AS ownerid
    ,isdeleted::BOOLEAN AS isdeleted
    ,createddate::TIMESTAMP_TZ AS createddate
    ,systemmodstamp::TIMESTAMP_TZ AS systemmodstamp
    ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM raw_conversation