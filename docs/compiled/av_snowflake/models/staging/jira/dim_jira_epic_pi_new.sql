WITH jira_epics AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_epics
)

SELECT 
        issue_id
        ,pi.value:id::INT AS pi_option_id
        ,pi.value:value::VARCHAR AS pi_value
        ,raw_updated
        
FROM 
        jira_epics,
        LATERAL FLATTEN( INPUT => program_increment ) AS pi