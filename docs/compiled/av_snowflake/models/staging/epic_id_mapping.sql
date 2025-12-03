

WITH jira_epics AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_epics
), aha_features AS (
    SELECT *
    FROM AV_EDM.AV_STAGING.dim_aha_features
)

SELECT 
        HASH(je.issue_id,af.id)::INT as id
        ,je.issue_id as issue_id
        ,af.id as feature_id

FROM 
        aha_features af 
FULL OUTER JOIN 
        jira_epics je ON af.jira_epic_issue_id = je.issue_id