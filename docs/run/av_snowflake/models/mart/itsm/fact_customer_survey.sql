
  
    

create or replace transient table AV_EDM.AV_ITSM.fact_customer_survey
    
    
    
    as (WITH dim_jira_surveys AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_surveys
), dim_sf_nps_surveys AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_nps_surveys
), dim_customer_tickets AS (
    SELECT * FROM AV_EDM.AV_ITSM.dim_customer_tickets
), dim_customer_tickets_customers AS (
    SELECT * FROM AV_EDM.AV_ITSM.dim_customer_tickets_customers
), dim_customer_system_mapping AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_av_customer_system_mapping
)
SELECT nps.completion_date::DATE AS survey_date_id
    ,nps.survey_response_id::VARCHAR AS survey_id
    ,nps.name::VARCHAR AS survey_key
    ,'sf' AS source_system
    ,CONCAT('https://allvuesystems.lightning.force.com/lightning/r/Survey_Response__c/',nps.survey_response_id,'/view') AS survey_link
    ,'nps' AS survey_type
    ,csm.av_customer_id AS customer_id
    ,nps.account_name AS customer_name
    ,nps.contact_email AS customer_contact_email_address
    ,nps.contact_name AS customer_contact_display_name
    ,null AS customer_ticket_id
    ,nps.nps_score_state AS survey_rating_raw
    ,nps.how_likely_to_recommend_allvue AS survey_rating_value
    ,0::INT AS survey_rating_value_min
    ,10::INT AS survey_rating_value_max
   ,'Completed' AS survey_status
    ,'TRUE'::BOOLEAN AS is_completed_survey
    ,nps.closed_loop_notes as feedback_text
    ,NULL as dissatisfacation_category
FROM dim_sf_nps_surveys nps JOIN dim_customer_system_mapping csm ON nps.account_id = csm.sf_account_id
UNION
SELECT djs.resolution_date::DATE AS survey_date_id
    ,djs.id::VARCHAR AS survey_id
    ,djs.key::VARCHAR AS survey_key
    ,'jira' AS source_system
    ,CONCAT('https://allvuesystems.atlassian.net/browse/',djs.key) AS survey_link
    ,CASE WHEN ct.id is not null THEN 'csat-support' ELSE 'csat-cssd' END as survey_type
    ,ctc.customer_id AS customer_id
    ,ctc.customer_ticket_customer_name AS customer_name
    ,djs.csat_recipient_email_address AS customer_contact_email_address
    ,djs.csat_recipient_display_name AS customer_contact_display_name
    ,ct.id AS customer_ticket_id
    ,djs.customer_survey_rating AS survey_rating_raw
    ,djs.customer_survey_rating_value::INT AS survey_rating_value
    ,1::INT AS survey_rating_value_min
    ,5::INT AS survey_rating_value_max
    ,djs.status_name AS survey_status
    ,CASE WHEN djs.status_name = 'Completed' THEN TRUE ELSE FALSE END::BOOLEAN AS is_completed_survey
    ,djs.description_md as feedback_text
    ,djs.dissatisfaction_reason as dissatisfaction_category
FROM dim_jira_surveys djs JOIN dim_customer_tickets ct ON djs.issue_links_id = ct.system_ticket_id AND ct.source_system = 'jira'
                          LEFT JOIN dim_customer_tickets_customers ctc ON ct.id = ctc.customer_ticket_id
    )
;


  