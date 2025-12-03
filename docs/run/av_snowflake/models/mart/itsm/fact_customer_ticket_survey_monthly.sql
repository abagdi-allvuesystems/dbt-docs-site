
  
    

create or replace transient table AV_EDM.AV_ITSM.fact_customer_ticket_survey_monthly
    
    
    
    as (WITH fact_cust_ticket_survey AS (
    SELECT * FROM AV_EDM.AV_ITSM.fact_customer_ticket_survey
), customer_tickets_customers AS (
    SELECT * FROM AV_EDM.AV_ITSM.customer_tickets_customers
), jira_organization_mapping AS (
    SELECT * FROM AV_EDM.AV_ITSM.jira_organization_mapping
), dim_date AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_date
)
SELECT dd.first_date_of_month as date_id
    ,jom.assets_salesforce_account_id AS sf_account_id
    ,COUNT(fcts.customer_ticket_survey_id) as count_surveys_all
    ,SUM(is_completed_survey_count) AS count_surveys_completed
    ,ROUND(SUM(CSAT_RATING) / NULLIF(SUM(is_completed_survey_count),0),4) AS csat_rating_average
FROM fact_cust_ticket_survey fcts JOIN customer_tickets_customers ctc ON fcts.customer_ticket_id = ctc.issue_id
                                  JOIN jira_organization_mapping jom ON ctc.customer_field_id = jom.jira_customer_field_id
                                  JOIN dim_date dd ON fcts.date_id = dd.date
GROUP BY dd.first_date_of_month
        ,jom.assets_salesforce_account_id
    )
;


  