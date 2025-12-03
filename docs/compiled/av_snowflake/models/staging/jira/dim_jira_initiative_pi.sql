WITH jira_initiatives AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_initiatives
)

SELECT 
        issue_id
        ,pi.value:id::INT AS pi_option_id
        ,pi.value:value::VARCHAR AS pi_value
        ,raw_updated
        
FROM 
        jira_initiatives,
        LATERAL FLATTEN( INPUT => program_increment ) AS pi