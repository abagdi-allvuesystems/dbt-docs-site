WITH field_option AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_jira_issue_custom_field_options
)

SELECT
        id::INT AS id
        ,fieldid::VARCHAR AS field_id
        ,value::VARCHAR AS name
        ,disabled::BOOLEAN AS disabled
FROM
        field_option
WHERE   
        field_id = 'customfield_10116'