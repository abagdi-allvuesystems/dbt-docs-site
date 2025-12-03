
  create or replace   view AV_EDM.AV_STAGING.dim_jira_customer_survey_components
  
  
  
  
  as (
    WITH dim_surveys AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_customer_surveys
)
SELECT id AS issue_id,
comp.value:id::INT AS components_id,
comp.value:name::VARCHAR AS components_name

FROM dim_surveys,
        LATERAL FLATTEN(INPUT => dim_surveys.components) as comp
  );

