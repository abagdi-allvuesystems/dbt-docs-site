
  
    

create or replace transient table AV_EDM.AV_ITSM.customer_ticket_surveys
    
    
    
    as (WITH dim_surveys AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_surveys
), dim_customer_tickets AS (
    SELECT issue_id from AV_EDM.AV_STAGING.dim_jira_customer_tickets
)
select sur.id as survey_jira_id
      ,sur.key as survey_jira_key
      ,sur.issue_links_id as customer_ticket_jira_id
      ,sur.issue_links_key as customer_ticket_jira_key
      ,sur.csat_recipient_account_ids as csat_recipient_jira_account_id
      ,sur.csat_recipient_display_name as csat_recipient_display_name
      ,sur.csat_recipient_email_address as csat_recipient_email_address
      ,sur.customer_survey_rating as csat_rating_text
      ,sur.customer_survey_rating_value as csat_rating_value
      ,CASE WHEN sur.customer_survey_rating is not null THEN TRUE ELSE FALSE END as is_completed_survey
      ,CASE WHEN sur.status_name in ('Expired','Completed') THEN TRUE ELSE FALSE END AS is_closed_survey
      ,sur.status_name as survey_status
      ,sur.sys_created as survey_create_date
      ,sur.resolution_date as survey_closed_date
from dim_surveys sur JOIN dim_customer_tickets ct on sur.issue_links_id = ct.issue_id
    )
;


  