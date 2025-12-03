WITH cust_ticket_survey AS (
    SELECT * FROM AV_EDM.AV_ITSM.customer_ticket_surveys where is_closed_survey = true
)
SELECT SURVEY_CREATE_DATE::DATE as date_id
    ,survey_jira_id AS customer_ticket_survey_id
    ,customer_ticket_jira_id AS customer_ticket_id
    ,csat_rating_value AS csat_rating
    ,is_completed_survey AS is_completed_survey
    ,CASE WHEN is_completed_survey = true THEN 1 ELSE 0 END::INT AS is_completed_survey_count
    --survey_date_id
    --customer_ticket_id (null for NPS)
    --customer_id
    --survey_id
    --source_system
    --link
    --survey_type (nps, csat)
    --score
    --score_max_rating
    --is_completed_survey
    --

FROM cust_ticket_survey