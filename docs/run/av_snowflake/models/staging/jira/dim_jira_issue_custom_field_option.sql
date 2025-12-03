
  create or replace   view AV_EDM.AV_STAGING.dim_jira_issue_custom_field_option
  
  
  
  
  as (
    WITH field_option AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_issue_custom_field_options
)

SELECT
        id
        ,context_id
        ,field_id
        ,value
        ,disabled
FROM
        field_option
  );

