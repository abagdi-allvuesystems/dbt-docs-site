
  create or replace   view AV_EDM.AV_SYSTEM.jira_issue_custom_field_options
  
  
  
  
  as (
    WITH field_option AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_jira_issue_custom_field_options
), field_option_custom AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_jira_program_increment_options
)

SELECT
        id::INT AS id
        ,contextid::INT AS context_id
        ,fieldid::VARCHAR AS field_id
        ,value::VARCHAR AS value
        ,disabled::BOOLEAN AS disabled
FROM
        field_option

UNION

SELECT
        id::INT as id
        ,10750::INT AS context_id
        ,'customfield_10465'::VARCHAR AS field_id
        ,value::VARCHAR AS value
        ,disabled::BOOLEAN AS disabled
FROM
        field_option_custom
WHERE
        id not in (SELECT id FROM field_option)
  );

