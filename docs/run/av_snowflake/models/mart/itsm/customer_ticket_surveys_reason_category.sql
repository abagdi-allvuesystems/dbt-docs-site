
  
    

create or replace transient table AV_EDM.AV_ITSM.customer_ticket_surveys_reason_category
    
    
    
    as (WITH dim_surveys_as AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_survey_components
)
SELECT  issue_id AS issue_id
       ,components_name as survey_reasons
      
FROM dim_surveys_as
    )
;


  